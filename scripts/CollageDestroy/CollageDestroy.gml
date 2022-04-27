function CollageDestroy(_identifier) {
    if (is_string(_identifier)) {
        global.__CollageTexturePagesMap[$ _identifier].destroy();
    }
    
    _identifier.destroy();
}