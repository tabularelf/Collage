/// @func CollageImageIsLoaded(identifier, subImage)
/// @param identifier
/// @param subImage
function CollageImageIsLoaded(_identifier, _subImage) {
	var _image =  __CollageImageFetchPointer(_identifier);
	return (_image.subImagesArray[_subImage % _image.subImagesCount].texturePageStruct.isLoaded);
}
