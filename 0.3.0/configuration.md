# Collage Configuration

|Name|<nobr>Default Value</nobr>|Purpose|
|---|---|---|
|`__COLLAGE_ENSURE_POWER_TWO`|`true`|Whether Collage should respect Power of Two sizes. (Will readjust the texture page if it's not power of two)|
|`__COLLAGE_CLAMP_TEXTURE_SIZE`|`true`|Whether Collage should clamp to the max texture page size.|
|`__COLLAGE_MIN_TEXTURE_SIZE`|`256`|The absolute minimum size that Collage will allow a texture page to be. Surfaces can work as low as 1. (I wouldn't recommend setting it to anything lower than 256.)|
|`__COLLAGE_MAX_TEXTURE_SIZE`|`8192`|The absolute maximum size that Collage will allow a texture page to be. On Windows, the absolute max is 16384. Other platforms/devices may vary.|
|`__COLLAGE_DEFAULT_TEXTURE_SIZE`|`2048`|The default texture page size.|
|`__COLLAGE_SCALE_TO_TEXTURES_ON_PAGE`|`true`|Whether Collage should scale images that are bigger than the texture page itself.|
|`__COLLAGE_RENDER_DEBUG_LINES`|`false`|Whether Collage should bake coloured boxes around all of the images or not. This is mostly used to determine that images are correctly fitting on the texture page, and otherwise serve no real purpose.|
|`__COLLAGE_DEFAULT_CROP`|`1`|Whether Collage should autocrop any texture pages that weren't given a crop level. Values include:<br> 0: No cropping<br> 1: Crop all sides<br>  2: Crop horizontally<br>  3: Crop Vertically|
|`__COLLAGE_DEFAULT_OPTIMIZE`|`true`|Whether Collage should autocrop any texture pages that weren't given a crop true/false value.|
|`__COLLAGE_DEFAULT_SEPARATION`|`0`|Separation value that Collage will respect across the board if no sep value was passed.|
|`__COLLAGE_IMAGE_NAME_COLLISION_HANDLE`|`0`|How Collage should handle image name collisions.<br>0: Reject all duplicate image names.<br>1: Allow replacing of existing images if they meet certain criteria (non-crop: width & height. crop: width & height & general minimal box area) or otherwise add as new image (with number).<br>2: Add as new image (with number).|
|`__COLLAGE_IMAGES_ARE_PUBLIC`|`true`|Whether Collage should make all images added available through the global image database or not. The upside to this is that you can use string-based values in certain functions that allow it to fetch from a global database. The downside is that you can't have the same names across multiple Collages. Setting this to false will allow all image names to be used privately, but not accessible via the global image database.|
|`__COLLAGE_BUILDER_VRAM_CLEAR`|`false`|Enables verbose console output to aid with debugging.|
|`__COLLAGE_STRETCHED_RESPECT_ORIGIN`|Whether Collage should respect the origin of the image or not when drawing stretched.<br>By default this is false to match GameMaker's behaviour.|`false`|
|`__COLLAGE_PART_RESPECT_ORIGIN`|Whether Collage should respect the origin of the image or not when drawing part.<br>By default this is false to match GameMaker's behaviour.|`false`|
|`__COLLAGE_VERBOSE`|`false`|Enables verbose console output to aid with debugging.|