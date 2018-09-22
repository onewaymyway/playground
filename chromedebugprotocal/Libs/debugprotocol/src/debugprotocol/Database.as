package debugprotocol 
{



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
  		public static const disable:String = "Database.disable";
  	
  		/**
  		 * enable
  		 * Enables database tracking, database events will now be delivered to the client.
  		 * @return 
  		 */
  		public static const enable:String = "Database.enable";
  	
  		/**
  		 * executeSQL
  		 * @param databaseId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @param query:string optional:{#@optional#} {#@description#}
  		 * @return columnNames:array optional:true {#@description#}
  		 */
  		public static const executeSQL:String = "Database.executeSQL";
  	
  		/**
  		 * getDatabaseTableNames
  		 * @param databaseId:{#@type#} optional:{#@optional#} {#@description#}
  		 * @return tableNames:array optional:{#@optional#} {#@description#}
  		 */
  		public static const getDatabaseTableNames:String = "Database.getDatabaseTableNames";
	}

}