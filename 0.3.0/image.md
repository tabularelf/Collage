# Image

?> If `COLLAGE_IMAGES_MAKE_PUBLIC` is set to false, functions that take in a string as an identifier may not work for all functions.

### `CollageImageGetUVsArray(identifier)`

Returns: `array` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `Collage image`|Name or instance of Collage image.|

Returns an array version of the UV information, for use with [`image_get_uvs()`](compatibility.md#image_get_uvssprite_indeximage-image_index)

### `CollageImageGetInfo(identifier)`

Returns: `struct` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string`|Name of image.|

Gets the image information (if any exists) or returns `undefined`.
?> If `COLLAGE_IMAGES_MAKE_PUBLIC` is set to false, this function will not work!

### `CollageImageIsLoaded(identifier, subImage)`

Returns: `boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `image`|Name of image.|
|`subImage`|`real`|Subimage of image.|

Checks whether the image is loaded or not.

### `CollageImageLoad(identifier, subImage)`

Returns: `struct`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `image`|Name of image.|
|`subImage`|`real`|Subimage of image.|

Loads in an image from cache memory.

### `CollageImageGetUVs(identifier, image_index)`

Returns: instance of `__CollageImageUVsClass`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `image`|Name of image|
|`image_index`|`real`|subimage of image|

Returns the UV struct of an image.

### `CollageImageGetTexture(identifier, subImage)`

Returns: `texturePointer`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `image`|Name of image.|
|`subImage`|`real`|Subimage of image.|

Gets the texture pointer of an image.

### `CollageImageGetTexturePage(identifier, subImage)`

Returns: `__CollageTexturePageClass`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `image`|Name of image.|
|`subImage`|`real`|Subimage of image.|

Gets the `__CollageTexturePageClass` of an image.

### `CollageImageGetSurface(identifier, subImage)`

Returns: `surfaceID`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `image`|Name of image.|
|`subImage`|`real`|Subimage of image.|

Gets the surfaceID of an image's texture page.

### `CollageImageExists(identifier)`

Returns: `boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `__CollageImageClass`|The name or Collage Image struct you want to check.|

Returns if the particular Collage image exists or not.