module env

import term
import readline

[heap]
pub struct World {
pub mut:
	active   bool = true
mut:
	reader   readline.Readline
	size     int
	tiles    [][]Tile
	cursor_x int
	cursor_y int
	seed     []u32
}

[inline]
pub fn (mut w World) handle_input() {
	println(w.tiles[w.cursor_y][w.cursor_x].pretty())
	i := world.reader.read_line('> ') or { ' ' }[0].ascii_str()

	match i {
		'f' { world.move_cursor(-1,0) }
		'h' { world.move_cursor(1, 0) }
		't' { world.move_cursor(0,-1) }
		'g' { world.move_cursor(0, 1) }
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
		for _ in 0..4 {
			for j in i {
				for _ in 0..8 {
					if world.cursor_x == j.x && world.cursor_y == j.y {
						print(term.bg_white('${tile_to_ascii(j.kind)}'))
					} else {
						print('${tile_to_ascii(j.kind)}')
					}
				}
				print(term.reset(''))
			}
			println('')
		}
	}
}