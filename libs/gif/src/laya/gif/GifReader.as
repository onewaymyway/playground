package laya.gif
{	
	// (c) Dean McNamee <dean@gmail.com>, 2013.
	//
	// https://github.com/deanm/omggif
	//
	// Permission is hereby granted, free of charge, to any person obtaining a copy
	// of this software and associated documentation files (the "Software"), to
	// deal in the Software without restriction, including without limitation the
	// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
	// sell copies of the Software, and to permit persons to whom the Software is
	// furnished to do so, subject to the following conditions:
	//
	// The above copyright notice and this permission notice shall be included in
	// all copies or substantial portions of the Software.
	//
	// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
	// IN THE SOFTWARE.
	//
	// omggif is a JavaScript implementation of a GIF 89a encoder and decoder,
	// including animation and compression.  It does not rely on any specific
	// underlying system, so should run in the browser, Node, or Plask.
	public class GifReader
	{
		public var buf:Uint8Array;
		public var width:int;
		public var height:int;
		public var frames:Array;
		public var loop_count:int;
		public function GifReader(buf:Uint8Array)
		{
			var p:int = 0;
			this.buf = buf;
			// - Header (GIF87a or GIF89a).
			if (buf[p++] !== 0x47 || buf[p++] !== 0x49 || buf[p++] !== 0x46 || buf[p++] !== 0x38 || (buf[p++] + 1 & 0xfd) !== 0x38 || buf[p++] !== 0x61)
			{
				throw new Error("Invalid GIF 87a/89a header.");
			}		
			width = buf[p++] | buf[p++] << 8;
			height = buf[p++] | buf[p++] << 8;
			var pf0:int = buf[p++]; // <Packed Fields>.
			var global_palette_flag:int = pf0 >> 7;
			var num_global_colors_pow2:int = pf0 & 0x7;
			var num_global_colors:int = 1 << (num_global_colors_pow2 + 1);
			var background:int = buf[p++];
			buf[p++]; // Pixel aspect ratio (unused?).			
			var global_palette_offset:int = null;		
			if (global_palette_flag)
			{
				global_palette_offset = p;
				p += num_global_colors * 3; // Seek past palette.
			}			
			var no_eof:Boolean = true;			
			frames = [];			
			var delay:int = 0;
			var transparent_index:int = null;
			var disposal:int = 0; // 0 - No disposal specified.
			loop_count = null;			
			while (no_eof && p < buf.length)
			{
				switch (buf[p++])
				{
					case 0x21: // Graphics Control Extension Block
						switch (buf[p++])
						{
							case 0xff: // Application specific block
								if (buf[p] !== 0x0b || // 21 FF already read, check block size.
									// NETSCAPE2.0
									buf[p + 1] == 0x4e && buf[p + 2] == 0x45 && buf[p + 3] == 0x54 && buf[p + 4] == 0x53 && buf[p + 5] == 0x43 && buf[p + 6] == 0x41 && buf[p + 7] == 0x50 && buf[p + 8] == 0x45 && buf[p + 9] == 0x32 && buf[p + 10] == 0x2e && buf[p + 11] == 0x30 && 
									// Sub-block
									buf[p + 12] == 0x03 && buf[p + 13] == 0x01 && buf[p + 16] == 0)
								{
									p += 14;
									loop_count = buf[p++] | buf[p++] << 8;
									p++; // Skip terminator.
								}
								else
								{ // We don't know what it is, just try to get past it.
									p += 12;
									while (true)
									{ // Seek through subblocks.
										var block_size:int = buf[p++];
										if (block_size === 0)
											break;
										p += block_size;
									}
								}
								break;
							
							case 0xf9: // Graphics Control Extension
								if (buf[p++] !== 0x4 || buf[p + 4] !== 0)
									throw new Error("Invalid graphics extension block.");
								var pf1:int = buf[p++];
								delay = buf[p++] | buf[p++] << 8;
								transparent_index = buf[p++];
								if ((pf1 & 1) === 0)
									transparent_index = null;
								disposal = pf1 >> 2 & 0x7;
								p++; // Skip terminator.
								break;
							
							case 0xfe: // Comment Extension.
								while (true)
								{ // Seek through subblocks.
									var block_size = buf[p++];
									if (block_size === 0)
										break;
									p += block_size;
								}
								break;
							
							default: 
								throw new Error("Unknown graphic control label: 0x" + buf[p - 1].toString(16));
						}
						break;
					
					case 0x2c: // Image Descriptor.
						var x:int = buf[p++] | buf[p++] << 8;
						var y:int = buf[p++] | buf[p++] << 8;
						var w:int = buf[p++] | buf[p++] << 8;
						var h:int = buf[p++] | buf[p++] << 8;
						var pf2:int = buf[p++];
						var local_palette_flag:int = pf2 >> 7;
						var interlace_flag:int = pf2 >> 6 & 1;
						var num_local_colors_pow2:int = pf2 & 0x7;
						var num_local_colors:int = 1 << (num_local_colors_pow2 + 1);
						var palette_offset:int = global_palette_offset;
						var has_local_palette:Boolean = false;
						if (local_palette_flag)
						{
							var has_local_palette:Boolean = true;
							palette_offset = p; // Override with local palette.
							p += num_local_colors * 3; // Seek past palette.
						}
						
						var data_offset:int = p;
						
						p++; // codesize
						while (true)
						{
							var block_size:int = buf[p++];
							if (block_size === 0)
								break;
							p += block_size;
						}
						
						frames.push({x: x, y: y, width: w, height: h, has_local_palette: has_local_palette, palette_offset: palette_offset, data_offset: data_offset, data_length: p - data_offset, transparent_index: transparent_index, interlaced: !!interlace_flag, delay: delay, disposal: disposal});
						break;
					
					case 0x3b: // Trailer Marker (end of file).
					no_eof = false;
					break;
					
					default: 
					throw new Error("Unknown gif block: 0x" + buf[p - 1].toString(16));
					break;
				}
			}
		}		
		public function numFrames():int
		{
			return frames.length;
		}	
		public function loopCount():int
		{
			return loop_count;
		}		
		public function frameInfo(frame_num:int):Object
		{
			if (frame_num < 0 || frame_num >= frames.length)
				throw new Error("Frame index out of range.");
			return frames[frame_num];
		}		
		public function decodeAndBlitFrameRGBA(frame_num:int, pixels:*):void
		{
			var frame:Object = this.frameInfo(frame_num);
			var num_pixels:int = frame.width * frame.height;
			var index_stream:Uint8Array = new Uint8Array(num_pixels); // At most 8-bit indices.
			_gifReaderLZWOutputIndexStream(buf, frame.data_offset, index_stream, num_pixels);
			var palette_offset:int = frame.palette_offset;		
			var trans:int = frame.transparent_index;
			if (trans === null)
				trans = 256;			
			var framewidth:int = frame.width;
			var framestride:int = width - framewidth;
			var xleft:int = framewidth; // Number of subrect pixels left in scanline.			
			var opbeg:int = ((frame.y * width) + frame.x) * 4;
			var opend :int= ((frame.y + frame.height) * width + frame.x) * 4;
			var op:int = opbeg;			
			var scanstride:int = framestride * 4;			
			if (frame.interlaced === true)
			{
				scanstride += width * 4 * 7; // Pass 1.
			}		
			var interlaceskip:int = 8; // Tracking the row interval in the current pass.		
			for (var i:int = 0, il = index_stream.length; i < il; ++i)
			{
				var index:int = index_stream[i];				
				if (xleft === 0)
				{ // Beginning of new scan line
					op += scanstride;
					xleft = framewidth;
					if (op >= opend)
					{ // Catch the wrap to switch passes when interlacing.
						scanstride = framestride * 4 + width * 4 * (interlaceskip - 1);
						// interlaceskip / 2 * 4 is interlaceskip << 1.
						op = opbeg + (framewidth + framestride) * (interlaceskip << 1);
						interlaceskip >>= 1;
					}
				}				
				if (index === trans)
				{
					op += 4;
				}
				else
				{
					var r:int = buf[palette_offset + index * 3];
					var g:int = buf[palette_offset + index * 3 + 1];
					var b:int = buf[palette_offset + index * 3 + 2];
					pixels[op++] = r;
					pixels[op++] = g;
					pixels[op++] = b;
					pixels[op++] = 255;
				}
				--xleft;
			}
		}
		
		private static function _gifReaderLZWOutputIndexStream(code_stream:Uint8Array, p:int, output:Uint8Array, output_length:int)
		{
			var min_code_size :int= code_stream[p++];			
			var clear_code:int = 1 << min_code_size;
			var eoi_code:int = clear_code + 1;
			var next_code:int = eoi_code + 1;			
			var cur_code_size:int = min_code_size + 1; 
			var code_mask:int = (1 << cur_code_size) - 1;
			var cur_shift :int= 0;
			var cur:int = 0;		
			var op:int = 0; 		
			var subblock_size:int = code_stream[p++];			
			var code_table:*;
			__JS__("code_table=new Int32Array(4096)");
			var prev_code:int = null; 
			
			while (true)
			{
				while (cur_shift < 16)
				{
					if (subblock_size === 0)
						break; 
					
					cur |= code_stream[p++] << cur_shift;
					cur_shift += 8;
					
					if (subblock_size === 1)
					{ 
						subblock_size = code_stream[p++]; 
					}
					else
					{
						--subblock_size;
					}
				}
				
				if (cur_shift < cur_code_size)
					break;
				
				var code:int = cur & code_mask;
				cur >>= cur_code_size;
				cur_shift -= cur_code_size;
				
				if (code === clear_code)
				{
					
					next_code = eoi_code + 1;
					cur_code_size = min_code_size + 1;
					code_mask = (1 << cur_code_size) - 1;
					prev_code = null;
					continue;
				}
				else if (code === eoi_code)
				{
					break;
				}
				
				var chase_code:int = code < next_code ? code : prev_code;				
				var chase_length:int = 0;
				var chase:int = chase_code;
				while (chase > clear_code)
				{
					chase = code_table[chase] >> 8;
					++chase_length;
				}
				
				var k:int = chase;
				
				var op_end:int = op + chase_length + (chase_code !== code ? 1 : 0);
				if (op_end > output_length)
				{
					trace("Warning, gif stream longer than expected.");
					return;
				}
				output[op++] = k;		
				op += chase_length;
				var b:int = op; // Track pointer, writing backwards.			
				if (chase_code !== code) // The case of emitting {CODE-1} + k.
					output[op++] = k;
				
				chase = chase_code;
				while (chase_length--)
				{
					chase = code_table[chase];
					output[--b] = chase & 0xff; // Write backwards.
					chase >>= 8; // Pull down to the prefix code.
				}
				
				if (prev_code !== null && next_code < 4096)
				{
					code_table[next_code++] = prev_code << 8 | k;
					
					if (next_code >= code_mask + 1 && cur_code_size < 12)
					{
						++cur_code_size;
						code_mask = code_mask << 1 | 1;
					}
				}
				
				prev_code = code;
			}
			
			if (op !== output_length)
			{
				trace("Warning, gif stream shorter than expected.");
			}
			
			return output;
		}
		
	}
	
}