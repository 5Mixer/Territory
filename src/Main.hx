import luxe.Color;
import luxe.Rectangle;
import luxe.Vector;
import luxe.Input;


class Main extends luxe.Game {

    var map:WorldMap;

    override function config(config:luxe.AppConfig) {

        config.preload.textures.push({ id:'assets/tileset.png' });
        config.preload.textures.push({ id:'assets/TilesetHD.png' });
        config.preload.textures.push({ id:'assets/TilesetVector.png' });
        config.preload.jsons = [
            { id:'assets/Level.json'},
            { id:'assets/tiles.json'},
            {id:'assets/Structures/Buildings/Standard1.json'}
        ];


        return config;

    }

    override function ready() {
        map = new WorldMap();
        var player = new Player(map.layers.get("fg"),map.layers.get("bg"));

        new FPS();

        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);

        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);

        Luxe.input.bind_key('up', Key.up);
        Luxe.input.bind_key('up', Key.key_w);

        Luxe.input.bind_key('down', Key.down);
        Luxe.input.bind_key('down', Key.key_s);

    }

    override function onmousemove( e:MouseEvent ) {

        /*for (layer in map.layers){
            for (chunk in layer.chunks){
                var x = Math.floor((e.x-chunk.pos.x)/16);
                var y = Math.floor((e.y-chunk.pos.y)/16);

                chunk.set_tile(x,y,5);
            }
        }*/
        var mapx = Math.floor(e.x/16);
        var mapy = Math.floor(e.y/16);
        map.layers.get("fg").set_tile(mapx,mapy,5);
    }

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    override function update(dt:Float) {
        map.layers.get("fg").render();
    }
}
