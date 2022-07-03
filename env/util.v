module env


pub fn make_seed(number u64) []u32 {
	println(u32(number).hex_full())
	return [u32(number >> 32), u32(number >> 16)]
}