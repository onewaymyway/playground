package {
      import remotedebugtool.ui.remotedebugtool.EditorViewItemUI;	
	/**
	 * 游戏初始化配置
	 */
	public class GameConfig {
		public static var width:int = 1136;
		public static var height:int = 640;
		public static var scaleMode:String = "showall";
		public static var screenMode:String = "none";
		public static var alignV:String = "top";
		public static var alignH:String = "left";
		public static var startScene:* = EditorViewItemUI;
		public static var sceneRoot:String = "";
		public static var debug:Boolean = false;
		public static var stat:Boolean = false;
	}
}