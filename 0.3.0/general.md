### `CollageGet()`

Returns: `Collage Instance` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string`|Name of the Collage instance to get.|

Returns the Collage Instance from the name or `undefined`.

### `CollageDestroy()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`identifier`|`string` or `Collage Instance`|The Collage Instance name or instance itself.|

Destroys the Collage instance, freeing its contents.

### `CollageImageAsync()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Meant to be used in the `Async - Image Loaded` event. Allows images to be loaded asynchronously (such as from the web or on HTML5.)

### `CollageIsCollage(value)`

Returns: `Boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`value`|`Any`|Value to check.|

Returns whether it's a valid Collage instance or not.

### `CollageIsImage(value)`

Returns: `Boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`value`|`Any`|Value to check.|

Returns whether it's a valid Collage image instance or not.

### `CollageDefineSpriteSheet(subname, startX, startY, endX, endY)`

Returns: `array`.

|Name|Datatype|Purpose|
|---|---|---|
|`subname`|`string`|Subname of the sprite to make from sprite sheet.|
|`startX`|`real`|startX of sprite.|
|`startY`|`real`|startY of sprite.|
|`endX`|`real`|endX of sprite.|
|`endY`|`real`|endY of sprite.|

Returns an array with the subname and positions to be later stored within an array and added via [`.AddSpriteSheet()`](collage.md#addspritesheetspriteid-spritearray-identifierstring-width-height-removeback-smooth-xorigin-yorigin-is3d). If you provide `{{name}}` anywhere within `subname`, `.AddSpriteSheet()` will replace it instead of adding it to the end. i.e. `"spr_{{name}}_idle_down"`, with the main name `"bob"`, would get replaced as `"spr_bob_idle_down"`. Whereas in all other instances, you'll have to do `"spr_bob"` for the name, and `"_idle_down"`, to get `"spr_bob_idle_down"`.

### `CollageIsPowerTwo(number)`

Returns: `boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`number`|`real`|Number to check if power of two.|

Determines whether the number passed is a valid power of two.

### `CollageConvertPowerTwo(number)`

Returns: `real`.

|Name|Datatype|Purpose|
|---|---|---|
|`number`|`real`|Number to convert to power of two|

Converts a number to the nearest power of two.

### `CollageIsGPUStateSterilized()`

Returns: `boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Checks whether the GPU state has been sterilized or not.

### `CollageSterilizeGPUState()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Sterilizes the GPU states, matrices and shader, preparing for adding onto a texture page as is.

### `CollageRestoreGPUState()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Restores the GPU states, matrices and shader from `CollageSterilizeGPUState()`.