FLAGS := -skip-unused -enable-globals
OUT := termopolis

test-win:
	v $(FLAGS) -o $(OUT) .