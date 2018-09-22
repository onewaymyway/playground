package debugprotocol 
{



	public class Security 
	{
		
		public function Security() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * certificateError
  		 * There is a certificate error. If overriding certificate errors is enabled, then it should be
  	handled with the `handleCertificateError` command. Note: this event does not fire if the
  	certificate error has been allowed internally. Only one client per target should override
  	certificate errors at the same time.
  		 * @param eventId:integer optional:{#@optional#} The ID of the event.
  		 * @param errorType:string optional:{#@optional#} The type of the error.
  		 * @param requestURL:string optional:{#@optional#} The url that was requested.
  		 * @return 
  		 */
  		public static const certificateError:String = "Security.certificateError";
  	
  		/**
  		 * securityStateChanged
  		 * The security state of the page changed.
  		 * @param securityState:{#@type#} optional:{#@optional#} Security state.
  		 * @param schemeIsCryptographic:boolean optional:{#@optional#} True if the page was loaded over cryptographic transport such as HTTPS.
  		 * @param explanations:array optional:{#@optional#} List of explanations for the security state. If the overall security state is `insecure` or
  	`warning`, at least one corresponding explanation should be included.
  		 * @param insecureContentStatus:{#@type#} optional:{#@optional#} Information about insecure content on the page.
  		 * @param summary:string optional:true Overrides user-visible description of the state.
  		 * @return 
  		 */
  		public static const securityStateChanged:String = "Security.securityStateChanged";
  	
  		/**
  		 * disable
  		 * Disables tracking security state changes.
  		 * @return 
  		 */
  		public static const disable:String = "Security.disable";
  	
  		/**
  		 * enable
  		 * Enables tracking security state changes.
  		 * @return 
  		 */
  		public static const enable:String = "Security.enable";
  	
  		/**
  		 * setIgnoreCertificateErrors
  		 * Enable/disable whether all certificate errors should be ignored.
  		 * @param ignore:boolean optional:{#@optional#} If true, all certificate errors will be ignored.
  		 * @return 
  		 */
  		public static const setIgnoreCertificateErrors:String = "Security.setIgnoreCertificateErrors";
  	
  		/**
  		 * handleCertificateError
  		 * Handles a certificate error that fired a certificateError event.
  		 * @param eventId:integer optional:{#@optional#} The ID of the event.
  		 * @param action:{#@type#} optional:{#@optional#} The action to take on the certificate error.
  		 * @return 
  		 */
  		public static const handleCertificateError:String = "Security.handleCertificateError";
  	
  		/**
  		 * setOverrideCertificateErrors
  		 * Enable/disable overriding certificate errors. If enabled, all certificate error events need to
  	be handled by the DevTools client and should be answered with `handleCertificateError` commands.
  		 * @param override:boolean optional:{#@optional#} If true, certificate errors will be overridden.
  		 * @return 
  		 */
  		public static const setOverrideCertificateErrors:String = "Security.setOverrideCertificateErrors";
	}

}