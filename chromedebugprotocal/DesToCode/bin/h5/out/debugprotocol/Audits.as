package debugprotocol.Audits 
{



	public class Audits 
	{
		
		public function Audits() 
		{
			
		}
		public static const DependDomains:Array=[Network];
  	
  	
  		/**
  		 * getEncodedResponse
  		 * Returns the response body and size if it were re-encoded with the specified settings. Only
  	applies to images.
  		 * @param requestId:{#@type#} optional:{#@optional#} Identifier of the network request to get content for.
  		 * @param encoding:string optional:{#@optional#} The encoding to use.
  		 * @param quality:number optional:true The quality of the encoding (0-1). (defaults to 1)
  		 * @param sizeOnly:boolean optional:true Whether to only return the size information (defaults to false).
  		 * @return body:string optional:true The encoded body as a base64 string. Omitted if sizeOnly is true.
  		 */
  		public static const getEncodedResponse:String = "Audits.getEncodedResponse";
	}

}