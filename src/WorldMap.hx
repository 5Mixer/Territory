package ;

class WorldMap {
	public var layers:Map<String,Layer>;
	public var tiledLoader:TiledLoader;

	public function new(){
		layers = new Map<String,Layer>();

		layers.set("bg",new Layer("bg"));
		layers.set("fg",new Layer("fg"));

		tiledLoader = new TiledLoader();
		var j = Luxe.resources.json('assets/Level.json').asset.json;
		var level = tiledLoader.load_json(j);
		layers.get("bg").load(level,0,0);

		var j2 = Luxe.resources.json('assets/Structures/Buildings/Standard1.json').asset.json;
		var house = tiledLoader.load_json(j2);
		layers.get("bg").load(house,21,11);
	}
}
