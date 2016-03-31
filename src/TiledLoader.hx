package ;

class TiledLoader {
	public function new (){

	}
	public function load_json (object:Dynamic){
		//var object = haxe.Json.parse(json);

		var map_width = object.layers[0].width;
		var map_height = object.layers[0].height;
		var data = object.layers[0].data;

		var map_tiles = new Array< Array<Int> >();

		for (x in 0...map_width){
			map_tiles[x] = new Array<Int>();
			for (y in 0...map_height){
				map_tiles[x][y] = data[y*map_width+x];
			}
		}

		return map_tiles;

	}
	public function load_tmx (tmx:String){
		throw "tmx is not yet supported. JSON is though, and tiled exports to JSON";
	}
}
