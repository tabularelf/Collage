function CollageDestroy(_identifier) {
	gml_pragma("forceinline");
    if (is_string(_identifier)) {
		global.__CollageTexturePagesMap[$ _identifier].destroy();
    }
    
    _identifier.destroy();
}