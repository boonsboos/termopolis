module main

import env

__global world env.World

fn init() {
	world = env.init_world()
}

fn main() {
	env.generate_world(u64(3234), 11)
	env.print_world()
}