module env

import term
import rand

import vsl.noise

const (
	sea_tr = -0.1
	ocean_tr = -0.6
	mountain_tr = 0.85
)

pub fn print_world() {
	for i in world.tiles {
		for _ in 0..4 {
			for j in i {
				for _ in 0..8 {
					if world.cursor_y == j.y && world.cursor_x == j.x {
						print(term.bg_green('${tile_to_ascii(j.kind)}'))
					} else {
						print('${tile_to_ascii(j.kind)}')
					}
					
				}
				print(term.reset(''))
			}
			print('\n')
		}
	}
}

// seed should be printed/saved somewhere
pub fn generate_world(seed u64, size int) {

	world.size = size
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