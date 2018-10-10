package testcodes 
{
	import wraps.SourceMapTool;
	/**
	 * ...
	 * @author ww
	 */
	public class TestSourceMap 
	{
		
		public function TestSourceMap() 
		{
			Laya.init(1000, 900);
			testCreateSourceMap();
		}
		
		
		private function testCreateSourceMap():void
		{
			var sourceMap:SourceMapTool;
			sourceMap = new SourceMapTool();
			
			//执行的js文件
			sourceMap.file = "code.adpt.js";
			//根路径
			sourceMap.sourceRoot = "";

			//添加映射的文件
			sourceMap.addSourceFile("code.t");
			
			//添加一行映射，当前第1行
			sourceMap.addLine();
			//sourceMap.addMappingPoint(0, 0, 0);
			//sourceMap.addMappintPointEx(0, 0, 0);
			//添加映射位置
			sourceMap.addMappintPointEx(0, 0, 0,null,"code.t");
			sourceMap.addMappingPoint(8, 0, 12);
			
			//添加一行映射，当前第2行
			sourceMap.addLine();
			//sourceMap.addMappingPoint(7,3, 0);
			sourceMap.addMappintPointEx(7, 3, 0);
			
			//添加一行映射，当前第3行
			sourceMap.addLine();
			//sourceMap.addMappingPoint(4, 7, 3);
			//sourceMap.addMappingPoint(8, 7, 6);
			
			sourceMap.addMappintPointEx(4, 7, 3);
			sourceMap.addMappintPointEx(8, 7, 6);
			
			//添加一行映射，当前第5行
			//直接跳到第五行
			sourceMap.addLine(4);
			//sourceMap.addMappingPoint(0, 11, 0);
			//sourceMap.addMappingPoint(9, 12, 0);
			
			sourceMap.addMappintPointEx(0, 11, 0);
			sourceMap.addMappintPointEx(9, 12, 0);

//<script src='code.adpt.js' loader='laya'></script>
			trace(sourceMap.createSouceMap());
			trace(sourceMap.createSourceMapStr());
		}
	}

}