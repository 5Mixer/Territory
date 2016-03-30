package ;

class WorldMap {
	public var layers:Map<String,Layer>;
	public function new(){
		layers = new Map<String,Layer>();

		layers.set("bg",new Layer("fg"));
		layers.set("fg",new Layer("bg"));
	}
}
