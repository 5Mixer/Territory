import luxe.Color;
import luxe.Rectangle;
import luxe.Vector;
import luxe.Input;


class Main extends luxe.Game {

    var map:WorldMap;

    override function config(config:luxe.AppConfig) {

        config.preload.textures.push({ id:'assets/tileset.png' });

        return config;

    }

    override function ready() {
        map = new WorldMap();
    }

    override function onmousemove( e:MouseEvent ) {

        for (layer in map.layers){
            for (chunk in layer.chunks){
                var x = Math.floor((e.x-chunk.pos.x)/16);
                var y = Math.floor((e.y-chunk.pos.y)/16);

                chunk.set_tile(x,y,5);
            }
        }
    }

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    override function update(dt:Float) {

    }
}
