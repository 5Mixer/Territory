package ;

import Chunk;

class Layer {
	public var chunks:Map<ChunkRegion,Chunk>;
	public var name:String;
	public var renderables:Array<IRenderable>;

	public function new (_name:String){
		chunks = new Map<ChunkRegion,Chunk>();
		renderables = new Array<IRenderable>();
		name = _name;

		setup();
	}

	public function setup (){
		for (x in 0...9){
            for (y in 0...7){
                chunks.set({x:x,y:y},new Chunk({x:x,y:y}));
            }
        }
	}

	public function render () {
		clear();
		for (renderable in renderables){
			renderable.render(this);
		}
	}

	//:TODO: This is probably slow and a bad way of doing stuff.
	public function get_chunk (pos:ChunkRegion){
		for (chunk in chunks.keys()){
			if (chunk.x == pos.x && chunk.y == pos.y)
				return chunks.get(chunk);
		}
		return null;
	}
	public function clear (){
		for (chunk in chunks)
			chunk.clear();
	}

	public function load (data:Array<Array<Int>>){
		var w = data.length;
		var h = data[0].length;
		trace('Loading data, with w: $w and h: $h');
		for (x in 0...w){
			for (y in 0...h){
				set_tile(x,y,data[x][y]);
			}
		}
	}

	public function set_tile(x:Int,y:Int,tile:Int){
		//Find the chunk it's in and call it's set_tile method.
		var chunkx = Math.floor(x / 8); //chunks are 8x8, get the chunk it's in.
		var chunky = Math.floor(y / 8);

		//Translate world coords to local coords.
		var localx = x % 8;
		var localy = y % 8;

		var chunk = get_chunk({x:chunkx, y:chunky});

		//trace('Setting tile id $tile to be at world $x, $y. Chunk $chunkx, $chunky. Locally, $localx, $localy');

		if (chunk != null){
			chunk.set_tile(localx,localy,tile);
		}
	}
}
