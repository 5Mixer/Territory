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

	//Quantity of tiles wide and high in a single chunk.
	var tiles_wide:Int = 8;
	var tiles_high:Int = 8;

	//Size of the tiles
	var tile_width:Int = 32;
	var tile_height:Int = 32;

	public var needsRefreshing = false;

    var map_tiles : Array< Array<MapTile> >;


	public function new (location:ChunkRegion){
		geom = new phoenix.geometry.QuadPackGeometry({
            texture : Luxe.resources.texture('assets/TilesetVector.png'),
            batcher : Luxe.renderer.batcher
        });

		geom.texture.filter_min = geom.texture.filter_mag = phoenix.Texture.FilterType.nearest;

		tile_width = Math.floor(geom.texture.width/10);
		tile_height = Math.floor(geom.texture.height/10);

        create_map();

        geom.locked = true;

		super({geometry:geom});


		pos.x = location.x * tiles_wide * 32; //Tiles are rendered double size, and so this is 16, not 8.
		pos.y = location.y * tiles_high * 32;

	}

	inline function random_int( max:Int ) {

        return Math.floor(max*Math.random());

    }//random_int

    function create_map() {

        map_tiles = new Array< Array<MapTile> >();

        var tilecx = tiles_wide; //Number of tile sprites horizontally in the chunk.
        var tilecy = tiles_high; //Number of tile sprites vertically in this chunk.

        for(_y in 0 ... tilecy) {
            var _row = new Array<MapTile>();
            for(_x in 0 ... tilecx) {

                var map_x = _x * 32;
                var map_y = _y * 32;
                var _quad = geom.quad_add({x:map_x, y:map_y, w:8*4, h:8*4});
                var _tilex = 4;//random_int(4);
                var _tiley = 1;//random_int(2);

                geom.quad_uv(_quad, new Rectangle((_tilex * tile_width),(_tiley * tile_height), tile_width, tile_height) );

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
		//Clear does NOT effect the array. Next REFRESH will reflect this visually!
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


			for(x in 0 ... tiles_wide) {
	            for(y in 0 ... tiles_high) {
					var tile = map_tiles[x][y].tile;
					tile--;

					needsRefreshing = false;

					var uv_x = tile % 10;
			        var uv_y = Math.floor(tile / 10);

					geom.quad_uv( map_tiles[y][x].quad, new Rectangle( uv_x*tile_width, uv_y*tile_height, tile_width, tile_height));
				}
			}

		}
	}
}
