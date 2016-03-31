import luxe.Color;
import luxe.Rectangle;
import luxe.Vector;
import luxe.Input;
import luxe.Visual;
import phoenix.geometry.QuadPackGeometry;

typedef ChunkRegion = {
	x : Int, //One x = One chunk wide.
	y : Int
}

typedef MapTile = { //Stores both geom data, and tile data. Tile == geom when refresh() is called.
	tile : Int,
    quad : Int,
    tilex : Int,
    tiley : Int
};

class Chunk extends Visual{

	var geom : QuadPackGeometry;
    var rowx : Int = 0;
    var rowy : Int = 0;

    var mapw : Int = 60;
    var maph : Int = 40;

	var tiles_wide:Int = 8;
	var tiles_high:Int = 8;

	public var needsRefreshing = false;

    var map_tiles : Array< Array<MapTile> >;


	public function new (location:ChunkRegion){
		geom = new phoenix.geometry.QuadPackGeometry({
            texture : Luxe.resources.texture('assets/tileset.png'),
            batcher : Luxe.renderer.batcher
        });

		geom.texture.filter_min = geom.texture.filter_mag = phoenix.Texture.FilterType.nearest;

        create_map();

        geom.locked = true;

		super({geometry:geom});


		pos.x = location.x * tiles_wide * 16;
		pos.y = location.y * tiles_high * 16;

	}

	function random_int( max:Int ) {

        return Math.floor(max*Math.random());

    }//random_int

    function create_map() {

        map_tiles = new Array< Array<MapTile> >();

        var tilew = 8;
        var tilecx : Int = tiles_wide; //= Std.int(Luxe.screen.w / tilew/10);
        var tilecy : Int = tiles_high; //= Std.int(Luxe.screen.h / tilew/10);

        for(_y in 0 ... tilecy) {
            var _row = new Array<MapTile>();
            for(_x in 0 ... tilecx) {

                var map_x = _x * tilew;
                var map_y = _y * tilew;
                var _quad = geom.quad_add({x:map_x*2, y:map_y*2, w:tilew*2, h:tilew*2});
                var _tilex = 4;//random_int(4);
                var _tiley = 1;//random_int(2);

                geom.quad_uv(_quad, new Rectangle((_tilex * tilew),(_tiley * tilew), tilew, tilew) );

                _row.push( { quad:_quad, tilex:_tilex, tiley:_tiley, tile: 15 } );

            } //_x
            map_tiles.push(_row);
        } //_y
    } //create_map

	public function set_tile(x:Int,y:Int,tile:Int,flagNeedsRefreshing = true){

		if (x >= tiles_wide || y >= tiles_high || x<0 || y<0) return;
		if (map_tiles[x][y].tile == tile) return;
		map_tiles[x][y].tile = tile;

		if (flagNeedsRefreshing) needsRefreshing = true;
	}

	inline public function get_tile(x:Int,y:Int){
		return map_tiles[x][y];
	}

	public function clear () {
		//Clear does NOT effect the array. Next REFRESH will bring it all back!!
		for(x in 0 ... tiles_wide) {
			for(y in 0 ... tiles_high) {
				set_tile(x,y,0);
			}
		}
	}

	//Loads tiles from array.
	public function refresh () {
		if (needsRefreshing == true){
			needsRefreshing = false;

			geom.locked = false;

			for(x in 0 ... tiles_wide) {
	            for(y in 0 ... tiles_high) {
					var tile = map_tiles[x][y].tile;
					tile--;

					needsRefreshing = false;

					var uv_x = tile % 10;
			        var uv_y = Math.floor(tile / 10);

					geom.quad_uv( map_tiles[y][x].quad, new Rectangle( uv_x*8, uv_y*8, 8, 8));
				}
			}
			geom.locked = true;

		}
	}
}
