module env

import term.ui

fn handle_input(e &ui.Event, _ voidptr) {
	if e.typ != .key_down { return }

	match e.code {
		.left  { world.move_cursor(-1,0) }
		.right { world.move_cursor(1, 0) }
		.up    { world.move_cursor(0,-1) }
		.down  { world.move_cursor(0, 1) }
		else {}
	}
}