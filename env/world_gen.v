module env

import rand

import vsl.noise

const (
	sea_tr = -0.1
	ocean_tr = -0.6
	mountain_tr = 0.85
)

[inline]
pub fn make_seed(number u64) []u32 {
	world.seed = [u32(number >> 32), u32(number >> 16)]
	return world.seed
}

// seed should be printed/saved somewhere
pub fn generate_world(seed u64, size int) {

	world.size = size - 1
	rand.seed(make_seed(seed))
	noise_map := noise.perlin_many(size, size) or {
		eprintln('failed to generate world of size $size x $size')
		exit(1)
	}
	world.tiles = [][]Tile{len: size, init: []Tile{len: size}}

	for i, row in noise_map {
		for j, b in row {
			mut kind := env.TileType.land // by default, no need to check for other things
			match true {
				b < sea_tr      { kind = .sea }
				b < ocean_tr    { kind = .ocean }
				b > mountain_tr { kind = .mountain }
				else {}
			}
			world.tiles[i][j] = Tile { kind, j, i}
		}
	}
}