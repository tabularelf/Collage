# Collage Image Data

While in batch mode, any images added via the `.Add*` methods from [Collage()](collage.md) will return the underlying struct that Collage added to its batch queue. This enables a few additional properties that can be applied before packing.

For example:
```gml
texPage = new Collage();
texPage.StartBatch();

// Add our sprite to the Collage instance.
texPage.AddSprite(spr_soldier).SetBlend(c_red, 1);

texPage.FinishBatch();
```

### `.SetClump(bool)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`bool`|`boolean`|Whether to clump all subimages or not to the same texture page.|

Whether to clump all subimages or not to the same texture page (for sprites that must be put onto their own page).

?> If they cannot fit all on the same texture page for any reason, then it'll either scale it down as per `__COLLAGE_SCALE_TO_TEXTURES_ON_PAGE` or reject them.

### `.SetOrigin(x, y)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`real` or `CollageOrigin enum`|Same as using the `.Add*` xorigin arguments.|
|`y`|`real` or `CollageOrigin enum`|Same as using the `.Add*` yorigin arguments.|

This tells Collage where the image origin is located. If using the `CollageOrigin enum`, it will setup the origin for you. For example, using `CollageOrigin.CENTER` for both xorigin and yorigin will be set to the middle of the image.

### `.Set3D(bool)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`bool`|`boolean`|Whether each subimage should be on its own separate page or not.|

This tells Collage whether each subimage should be on its own separate page or not.

?> This will ignore `.SetClump()` if set to `true`.

### `.SetPremultiplyAlpha(bool)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`bool`|`boolean`|Whether to premultiply alpha or not.|

This tells Collage whether each subimage will be premultiplied or not. Just like how the premultiply check-in sprites work.

### `.SetBlend(colour, alpha)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`colour`|`real`|The colour value that Collage will bake this image.|
|`alpha`|`real`|The alpha value that Collage will bake this image.|

Sets the colour and alpha of the image that Collage will bake.

?> An alpha of less than or equal to `0.001` will be rejected by Collage during packing.

### `.SetTiling(horizontal_tile, vertical_tile)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`horizontal_tile`|`boolean`|Whether to tile horizontally or not.|
|`vertical_tile`|`boolean`|Whether to tile vertically or not.|

This tells Collage whether subimages should tile horizontally or vertically or not.

### `.SetPriority(priority)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`priority`|`real`|How high or low the image priority is.|

This tells Collage how much priority this image, and its subimages, have in the batch queue. Overriding the biggest to smallest sorting. By default, the value is `-1` for no priority.