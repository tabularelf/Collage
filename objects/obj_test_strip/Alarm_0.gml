if (array_length(global.__spriteCleanup) > 0) {
	repeat(array_length(global.__spriteCleanup)) {
		sprite_delete(array_pop(global.__spriteCleanup));	
	}
}
