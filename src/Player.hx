package ;

import luxe.Entity;
import Layer;
import luxe.Input;

class Player extends Entity implements IRenderable {
	var x:Int = 0;
	var y:Int = 0;
	public function new (layer:Layer){
		super({name:"Player"});
		layer.renderables.push(this);
	}

	public function render(layer:Layer):Void {
		layer.set_tile(x,y,5);
	}

	override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.key_w) {
            y--;
        }

		if(e.keycode == Key.key_a) {
            x--;
        }
		if(e.keycode == Key.key_s) {
            y++;
        }
		if(e.keycode == Key.key_d) {
            x++;
        }
		trace('$x   $y');
    } //onkeyu
}
