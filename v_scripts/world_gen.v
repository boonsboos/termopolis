module main

import vsl.noise

struct World {
	ground [][]string
}

fn main() {
	mut world := World{process_noise_map()}
	for i in world.ground {
		for j in i {
			print('$j$j ')
		}
		print('\n')
		for j in i {
			print('$j$j ')
		}
		print('\n')
	}
}

fn process_noise_map() [][]string {
	world := noise.perlin_many(11, 11) or { [][]f32{} }
	mut result := [][]string{len: 11, init: []string{len: 11}}
	for i, a in world {
		for j, b in a {
			if b > 0.5  { result[i][j] = '^' }
			if b > 0.0  { result[i][j] = '#' }
			if b < 0.0  { result[i][j] = '~' }
			if b < -0.5 { result[i][j] = '=' }
		}
	}
	return result
}