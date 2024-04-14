# Rendering

### `CollageDrawImage(sprite_index/image, image_index, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|

Draws a `sprite` or `image` at the specified coordinates.

### `CollageDrawImageExt(sprite_index/image, image_index, x, y, xscale, yscale, rot, col, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `image`.|
|`rot`|`real`|The `rotation` you would like to draw the `sprite` or `image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `image`.|

Draws a `sprite` or `image` at the specified coordinates, with scaling, rotation, colour and alpha included.

### `CollageDrawImageGeneral(sprite_index/image, image_index, left, top, width, height, x, y, xscale, yscale, rot, col1, col2, col3, col4, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`left`|`real`|How much from the left you would like to draw the `sprite` or `image`.|
|`top`|`real`|How much from the top you would like to draw the `sprite` or `image`.|
|`width`|`real`|How much from the width you would like to draw the `sprite` or `image`.|
|`height`|`real`|How much from the height you would like to draw the `sprite` or `image`.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `image`.|
|`rot`|`real`|The `rotation` you would like to draw the `sprite` or `image`.|
|`col1`|`real`|The `colour` from the left corner you would like to draw the `sprite` or `image`.|
|`col2`|`real`|The `colour` from the top corner you would like to draw the `sprite` or `image`.|
|`col3`|`real`|The `colour` from the right corner you would like to draw the `sprite` or `image`.|
|`col4`|`real`|The `colour` from the bottom corner you would like to draw the `sprite` or `image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `image`.|

Draws a `sprite` or `image` at the specified coordinates, specifying the left, top, width and height that's shown. As well as the scaling, rotation, colours at each corner and alpha included.

### `CollageDrawImageStretched(sprite_index/image, image_index, x, y, width, height)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|
|`width`|`real`|The `width` amount you would like to stretch the `sprite` or `image`.|
|`height`|`real`|The `height` amount you would like to stretch the `sprite` or `image`.|

Draws a `Collage image` at the specified coordinates, with the width and height stretching the image.

### `CollageDrawImageStretchedExt(sprite_index/image, image_index, x, y, width, height, color, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|
|`width`|`real`|The `width` amount you would like to stretch the `sprite` or `image`.|
|`height`|`real`|The `height` amount you would like to stretch the `sprite` or `image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `image`.|

### `CollageDrawImagePart(sprite_index/image, image_index, left, top, width, height, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`left`|`real`|How much from the left you would like to draw the `sprite` or `image`.|
|`top`|`real`|How much from the top you would like to draw the `sprite` or `image`.|
|`width`|`real`|How much from the width you would like to draw the `sprite` or `image`.|
|`height`|`real`|How much from the height you would like to draw the `sprite` or `image`.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|

Draws a `sprite` or `image` at the specified coordinates.

### `CollageDrawImagePartExt(sprite_index/image, image_index, left, top, width, height, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`left`|`real`|How much from the left you would like to draw the `sprite` or `image`.|
|`top`|`real`|How much from the top you would like to draw the `sprite` or `image`.|
|`width`|`real`|How much from the width you would like to draw the `sprite` or `image`.|
|`height`|`real`|How much from the height you would like to draw the `sprite` or `image`.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `image`.|

Draws a `sprite` or `image` at the specified coordinates, with scaling, colour and alpha included.

### `CollageDrawImageTiled(sprite_index/image, image_index, x, y)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|

Draws a `sprite` or `image` at the specified coordinates, to the width/height of the current camera view.

### `CollageDrawImageTiledExt(sprite_index/image, image_index, x, y, xscale, yscale, col, alpha)`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`Collage image`|`any`|The `Collage image` you would like to draw.|
|`image_index`|`real`|The `image_index` you want to fetch the UVs for.|
|`x`|`real`|The `x` position you would like to draw the `sprite` or `image`.|
|`y`|`real`|The `y` position you would like to draw the `sprite` or `image`.|
|`xscale`|`real`|The `xscale` you would like to draw the `sprite` or `image`.|
|`yscale`|`real`|The `yscale` you would like to draw the `sprite` or `image`.|
|`col`|`real`|The `colour` you would like to draw the `sprite` or `image`.|
|`alpha`|`real`|The `alpha` you would like to draw the `sprite` or `image`.|

Draws a `sprite` or `image` at the specified coordinates, to the width/height of the current camera view. With scaling, colour and alpha included.