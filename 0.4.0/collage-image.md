# Collage Image

Each Collage Image Instance includes a few methods that can be used to retrieve specific information, over their function equivalents.

### `.GetUVs(image_index)`

Returns: `Collage UVs Struct`

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image_index of the specified image.|

Returns the `Collage UVs Struct`.

### `.GetSurface(image_index)`

Returns: `Collage Instance` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image_index of the specified image.|

Returns the current `image_index` surface.

### `.GetTexture(image_index)`

Returns: `Collage Instance` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image_index of the specified image.|

Returns the Collage Instance from the name or `undefined`.

### `.GetTexturePage(image_index)`

Returns: `Collage Instance` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image_index of the specified image.|

Returns the Collage Instance from the name or `undefined`.

### `.GetCount()`

Returns: `Collage Instance` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image count.