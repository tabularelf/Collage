/// @func CollageImageIsLoaded(identifier, subImage)
/// @param identifier
/// @param subImage
function CollageImageIsLoaded(_identifier, _subImage) {
	gml_pragma("forceinline");
	var _image =  __CollageImageFetchPointer(_identifier);
	return (_image.subImagesArray[_subImage % _image.subImagesCount].texturePageStruct.isLoaded);
}
