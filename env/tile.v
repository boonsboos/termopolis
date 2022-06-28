module env

pub enum TileType {
	ocean
	sea
	land
	mountain
}

fn tile_to_ascii(typ TileType) string {
	return match typ {
		.ocean    {'='}
		.sea      {'~'}
		.land     {'#'}
		.mountain {'^'}
	}
}

pub struct Tile {
	kind TileType
	// unit Unit
	// resource ResourceType
	x int
	y int
}