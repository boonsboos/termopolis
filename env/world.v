module env

import term.ui

[heap]
pub struct World {
	tui      &ui.Context
mut:
	size     int
	tiles    [][]Tile
	cursor_x int
	cursor_y int
}

pub fn init_world() World {
	return World{
		tui: ui.init(ui.Config{
			hide_cursor: true
			event_fn: handle_input
		})
	}
}

pub fn (mut w World) move_cursor(dx int, dy int) {
	if w.cursor_x + dx < 0 {
		w.cursor_x += w.size
	} else if w.cursor_x + dx > w.size {
		w.cursor_x = 0
	} else {
		w.cursor_x += dx
	}

	if w.cursor_y + dy < 0 {
		w.cursor_y += w.size
	} else if w.cursor_y + dy > w.size {
		w.cursor_y = 0
	} else {
		w.cursor_y = 0
	}
} 