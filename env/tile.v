module env

import term

pub enum TileType {
	ocean
	sea
	land
	mountain
}

[inline]
fn tile_to_ascii(typ TileType) string {
	return match typ {
		.ocean    {term.blue('=')}
		.sea      {term.bright_blue('~')}
		.land     {term.bright_green('#') }
		.mountain {term.rgb(192, 255, 192, '^')}
	}
}

pub struct Tile {
	kind TileType
	// unit Unit
	// resource ResourceType
	x int
	y int
}

[inline]
pub fn (t Tile) pretty() string {
	return 'Tile: ($t.x,$t.y) = $t.kind'
}