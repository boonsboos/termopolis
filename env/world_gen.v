module env

import rand
import vsl.noise

const (
	sea_tr = 0.0
	ocean_tr = -0.6
	mountain_tr = 0.75
)

pub fn print_world() {
	for i in world.tiles {
		for _ in 0..5 {
			for j in i {
				for _ in 0..10 {
					print('${tile_to_ascii(j.kind)}')
				}
				print(' ')
			}
			print('\n')
		}
	}
}

pub fn generate_world(seed []u32, size int) {
	rand.seed(seed)
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
			world.tiles[i][j] = Tile { kind, i, j}
		}
	}
}

fn noise_map_to_ascii(noise_map [][]f32) [][]string {
	mut result := [][]string{len: noise_map.len, init: []string{len: noise_map.len}} // we know the world will always be square
	for i, a in noise_map {
		for j, b in a {
			if b > 0.0   { result[i][j] = '#' } // ground
			if b < 0.0   { result[i][j] = '~' } // sea
			if b < -0.75 { result[i][j] = '=' } // ocean
			if b > 0.75  { result[i][j] = '^' } // mountain
		}
	}
	return result
}