package laya.tile {
	import laya.net.Loader;
	import laya.renders.Render;
	import laya.resource.Texture;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ww
	 */
	public class TileDataParser {
		
		public function TileDataParser() {
		
		}
		public var url:String;
		public var _pathArray:Array;
		public var _resPath:String;
		public var loadedTexturs:Array;
		public var jsonData:Object;
		public var textureList:Array;
		public var completeHandler:Handler;
		public var enableLinear:Boolean = true;
		public function loadTileMapData(url:String, complete:Handler = null,enableLinear:Boolean=true):void {
			this.url = url;
			this.enableLinear = enableLinear;
			this.completeHandler = complete;
			var tIndex:int = url.lastIndexOf("/");
			if (tIndex > -1) {
				_resPath = url.substr(0, tIndex);
				_pathArray = _resPath.split("/");
			}
			else {
				_resPath = "";
				_pathArray = [];
			}
			Laya.loader.load(url, Handler.create(this, onJsonComplete), null, Loader.JSON);
		}
		
		private var _tileSetArray:Array = [];
		
		/**
		 * json文件读取成功后，解析里面的纹理数据，进行加载
		 * @param	e JSON数据
		 */
		private function onJsonComplete(e:*):void {
			var tJsonData:* = jsonData = e;
			
			var tArray:Array = tJsonData.tilesets;
			var tileset:*;
			var tTileSet:TileSet;
			var i:int = 0;
			for (i = 0; i < tArray.length; i++) {
				tileset = tArray[i];
				tTileSet = new TileSet();
				tTileSet.init(tileset);
				_tileSetArray.push(tTileSet);
				//动画数据
				var tTiles:* = tileset.tiles;
			}
			textureList = [];
			loadedTexturs = [];
			//_tileTexSetArr.push(null);
			if (_tileSetArray.length > 0) {
				tTileSet = _currTileSet = _tileSetArray.shift();
				_loader = new Loader();
				_loader.once("complete", this, onTextureComplete);
				var tPath:String = mergePath(_resPath, tTileSet.image);
				_loader.load(tPath, Loader.IMAGE, false);
			}
		}
		
		/**
		 * 合并路径
		 * @param	resPath
		 * @param	relativePath
		 * @return
		 */
		private function mergePath(resPath:String, relativePath:String):String {
			var tResultPath:String = "";
			var tImageArray:Array = relativePath.split("/");
			var tParentPathNum:int = 0;
			var i:int = 0;
			for (i = tImageArray.length - 1; i >= 0; i--) {
				if (tImageArray[i] == "..") {
					tParentPathNum++;
				}
			}
			if (tParentPathNum == 0) {
				if (_pathArray.length > 0) {
					tResultPath = resPath + "/" + relativePath;
				}
				else {
					tResultPath = relativePath;
				}
				
				return tResultPath;
			}
			var tSrcNum:int = _pathArray.length - tParentPathNum;
			if (tSrcNum < 0) {
				trace("[error]path does not exist");
			}
			for (i = 0; i < tSrcNum; i++) {
				if (i == 0) {
					tResultPath += _pathArray[i];
				}
				else {
					tResultPath = tResultPath + "/" + _pathArray[i];
				}
			}
			for (i = tParentPathNum; i < tImageArray.length; i++) {
				tResultPath = tResultPath + "/" + tImageArray[i];
			}
			return tResultPath;
		}
		private var _currTileSet:TileSet;
		private var _loader:Loader;
		/**
		 * 纹理加载完成，如果所有的纹理加载，开始初始化地图
		 * @param	e 纹理数据
		 */
		private function onTextureComplete(e:*):void {
			var json:* = jsonData;
			var tTexture:Texture = e;
			if (Render.isWebGL&&enableLinear) {
				tTexture.bitmap.minFifter = 0x2600;
				tTexture.bitmap.magFifter = 0x2600;
				tTexture.bitmap.enableMerageInAtlas = false;
			}
			loadedTexturs.push(tTexture);
			//var tVersion:int = json.viersion;
			var tTileSet:TileSet = _currTileSet;
			var tTileTextureW:int = tTileSet.tilewidth;
			var tTileTextureH:int = tTileSet.tileheight;
			var tImageWidth:int = tTileSet.imagewidth;
			var tImageHeight:int = tTileSet.imageheight;
			var tFirstgid:int = tTileSet.firstgid;
			
			var tTileWNum:int = Math.floor((tImageWidth - tTileSet.margin - tTileTextureW) / (tTileTextureW + tTileSet.spacing)) + 1;
			var tTileHNum:int = Math.floor((tImageHeight - tTileSet.margin - tTileTextureH) / (tTileTextureH + tTileSet.spacing)) + 1;
			var tTexutre:Texture;
			for (var i:int = 0; i < tTileHNum; i++) {
				for (var j:int = 0; j < tTileWNum; j++) {
					tTexutre = Texture.createFromTexture(tTexture, tTileSet.margin + (tTileTextureW + tTileSet.spacing) * j, tTileSet.margin + (tTileTextureH + tTileSet.spacing) * i, tTileTextureW, tTileTextureH);
					textureList.push(tTexutre);
				}
			}
			
			if (_tileSetArray.length > 0) {
				tTileSet = _currTileSet = _tileSetArray.shift();
				_loader.once("complete", this, onTextureComplete);
				var tPath:String = mergePath(_resPath, tTileSet.image);
				_loader.load(tPath, Loader.IMAGE, false);
			}
			else {
				_currTileSet = null;
				if (completeHandler) {
					completeHandler.run();
				}
			}
		}
	}

}

class TileSet {
	
	public var firstgid:int = 0;
	public var image:String = "";
	public var imageheight:int = 0;
	public var imagewidth:int = 0;
	public var margin:int = 0;
	public var name:int = 0;
	public var properties:*;
	public var spacing:int = 0;
	public var tileheight:int = 0;
	public var tilewidth:int = 0;
	
	public var titleoffsetX:int = 0;
	public var titleoffsetY:int = 0;
	public var tileproperties:*;
	
	public function init(data:*):void {
		firstgid = data.firstgid;
		image = data.image;
		imageheight = data.imageheight;
		imagewidth = data.imagewidth;
		margin = data.margin;
		name = data.name;
		properties = data.properties;
		spacing = data.spacing;
		tileheight = data.tileheight;
		tilewidth = data.tilewidth;
		
		//自定义属性
		tileproperties = data.tileproperties;
		var tTileoffset:* = data.tileoffset;
		if (tTileoffset) {
			titleoffsetX = tTileoffset.x;
			titleoffsetY = tTileoffset.y;
		}
	}
}