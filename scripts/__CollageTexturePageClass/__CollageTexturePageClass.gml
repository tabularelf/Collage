/// @ignore
function __CollageTexturePageClass(_width, _height) constructor {
		__width = _width;
		__height = _height;
		__surface = -1;
		__buffer = -1;
		__cacheBuffer = -1;
		__isLoaded = false;
		
		static start = function() {
			if !(surface_exists(__surface)) {
				if !(buffer_exists(__buffer)) {
					__surfaceCreate();
					surface_set_target(__surface);
					draw_clear_alpha(0, 0);
					surface_reset_target();
				} else {
					CheckSurface();
				}
			}
			
			surface_set_target(__surface);
		}
		
		static finish = function() {
			surface_reset_target();
			if !(buffer_exists(__buffer)) {
				__init();
			}
			
			buffer_get_surface(__buffer, __surface, 0);
			__isLoaded = true;
		}
		
		static __init = function() {
			if !(buffer_exists(__buffer)) {
				if (buffer_exists(__cacheBuffer)) {
					// Lets decompress it
					__restoreFromCache();
				} else {
					__buffer = buffer_create(__width * __height * 4, buffer_fixed, 4);	
				}
			}
		}
		
		static free = function() {
			if (buffer_exists(__buffer)) {
				buffer_delete(__buffer);
				/* Feather ignore once GM1043 */
				__buffer = -1;
			}
			
			if (buffer_exists(__cacheBuffer)) {
				buffer_delete(__cacheBuffer);	
				/* Feather ignore once GM1043 */
				__cacheBuffer = -1;
			}
			
			if (surface_exists(__surface)) {
				surface_free(__surface);	
				/* Feather ignore once GM1043 */
				__surface = -1;
			}
			
			__isLoaded = false;
		}
		
		static CheckSurface = function() {
			if (buffer_exists(__buffer)) {
				if !(surface_exists(__surface)) {
					__surfaceCreate();
					buffer_set_surface(__buffer,__surface,0);
				}
			}
		}
			
		static __surfaceCreate = function() {
			if !(surface_exists(__surface)) {
				var _depthSetting = surface_get_depth_disable();
				surface_depth_disable(true);
				__surface = surface_create(__width, __height);
				surface_depth_disable(_depthSetting);
			}
		}
			
		static __cacheTexture = function() {
			if !(buffer_exists(__cacheBuffer)) {
				if (buffer_exists(__buffer)) {
					// Have to do this due to a bug with buffer_compress. 
					// Will change later once bugfix comes through.
					var _size = __width*__height*4;
					__cacheBuffer = buffer_compress(__buffer, 0, _size);
					
					// Remove main buffer
					buffer_delete(__buffer);
					/* Feather ignore once GM1043 */
					__buffer = -1;
					
					// Remove surface
					if (surface_exists(__surface)) {
						surface_free(__surface);	
						/* Feather ignore once GM1043 */
						__surface = -1;
					}
				}
				isLoaded = false;
			}
		}
			
		static __restoreFromCache = function() {
			if (!buffer_exists(__buffer)) && (buffer_exists(__cacheBuffer)) {
				var _dbuff = buffer_decompress(__cacheBuffer);
				/* Feather ignore once GM1009 */
				if !(_dbuff < 0) {
					__buffer = _dbuff;
					buffer_delete(__cacheBuffer);
					/* Feather ignore once GM1043 */
					__cacheBuffer = -1;
					// Restore surface
					CheckSurface();
					
					// It has loaded successfully!
					__isLoaded = true;
				} else {
					__CollageThrow("Something terrible has gone wrong with unloading cache data!");	
				}
			}
		}
		
		static __UnloadVRAM = function() {
			if (surface_exists(__surface)) {
				surface_free(__surface);	
			}
		}
		
		static GetTexture = function() {
			CheckSurface();
			return surface_get_texture(__surface);
		}
		
		static GetSurface = function() {
			CheckSurface();
			return __surface;
		}
}
	