package commontools {
	import laya.display.Sprite;
	import laya.ui.Image;
	
	/**
	 * ...
	 * @author ww
	 */
	public class SwitchItem {
		
		public function SwitchItem() {
		
		}
		
		public var des:*;
		public var isSelected:Boolean = false;
		public function setState(isSelect:Boolean = true):void {
			isSelected = isSelect;
			if (des is Array) {
				des[0].visible = !isSelect;
				des[1].visible = isSelect;
			}
			else if (des.selectType) {
				var tConfigO:Object = des;
				 tConfigO.tar[tConfigO.key] = tConfigO.values[isSelect ? 1 : 0];
			}
			else {
				des.visible = isSelect;
			}
		}
		
		public static function createBySprite(item:Sprite,isSelect:Boolean=true):SwitchItem
		{
			var switcher:SwitchItem;
			switcher = new SwitchItem();
			switcher.des = [item.getChildByName("state0"), item.getChildByName("state1")];
			switcher.setState(isSelect);
			return switcher;
		}
		
		public static function createByValueKey(item:*, key:String,values:Array, isSelect:Boolean = true,switcher:SwitchItem=null):SwitchItem
		{
			if(!switcher)
			switcher = new SwitchItem();
			switcher.des = SwitchGroup.createSignObject(item,key,values);
			switcher.setState(isSelect);
			return switcher;
		}
	}

}