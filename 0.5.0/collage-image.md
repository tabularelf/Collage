# Collage Image

Each Collage Image Instance includes a few methods that can be used to retrieve specific information, over their function equivalents.

### `.SetXOffset(x)`

Returns: `Collage Image instance`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`real`|xoffset you wish to set|

Sets the xoffset of the Collage image instance.

### `.SetYOffset(y)`

Returns: `Collage Image instance`.

|Name|Datatype|Purpose|
|---|---|---|
|`y`|`real`|yoffset you wish to set|

Sets the yoffset of the Collage image instance.

### `.SetXYOffset(x, y)`

Returns: `Collage Image instance`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`real`|xoffset you wish to set|
|`y`|`real`|yoffset you wish to set|

Sets the xoffset and yoffset of the Collage image instance.

### `.SetSpeed(speed)`

Returns: `Collage Image instance`.

|Name|Datatype|Purpose|
|---|---|---|
|`speed`|`real`|Speed you wish to set|

Sets the speed of the Collage image instance.

### `.SetSpeedType(type)`

Returns: `Collage Image instance`.

|Name|Datatype|Purpose|
|---|---|---|
|`type`|`Sprite Speed Constant Type`|Speed type you wish to set|

Sets the speed type of the Collage image instance.

### `.CalcImageIndex(image_index, [image_speed], [fps])`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|The `image_index` your image is currently at.|
|`image_speed`|`real`|The `image_speed` your image is currently at. Same as if you were to use the variable `image_speed`. Default is `1`.|
|`fps`|`real`|The `fps` your image is currently at. Default is FPS target of game.|

Sets the speed of the Collage image instance.

### `.GetName()`

Returns: `String`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance name.

### `.GetWidth()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance width.

### `.GetHeight()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance height.

### `.GetXOffset()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance xoffset.

### `.GetYOffset()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance yoffset.

### `.GetUVs(image_index)`

Returns: `Collage UVs Struct`

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image index of the specified image.|

Returns the `Collage UVs Struct`.

### `.GetSurface(image_index)`

Returns: `Collage Image surface`

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image index of the specified image.|

Returns the Collage image `image_index` internal surface.

### `.GetTexture(image_index)`

Returns: `Texture Pointer`.

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image index of the specified image.|

Returns the Collage texture pointer of the specified index from the Collage Image instance..

### `.GetTexturePage(image_index)`

Returns: `Collage Texture Page Instance` or `undefined`.

|Name|Datatype|Purpose|
|---|---|---|
|`image_index`|`real`|Image index of the specified image.|

Returns the Collage Texture Page instance of the specified index from the Collage Image instance.

### `.GetCount()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance frame count.

### `.GetSpeed()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance speed.

### `.GetSpeedType()`

Returns: `Sprite Speed Constant type`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Collage Image instance speed type.