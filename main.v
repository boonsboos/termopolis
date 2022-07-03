module main

import rand
import env

__global world env.World

fn init() {
	world = env.World{}
}

fn main() {
	env.generate_world(rand.u64(), 16)
	for world.active {
		world.print()
		world.handle_input()
	}
}