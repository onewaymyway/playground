package scenetools 
{
	import laya.ui.Box;
	import laya.ui.Dialog;
	/**
	 * ...
	 * @author ww
	 */
	public class SceneSwitcher 
	{
		public static var I:SceneSwitcher;
		private var container:Box;
		public function SceneSwitcher() 
		{
			init();
		}
		
		public function init():void
		{
			container = new Box();
			container.left = container.right = container.top = container.bottom = 0;
			Laya.stage.addChild(container);
		}
		
		public function getItem(clz:Class, isInstance:Boolean):*
		{
			var sp:*;
			if (!isInstance)
			{
				sp = new clz();
			}else
			{
				if (!clz["I"])
				{
					clz["I"] = new clz();
				}
				sp = clz["I"];
			}
			return sp;
		}
		public function showDialog(clz:Class, param:*= null, closeOthers:Boolean = true, isInstance:Boolean = true):*
		{
			var sp:Dialog;
			sp = getItem(clz, isInstance);
			if (param !== null)
			{
				if (sp["onSetParam"])
				{
					sp["onSetParam"](param);
				}
			}
			sp.popup(closeOthers);
		}
		public function showPage(clz:Class, param:*=null, closeOthers:Boolean=true,isInstance:Boolean = true):*
		{
			var sp:*;
			sp = getItem(clz, isInstance);
			if (closeOthers)
			{
				container.removeChildren();
			}
			container.addChild(sp);
			if (param !== null)
			{
				if (sp["onSetParam"])
				{
					sp["onSetParam"](param);
				}
			}
			return sp;
		}
	}

}