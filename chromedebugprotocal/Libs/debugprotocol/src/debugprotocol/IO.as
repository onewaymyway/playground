package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class IO 
	{
		
		public function IO() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * close
  		 * Close the stream, discard any temporary backing storage.
  		 * @param handle:{#@type#} optional:{#@optional#} Handle of the stream to close.
  		 * @return 
  		 */	
  		public static function close(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IO.close", paramO);
  		}
  		
  		/**
  		 * read
  		 * Read a chunk of the stream
  		 * @param handle:{#@type#} optional:{#@optional#} Handle of the stream to read.
  		 * @param offset:integer optional:true Seek to the specified offset before reading (if not specificed, proceed with offset
  	following the last read). Some types of streams may only support sequential reads.
  		 * @param size:integer optional:true Maximum number of bytes to read (left upon the agent discretion if not specified).
  		 * @return base64Encoded:boolean optional:true Set if the data is base64-encoded
  		 */	
  		public static function read(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IO.read", paramO);
  		}
  		
  		/**
  		 * resolveBlob
  		 * Return UUID of Blob object specified by a remote object id.
  		 * @param objectId:{#@type#} optional:{#@optional#} Object id of a Blob object wrapper.
  		 * @return uuid:string optional:{#@optional#} UUID of the specified Blob.
  		 */	
  		public static function resolveBlob(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("IO.resolveBlob", paramO);
  		}
  		
	}

}