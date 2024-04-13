# Collage

### `Collage([identifier], [width], [height], [crop], [separation], [optimization])`

Returns: struct, an instance of `Collage`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string`|Name of the texture page. (Defaults to `undefined` and doesn't register to Collages database.)'|
|`width`|`real`|Width of the texture page. (Defaults to [`__COLLAGE_DEFAULT_TEXTURE_SIZE`](configuration.md))|
|`height`|`real`|Height of the texture page. (Defaults to [`__COLLAGE_DEFAULT_TEXTURE_SIZE`](configuration.md))|
|`crop`|`real`|Level of cropping. (Defaults to [`__COLLAGE_DEFAULT_CROP`](configuration.md))|
|`separation`|`real`|How many pixels should images be spaced apart. (Defaults to [`__COLLAGE_DEFAULT_SEPARATION`](configuration.md))|
|`optimization`|`real`|Level of optimization. (Defaults to [`__COLLAGE_DEFAULT_OPTIMIZE`](configuration.md))|

Constructor, creates a new instance of `Collage` to be used for building texture pages. If an `identifier` was passed, Collage will assign itself to a global database and can be used with `CollageGet()` to retrieve said Collage instance.

### `.StartBatch()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Tells Collage to batch images instead of building right away.

### `.FinishBatch()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Tells Collage that it's done batching images and to start building.

### `.ClearBatch()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Tells Collage to clear the list of images.

### `.AddFile(filepath, [identifier], [subimages], [removeback], [smooth], [xorigin], [yorigin], [is3D])`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`filepath`|`string`|The path to the image.|
|`identifier`|`string`|The name of the image. By default, it uses the filename without the extension.|
|`subimage`|`real`|Number of subimages. (Defaults to`1`)|
|`removeback`|`boolean`|Whether to removeback or not. (Defaults to`false`)|
|`smooth`|`boolean`|Whether to smooth the image or not. (Defaults to`false`)|
|`xorigin`|`real`|xoffset of image. (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`yorigin`|`real`|yoffset of image.  (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`is3D`|`boolean`|Whether image should have its own texture page, regardless of size. (Defaults to`false`)|

Loads an image and adds it to the texture page. (Note: If `.startBatch()` was called, then images are added to a list until `.finishBatch()` is called.)

### `.AddSprite(spriteID, [identifier], [isCopy], [xOrigin], [yOrigin], [is3D])`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`spriteID`|`sprite_index`|The ID of the sprite to add.|
|`identifier`|`string`|The name of the image. By default, it uses the filename without the extension.|
|`isCopy`|`boolean`|Whether this image is a copy of another. Hints to collage to auto delete the sprite at the end. (Default: Depends on sprite passed)|
|`xorigin`|`real`|xoffset of image. (Defaults to sprites xorigin.) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`yorigin`|`real`|yoffset of image.  (Defaults to sprites yorigin.) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`is3D`|`boolean`|Whether to removeback or not. (Defaults to`false`)|

Marks a sprite as an image and adds it to the texture page. (Note: If `.startBatch()` was called, then images are added to a list until `.finishBatch()` is called.)

### `.AddFileStrip(filepath, [identifier], [removeback], [smooth], [xorigin], [yorigin], [is3D])`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`filepath`|`string`|The path to the image.|
|`identifier`|`string`|The name of the image. By default, it uses the filename without the extension.|
|`removeback`|`boolean`|Whether to removeback or not. (Defaults to`false`)|
|`smooth`|`boolean`|Whether to smooth the image or not. (Defaults to`false`)|
|`xorigin`|`real`|xoffset of image. (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`yorigin`|`real`|yoffset of image.  (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`is3D`|`boolean`|Whether image should have its own texture page, regardless of size. (Defaults to`false`)|

Loads an image strip and adds it to the texture page. (Note: If `.startBatch()` was called, then images are added to a list until `.finishBatch()` is called.)

### `.AddSurface(surfaceID, [identifier], [x], [y], [width], [height], [removeback], [smooth], [xorigin], [yorigin], [is3D])`

Converts a surface into an image and adds it to the texture page. (Note: If `.startBatch()` was called, then images are added to a list until `.finishBatch()` is called.)

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`surfaceID`|`surfaceID`|The ID of the surface.|
|`identifier`|`string`|The name of the image. By default, it uses the filename without the extension.|
|`x`|`real`|The x position to copy from. (Defaults to`0`)|
|`y`|`real`|The y position to copy from.  (Defaults to`0`)|
|`width`|`real`|The width of the area to be copied (from the x position). (Defaults to`surface_width`)|
|`height`|`real`|The height of the area to be copied (from the y position). (Defaults to`surface_height`)|
|`removeback`|`boolean`|Whether to removeback or not. (Defaults to`false`)|
|`smooth`|`boolean`|Whether to smooth the image or not. (Defaults to`false`)|
|`xorigin`|`real`|xoffset of image. (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`yorigin`|`real`|yoffset of image.  (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`is3D`|`boolean`|Whether image should have its own texture page, regardless of size. (Defaults to`false`)|

### `.AddSpriteSheet(spriteID, spriteArray, identifierString, width, height, [removeBack], [smooth], [xorigin], [yorigin], [is3D])`

Converts a sprite into multiple smaller sprites. Used in cases where you have an already assembled sprite sheet and want to splice it up. The `name` property may either be at the start of each image name, or replacing `{{name}}`. See [`CollageDefineSpriteSheet()`](general.md#collagedefinespritesheetsubname-startx-starty-endx-endy) for more info.

Returns: `N/A` (or `SpriteData Struct` if Collage Build State is `BATCHING`).

|Name|Datatype|Purpose|
|---|---|---|
|`spriteID`|`sprite_index`|The ID of the sprite.|
|`spriteArray`|`array`|Array of structs as defined via [`CollageDefineSpriteSheet()`](general.md#collagedefinespritesheetsubname-startx-starty-endx-endy) |
|`identifier`|`string`|The name of the image. By default, it uses the filename without the extension.|
|`width`|`real`|The width of the area to be copied (from the x position). (Defaults to`surface_width`)|
|`height`|`real`|The height of the area to be copied (from the y position). (Defaults to`surface_height`)|
|`[removeback]`|`boolean`|Whether to removeback or not. (Defaults to`false`)|
|`[smooth]`|`boolean`|Whether to smooth the image or not. (Defaults to`false`)|
|`[xorigin]`|`real`|xoffset of image. (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`[yorigin]`|`real`|yoffset of image.  (Defaults to`0`) You may use [`CollageOrigin`](enums.md#collageorigin) to define your origin instead.|
|`[is3D]`|`boolean`|Whether image should have its own texture page, regardless of size. (Defaults to`false`)|

### `.Clear()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Frees the texture pages (and images). Allowing for this Collage instance to be reused.

### `.GetPage()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Frees the texture pages (and images).

### `.GetPageCount()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Frees the texture pages (and images).

### `.FlushPages()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Flushes all texture pages to cached memory.

### `.FlushPage()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Flushes a texture page to cached memory.

### `.PrefetchPages()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Loads all texture pages from cached memory.

### `.PrefetchPage(index)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`index`|`real`|Texture page to load from cache.|

Loads a texture page from cached memory.

### `.ImageGetInfo(identifier)`

Returns: `image` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string`|Name of image|

Returns an image, if one exists.

### `.Exists(identifier)`

Returns: `boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string`|Name of image|

Returns whether an image exists within the Collage instance or not.

### `.GetStatus()`

Returns: `real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the type of status, as per CollageStatus enum, from the Collage instance.

### `.ImagesToArray()`

Returns: `array`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns an array of all of the images that Collage instance has.

### `.ImagesNamesToArray()`

Returns: `array`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns an array of all of the images that Collage instance has.

### `.Destroy()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Completely removes all textures/images and cleans up any references to it. (This also prevents packing images into it.)