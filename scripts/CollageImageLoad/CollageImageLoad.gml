/// @func CollageImageLoad(identifier, subImage)
/// @param identifier
/// @param subImage
function CollageImageLoad(_identifier, _subImage) {
	gml_pragma("forceinline");
	var _image =  __CollageImageFetchPointer(_identifier);
	_image.subImagesArray[_subImage % _image.subImagesCount].texturePageStruct.__restoreFromCache();
	return true;
}
