# Collage Enums

Collage includes a few different enums, some returned by certain methods. Others used to determine how Collage should handle specific areas.
Below you can see all of the different enums and what they're for.


### `CollageOrigin`

|Name|Purpose|
|---|---|
|`.LEFT`|To be used for the xorigin.|
|`.RIGHT`|To be used for the xorigin.|
|`.CENTER`|To be used for the xorigin or yorigin.|
|`.TOP`|To be used for the yorigin.|
|`.BOTTOM`|To be used for the yorigin.|

This applies to the `.Add*` methods in a Collage Instances. If you pass any of `CollageOrigin`'s enums to the `xorigin` or `yorigin` arguments, it'll position the origin based on the original image. (Before any processing is done.)

### `CollageStatus`

|Name|Purpose|
|---|---|
|`.READY`|Collage is ready to build images.|
|`.WAITING_ON_FILES`|Collage is waiting on files to be ready.|

Mainly used to determine whether Collage is ready to build images or not.

### `CollageBuildStates`

|Name|Purpose|
|---|---|
|`.NORMAL`|Collage is in normal building mode.|
|`.BATCHING`|Collage is in batch building mode.|

Mainly used to determine whether Collage batching a bunch of images currently or not.

### `CollageRPStatus`

|Name|Purpose|
|---|---|
|`.EMPTY`|Collage Render Pipeline is empty.|
|`.BATCHING`|Collage Render Pipeline is in batch building mode.|
|`.BATCHED`|Collage Render Pipeline has been batched and contains data.|

Mainly used to determine what kind of state Collage Render Pipeline is in.