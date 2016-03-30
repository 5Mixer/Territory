package ;

import luxe.Input;

class KeyControls extends luxe.Component{
	var sprite : Player;
	public function new (){
		super();
	}

	override function init() {
	    sprite = cast entity;
	}
	override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.key_w) {
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
