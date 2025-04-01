# GM-Collage Compatibility

?> These are solely used to bridge compatibility between GameMaker sprites and Collage images, for quick importing into your project. You may ignore these if you're planning to use Collage Images only.

### `image_get_width(sprite_index/collage_image)`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|

Returns the width of the sprite or collage image.

### `image_get_height(sprite_index/collage_image)`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|

Returns the height of the sprite or collage image.

### `image_get_xoffset(sprite_index/collage_image)`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|

Returns the xoffset of the sprite or collage image.

### `image_get_yoffset(sprite_index/collage_image)`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|

Returns the yoffset of the sprite or collage image.

### `image_get_texture(sprite_index/collage_image, image_index)`

Returns: `Texture Pointer`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|

Returns the texture pointer of the sprite or collage image.

### `image_get_speed(sprite_index/collage_image)`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|

Returns the speed of the sprite or collage image.

### `image_get_speed_type(sprite_index/collage_image)`

Returns: `Sprite Speed Constant type`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|

Returns the speed type of the sprite or collage image.

### `image_get_uvs(sprite_index/collage_image, image_index)`

Returns: `array`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|

Returns an array of UV info, as laid out per [`sprite_get_uvs()`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asset_Management/Sprites/Sprite_Information/sprite_get_uvs.htm).

### `draw_image(sprite_index/collage_image, image_index, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates.

### `draw_image_ext(sprite_index/collage_image, image_index, x, y, xscale, yscale, rot, col, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `Collage image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `Collage image`.|
|`rot`|`real`|The `rotation` you would like to draw the `sprite` or `Collage image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `Collage image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates, with scaling, rotation, colour and alpha included.

### `draw_image_general(sprite_index/collage_image, image_index, left, top, width, height, x, y, xscale, yscale, rot, col1, col2, col3, col4, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`left`|`real`|How much from the left you would like to draw the `sprite` or `Collage image`.|
|`top`|`real`|How much from the top you would like to draw the `sprite` or `Collage image`.|
|`width`|`real`|How much from the width you would like to draw the `sprite` or `Collage image`.|
|`height`|`real`|How much from the height you would like to draw the `sprite` or `Collage image`.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `Collage image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `Collage image`.|
|`rot`|`real`|The `rotation` you would like to draw the `sprite` or `Collage image`.|
|`col1`|`real`|The `colour` from the left corner you would like to draw the `sprite` or `Collage image`.|
|`col2`|`real`|The `colour` from the top corner you would like to draw the `sprite` or `Collage image`.|
|`col3`|`real`|The `colour` from the right corner you would like to draw the `sprite` or `Collage image`.|
|`col4`|`real`|The `colour` from the bottom corner you would like to draw the `sprite` or `Collage image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates, specifying the left, top, width and height that's shown. As well as the scaling, rotation, colours at each corner and alpha included.

### `draw_image_stretched(sprite_index/collage_image, image_index, x, y, width, height)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|
|`width`|`real`|The `width` amount you would like to stretch the `sprite` or `Collage image`.|
|`height`|`real`|The `height` amount you would like to stretch the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates, with the width and height stretching the collage_image.

### `draw_image_stretched_ext(sprite_index/collage_image, image_index, x, y, width, height, color, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|
|`width`|`real`|The `width` amount you would like to stretch the `sprite` or `Collage image`.|
|`height`|`real`|The `height` amount you would like to stretch the `sprite` or `Collage image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `Collage image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `Collage image`.|

### `draw_image_part(sprite_index/collage_image, image_index, left, top, width, height, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`any`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`left`|`real`|How much from the left you would like to draw the `sprite` or `Collage image`.|
|`top`|`real`|How much from the top you would like to draw the `sprite` or `Collage image`.|
|`width`|`real`|How much from the width you would like to draw the `sprite` or `Collage image`.|
|`height`|`real`|How much from the height you would like to draw the `sprite` or `Collage image`.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates.

### `draw_image_part_ext(sprite_index/collage_image, image_index, left, top, width, height, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`spriteID` or `Collage Image`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`left`|`real`|How much from the left you would like to draw the `sprite` or `Collage image`.|
|`top`|`real`|How much from the top you would like to draw the `sprite` or `Collage image`.|
|`width`|`real`|How much from the width you would like to draw the `sprite` or `Collage image`.|
|`height`|`real`|How much from the height you would like to draw the `sprite` or `Collage image`.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `Collage image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `Collage image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `Collage image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates, with scaling, colour and alpha included.

### `draw_image_tiled(sprite_index/collage_image, image_index, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`spriteID` or `Collage Image`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates, to the width/height of the current camera view.

### `draw_image_tiled_ext(sprite_index/collage_image, image_index, x, y, xscale, yscale, col, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index/collage_image`|`spriteID` or `Collage Image`|The `sprite_index` or `Collage collage_image`.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `Collage image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `Collage image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `Collage image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `Collage image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `Collage image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `Collage image`.|

Draws a `sprite` or `Collage image` at the specified coordinates, to the width/height of the current camera view. With scaling, colour and alpha included.