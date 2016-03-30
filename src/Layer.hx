package ;

import Chunk;

class Layer {
	public var chunks:Map<ChunkRegion,Chunk>;
	public var name:String;

	public function new (_name:String){
		chunks = new Map<ChunkRegion,Chunk>();
		name = _name;

		setup();
	}
	public function setup (){
		for (x in 0...10){
            for (y in 0...10){
                chunks.set({x:x,y:y},new Chunk({x:x,y:y}));
            }
        }
	}
}
