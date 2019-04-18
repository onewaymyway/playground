package wraps.recorder {
	
	/**
	 * ...
	 * @author ww
	 */
	public class AudioData {
		
		public function AudioData() {
		
		}
		public var size:int = 0;
		public var buffer:Array = [];
		public var inputSampleRate:int;
		public var inputSampleBits:int = 16;
		public var outputSampleRate:int;
		public var outputSampleBits:int = 16;
		
		public function input(data:Array):void {
			this.buffer.push(new Float32Array(data));
			this.size += data.length;
		}
		public function reset():void
		{
			size = 0;
			buffer.length = 0;
		}
		public function compress():Float32Array {
			//合并  
			var data = new Float32Array(this.size);
			var offset = 0;
			for (var i = 0; i < this.buffer.length; i++) {
				data.set(this.buffer[i], offset);
				offset += this.buffer[i].length;
			}
			//压缩  
			var compression = Math.floor(this.inputSampleRate / this.outputSampleRate);
			var length = data.length / compression;
			var result = new Float32Array(length);
			var index = 0, j = 0;
			while (index < length) {
				result[index] = data[j];
				j += compression;
				index++;
			}
			return result;
		}
		
		public function encodeWAV():* {
			var sampleRate = Math.min(this.inputSampleRate, this.outputSampleRate);
			var sampleBits = Math.min(this.inputSampleBits, this.outputSampleBits);
			var bytes = this.compress();
			var dataLength = bytes.length * (sampleBits / 8);
			var buffer = new ArrayBuffer(44 + dataLength);
			var data = new DataView(buffer);
			
			var channelCount = 1; //单声道  
			var offset = 0;
			
			var writeString = function(str) {
				for (var i = 0; i < str.length; i++) {
					data.setUint8(offset + i, str.charCodeAt(i));
				}
			};
			
			// 资源交换文件标识符   
			writeString('RIFF');
			offset += 4;
			// 下个地址开始到文件尾总字节数,即文件大小-8   
			data.setUint32(offset, 36 + dataLength, true);
			offset += 4;
			// WAV文件标志  
			writeString('WAVE');
			offset += 4;
			// 波形格式标志   
			writeString('fmt ');
			offset += 4;
			// 过滤字节,一般为 0x10 = 16   
			data.setUint32(offset, 16, true);
			offset += 4;
			// 格式类别 (PCM形式采样数据)   
			data.setUint16(offset, 1, true);
			offset += 2;
			// 通道数   
			data.setUint16(offset, channelCount, true);
			offset += 2;
			// 采样率,每秒样本数,表示每个通道的播放速度   
			data.setUint32(offset, sampleRate, true);
			offset += 4;
			// 波形数据传输率 (每秒平均字节数) 单声道×每秒数据位数×每样本数据位/8   
			data.setUint32(offset, channelCount * sampleRate * (sampleBits / 8), true);
			offset += 4;
			// 快数据调整数 采样一次占用字节数 单声道×每样本的数据位数/8   
			data.setUint16(offset, channelCount * (sampleBits / 8), true);
			offset += 2;
			// 每样本数据位数   
			data.setUint16(offset, sampleBits, true);
			offset += 2;
			// 数据标识符   
			writeString('data');
			offset += 4;
			// 采样数据总数,即数据总大小-44   
			data.setUint32(offset, dataLength, true);
			offset += 4;
			// 写入采样数据   
			if (sampleBits === 8) {
				for (var i = 0; i < bytes.length; i++, offset++) {
					var s = Math.max(-1, Math.min(1, bytes[i]));
					var val = s < 0 ? s * 0x8000 : s * 0x7FFF;
					val = Math.floor(255 / (65535 / (val + 32768)));
					data.setInt8(offset, val, true);
				}
			}
			else {
				for (var i = 0; i < bytes.length; i++, offset += 2) {
					var s = Math.max(-1, Math.min(1, bytes[i]));
					data.setInt16(offset, s < 0 ? s * 0x8000 : s * 0x7FFF, true);
				}
			}
			return data;
			return new Blob([data], {type: 'audio/wav'});
		}
		
		
	}

}