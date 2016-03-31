package ;

import luxe.Input;

class KeyControls extends luxe.Component{
	var sprite : Player;
	var layer:Layer;
	public function new (_layer:Layer){
		super();
		layer = _layer;
	}

	override function init() {
	    sprite = cast entity;
	}
	override function onkeyup( e:KeyEvent ) {
		trace(layer.get_tile(sprite.x, sprite.y).tile);
        if(e.keycode == Key.key_w) {
			if ([2,3,21,22].indexOf(layer.get_tile(sprite.x, sprite.y-1).tile) != -1)
            	sprite.y--;
        }

		if(e.keycode == Key.key_a) {
            sprite.x--;
        }
		if(e.keycode == Key.key_s) {
            sprite.y++;
        }
		if(e.keycode == Key.key_d) {
            sprite.x++;
        }
    } //onkeyu
}
