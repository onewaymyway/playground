package debugprotocol 
{
	import chromedebug.ChromeMsg;



	public class Database 
	{
		
		public function Database() 
		{
			
		}
		public static const DependDomains:Array=[];
  	
  		/**
  		 * addDatabase
  		 * @param database:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return 
  		 */
  		public static const addDatabase:String = "Database.addDatabase";
  		/**
  		 * disable
  		 * Disables database tracking, prevents database events from being sent to the client.
  		 * @return 
  		 */	
  		public static function disable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Database.disable", paramO);
  		}
  		
  		/**
  		 * enable
  		 * Enables database tracking, database events will now be delivered to the client.
  		 * @return 
  		 */	
  		public static function enable(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Database.enable", paramO);
  		}
  		
  		/**
  		 * executeSQL
  		 * @param databaseId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param query:string optional:{#@optional#} {#@description#}
  		 * @return columnNames:array optional:true {#@description#}
  		 */	
  		public static function executeSQL(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Database.executeSQL", paramO);
  		}
  		
  		/**
  		 * getDatabaseTableNames
  		 * @param databaseId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return tableNames:array optional:{#@optional#} {#@description#}
  		 */	
  		public static function getDatabaseTableNames(paramO:Object):Promise
  		{
  			return ChromeMsg.callCmd("Database.getDatabaseTableNames", paramO);
  		}
  		
	}

}