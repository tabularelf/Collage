// Whether Collage should respect Power of Two sizes. (Will readjust the texture page if it's not power of two)
#macro __COLLAGE_ENSURE_POWER_TWO true

// Whether Collage should clamp to the max texture page size.
#macro __COLLAGE_CLAMP_TEXTURE_SIZE true

// The absolute minimum size that Collage will allow a texture page to be. Surfaces can work as low as 1. 
// (I wouldn't recommend setting it to anything lower than 256.)
#macro __COLLAGE_MIN_TEXTURE_SIZE 256

// The absolute maximum size that Collage will allow a texture page to be. On Windows, the absolute max is 16384.
// Other platforms/devices may vary.
#macro __COLLAGE_MAX_TEXTURE_SIZE 8192 

// The default texture page size
#macro __COLLAGE_DEFAULT_TEXTURE_SIZE 2048

// Whether Collage should scale images that are bigger than the texture page itself.
#macro __COLLAGE_SCALE_TO_TEXTURES_ON_PAGE true

// Whether Collage should bake coloured boxes around all of the images or not.
// This is mostly used to determine that images are correctly fitting on the texture page, and otherwise serve no real purpose.
#macro __COLLAGE_RENDER_DEBUG_LINES false

// Whether Collage should autocrop any texture pages that weren't given a crop true/false value.
#macro __COLLAGE_DEFAULT_CROP true

// Separation value that Collage will respect across the board if no sep value was passed.
#macro __COLLAGE_DEFAULT_SEPARATION 0

// How Collage should handle image name collisions
/*
    0: Reject all duplicate image names.
    1: Allow replacing of existing images if they meet certain criteria (non-crop: width & height. crop: width & height & general minimal box area) or otherwise add as new image.
    2: Add as new image.
*/
#macro __COLLAGE_IMAGE_NAME_COLLISION_HANDLE 0