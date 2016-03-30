package ;

import luxe.Entity;
import Layer;
import luxe.Input;

class Player extends Entity implements IRenderable {
	public var x:Int = 0;
	public var y:Int = 0;
	public function new (layer:Layer){
		super({name:"Player"});
		layer.renderables.push(this);

		add(new KeyControls());
	}

	public function render(layer:Layer):Void {
		layer.set_tile(x,y,5);
	}
}
