module main

import env

__global world env.World

fn init() {
	world = env.World{}
}

fn main() {
	env.generate_world([u32(1), 929], 2)
	env.print_world()
}