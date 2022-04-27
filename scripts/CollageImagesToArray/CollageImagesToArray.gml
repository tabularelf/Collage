function CollageImagesToArray(_identifier) {
    if (is_string(_identifier)) {
        return global.__CollageTexturePagesMap[$ _identifier].imagesToArray();
    }
    
    return _identifier.imagesToArray();
}