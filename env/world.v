module env

import term
import readline
import strings

[heap]
pub struct World {
pub mut:
	active   bool = true
mut:
	reader   readline.Readline
	buf      strings.Builder = []u8{}
	size     int
	tiles    [][]Tile
	cursor_x int
	cursor_y int
	seed     []u32
}

[inline]
pub fn (mut w World) handle_input() {
	println(w.tiles[w.cursor_y][w.cursor_x].pretty())
	i := world.reader.read_line('> ') or { ' ' }.replace('\n', '')
	c := i[0].ascii_str()
	match c {
		'f' { world.move_cursor(-1,0) }
		'h' { world.move_cursor(1, 0) }
		't' { world.move_cursor(0,-1) }
		'g' { world.move_cursor(0, 1) }
		'c' { cursor_command(i.replace('c', '')) }
		'q' { w.active = false }
		else {}
	}
	
	term.clear()
}

[inline]
pub fn (mut w World) move_cursor(dx int, dy int) {
	if w.cursor_x + dx < 0 {
		w.cursor_x = w.size
	} else if w.cursor_x + dx > w.size {
		w.cursor_x = 0
	} else {
		w.cursor_x += dx
	}

	if w.cursor_y + dy < 0 {
		w.cursor_y = w.size - 1
	} else if w.cursor_y + dy > w.size {
		w.cursor_y = 0
	} else {
		w.cursor_y += dy
	}
}

[inline; direct_array_access]
pub fn (mut w World) print() {
	for i in world.tiles {
		for _ in 0..3 {
			for j in i {
				for _ in 0..5 {
					if world.cursor_x == j.x && world.cursor_y == j.y {
						world.buf.write_string(term.bg_rgb(76, 76, 76, '${tile_to_ascii(j.kind)}'))
					} else {
						world.buf.write_string('${tile_to_ascii(j.kind)}')
					}
				}
				world.buf.write_string(term.reset(''))
			}
			world.buf.write_string('\n')
		}
	}
	println(world.buf.str())
	world.buf.clear()
}