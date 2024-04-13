# CollageRenderPipeline()

This covers the `CollageRenderPipeline()` constructor, where mulitple images can be batched together into one or several vertex buffers and drawn all at once, while not having to worry about which image came from which texture page.

### `CollageRenderPipeline()`

Returns: An instance of `CollageRenderPipeline()`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Creates a new render pipeline.

### `.GetStatus()`

Returns: enum value of [`CollageRPStatus`](enums.md#collagerpstatus).

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current status of the Collage Render Pipeline instance.

### `.Start()`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Begins batching for the Collage Render Pipeline instance, clearing all frozen vertex buffers and unlocked vertex buffers.

### `.StartAppend()`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Similar to `.Start()`, but doesn't clear any frozen vertex buffers.

### `.AddImage(image, subimage, x, y, [z], [width], [height], [angle], [colour], [alpha], [respectOrigin])`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`image`|`Collage Image Struct`|Image you want to add.|
|`subimage`|`Real`|Sub image of Collage Image you want to use.|
|`x`|`Real`|X position of where you want to bake.|
|`y`|`Real`|Y position of where you want to bake.|
|`[z]`|`Real`|Optional: Z position of where you want to bake. Defaults to `0`|
|`[width]`|`Real`|Optional: Width of image. Defaults to `1`|
|`[height]`|`Real`|Optional: Height of image. Defaults to `1`|
|`[angle]`|`Real`|Optional: Angle of image. Defaults to `0`|
|`[colour]`|`Real`|Optional: Colour of image. Defaults to `draw_set_colour()`|
|`[alpha]`|`Real`|Optional: Alpha of image. `draw_set_alpha()`|
|`[respectOrigin]`|`Boolean`|Optional: Whether to respect image origin or not. Defaults to `true`|

Adds a Collage image to the batch, with the specified properties.

### `.Finish()`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Finishes batching images together.

### `.Freeze()`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Freezes all vertex buffers.

### `.Lock()`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Locks all vertex buffers.

### `.Unlock()`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Unlocks all vertex buffers.

### `.Draw()`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Draws all of the vertex buffers.

### `.RemoveImageByIndex(bufferEntry, imageEntry)`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`bufferEntry`|`Real`|The index in the buffer array to remove from.|
|`imageEntry`|`Real`|The index in the buffer to remove the image.|
|`N/A`|||

Removes an image at the given index from the buffer array.

!> Currently there isn't any helper functions to fetch these. Use with caution!

### `.Clear([frozenOnly])`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`[frozenOnly]`|`Boolean`|Whether to clear all or just frozen vertex buffers. Defaults to `false`|

Clears all vertex buffers. If `[frozenOnly]` is set to `true`, then this will only clear frozen vertex buffers.

Draws out all vertex buffers, including the draw start and end function. (This will do nothing if it's empty. Consider using [`.GetStatus()`](collage-render-pipeline.md#getstatus) to retrieve the current status.)

### `.SetVFormat(vertex_format)`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`vertex_format`|`vertex_format`|The vertex format you want to use for all vertex buffers.|

Sets the vertex format to be used with all vertex buffers (clearing all of them as the vertex format and batch no longer line up).

### `.SetVFormatFunc(vertex_format)`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`vformat_function`|`Function`|The vertex format you want to use for all vertex buffers.|

Sets the vertex format function to be used with all vertex buffers.

### `.SetDrawFuncs(preFunc, postFunc)`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`preFunc`|`Function`|Function that gets called before submitting vertex buffers.|
|`postFunc`|`Function`|Function that gets called after submitting vertex buffers.|

Sets the functions that this CollageRenderPipeline instance will use before and after submitting vertex buffers. Good for setting up matrix, shaders, etc.