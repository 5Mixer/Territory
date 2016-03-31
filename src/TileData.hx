package ;

class TileData {
	public function new () {

	}
	public static function isCollidable (tile:Int){
		return Luxe.resources.json('assets/tiles.json').asset.json.collidables.indexOf(tile) != -1;
	}
}
