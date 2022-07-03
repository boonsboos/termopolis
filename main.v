module main

import env

__global world env.World

fn init() {
	world = env.World{}
}

fn main() {
	env.generate_world(u64(3234), 11)
	for world.active {
		world.print()
		world.handle_input()
	}
}