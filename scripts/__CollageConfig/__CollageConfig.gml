// Whether Collage should respect Power of Two sizes. (Will readjust the texture page if it's not power of two)
#macro COLLAGE_ENSURE_POWER_TWO true

// Whether Collage should clamp to the max texture page size.
#macro COLLAGE_CLAMP_TEXTURE_SIZE true

// The absolute minimum size that Collage will allow a texture page to be. Surfaces can work as low as 1. 
// (I wouldn't recommend setting it to anything lower than 256.)
#macro COLLAGE_MIN_TEXTURE_SIZE 256

// The absolute maximum size that Collage will allow a texture page to be. On Windows, the absolute max is 16384.
// Other platforms/devices may vary.
#macro COLLAGE_MAX_TEXTURE_SIZE 8192 

// The default texture page size
#macro COLLAGE_DEFAULT_TEXTURE_SIZE 2048

// Whether Collage should scale images that are bigger than the texture page itself.
#macro COLLAGE_SCALE_TO_TEXTURES_ON_PAGE true

// Whether Collage should bake coloured boxes around all of the images or not.
// This is mostly used to determine that images are correctly fitting on the texture page, and otherwise serve no real purpose.
#macro COLLAGE_RENDER_DEBUG_LINES false

// Whether Collage should autocrop any texture pages that weren't given a crop true/false value.
#macro COLLAGE_DEFAULT_CROP true

// Separation value that Collage will respect across the board if no sep value was passed.
#macro COLLAGE_DEFAULT_SEPARATION 0

// How Collage should handle image name collisions
/*
    0: Reject all duplicate image names.
    1: Allow replacing of existing images if they meet certain criteria (non-crop: width & height. crop: width & height & general minimal box area) or otherwise add as new image.
    2: Add as new image.
*/
#macro COLLAGE_IMAGE_NAME_COLLISION_HANDLE 0

// Whether Collage should automatically check if the texture page that your image is from when drawing.
// As Collages innerworking is relied on surfaces + buffers, this is crucial.
// You can alternatively switch this off and call CollageCheckTexturePages() yourself before any drawing.
#macro COLLAGE_AUTO_CHECK_TEXTURE_PAGES true