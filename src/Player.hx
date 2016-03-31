package ;

import luxe.Entity;
import Layer;
import luxe.Input;

class Player extends Entity implements IRenderable {
	public var x:Int = 0;
	public var y:Int = 0;
	public function new (drawlayer:Layer,collideLayer:Layer){
		super({name:"Player"});
		drawlayer.renderables.push(this);

		add(new KeyControls(drawlayer,collideLayer));
	}

	public function render(layer:Layer):Void {
		layer.set_tile(x,y,5);
	}
}
