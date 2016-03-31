package ;

import luxe.Input;

class KeyControls extends luxe.Component{
	var sprite : Player;
	var layer:Layer;
	var collisionLayer:Layer;
	public function new (_layer:Layer,collisions:Layer){
		super();
		layer = _layer;
		collisionLayer = collisions;
	}

	override function init() {
	    sprite = cast entity;
	}
	override function onkeyup( e:KeyEvent ) {
		trace(collisionLayer.get_tile(sprite.x, sprite.y).tile);

		var futurex = sprite.x;
		var futurey = sprite.y;

        if(e.keycode == Key.key_w) {
        	futurey--;
        }

		if(e.keycode == Key.key_a) {
        	futurex--;
        }
		if(e.keycode == Key.key_s) {
        	futurey++;
        }
		if(e.keycode == Key.key_d) {
        	futurex++;
        }

		var futureTile = collisionLayer.get_tile(futurex, futurey);
		if (futureTile == null) return; //Can't move to a tile if it is null!!

		if (TileData.isCollidable(futureTile.tile) == false){
			sprite.x = futurex;
			sprite.y = futurey;
		}
    } //onkeyu
}
