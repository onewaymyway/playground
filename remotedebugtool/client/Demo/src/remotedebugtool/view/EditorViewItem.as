package remotedebugtool.view 
{
	import remotedebugtool.ui.remotedebugtool.EditorViewItemUI;
	
	/**
	 * ...
	 * @author ww
	 */
	public class EditorViewItem extends EditorViewItemUI 
	{
		
		public function EditorViewItem() 
		{
			
		}
		
		private var tDataO:Object;
		public function initByData(dataO:Object):void
		{
			tDataO = dataO;
			debugger;
			label.text = dataO.path;
			if (label.text.length > 20)
			{
				label.text = label.text.substr(label.text.length-20);
			}
		}
		
	}

}