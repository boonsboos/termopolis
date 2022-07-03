module env

pub fn cursor_command(i string) {
	coords := i.split(' ')
	x := coords[1].int()
	y := coords[2].int()
	if x > world.size || y > world.size || x < 0 || y < 0 {
		return
	}
	world.cursor_x = x
	world.cursor_y = y
}