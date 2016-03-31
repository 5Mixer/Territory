package ;

class WorldMap {
	public var layers:Map<String,Layer>;
	public var tiledLoader:TiledLoader;

	public function new(){
		layers = new Map<String,Layer>();

		layers.set("bg",new Layer("fg"));
		layers.set("fg",new Layer("bg"));

		tiledLoader = new TiledLoader();
		var j = Luxe.resources.json('assets/Level.json').asset.json;
		trace(j);
		var level = tiledLoader.load_json(j);
		layers.get("bg").load(level);
	}
}
