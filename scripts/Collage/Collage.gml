/// @func Collage([identifier], [width], [height], [crop], [Optimize])
/// @param {String} [identifier]
/// @param {Real} [width]
/// @param {Real} [height]
/// @param {Real} [crop]
/// @param {Real} [separation]
/// @param {Bool} [Optimize]
/* Feather ignore all */
function Collage(_identifier = undefined, _width = __COLLAGE_DEFAULT_TEXTURE_SIZE, _height = __COLLAGE_DEFAULT_TEXTURE_SIZE, _crop = __COLLAGE_DEFAULT_CROP, _separation = __COLLAGE_DEFAULT_SEPARATION, _optimize = __COLLAGE_DEFAULT_OPTIMIZE) constructor {
	// Members
	__CollageInit();
	__state = CollageStates.NORMAL;
	__texPageArray = [];
	texPageCount = 0;
	imageCount = 0;
	__batchImageList = [];
	__imageMap = {};
	__imageList = [];
	__asyncList = [];
	__isWaitingOnAsync = false;
	__status = CollageStatus.READY;
	builder = new __CollageBuilderClass();
	separation = _separation;
	width = _width;
	height = _height;
	crop = _crop;
	optimize = _optimize;
	name = is_undefined(_identifier) ? _identifier : string(_identifier);
	
	array_push(global.__CollageTexturePagesList, self);
	if (is_string(_identifier)) {
		if (variable_struct_exists(global.__CollageTexturePagesMap, _identifier)) {
			__CollageThrow(_identifier + " already exists as a Collage name!");	
		}
		
		global.__CollageTexturePagesMap[$ _identifier] = self;
	}
	
	// Init texture settings
	if (__COLLAGE_ENSURE_POWER_TWO) && !(CollageIsPowerTwo(width) || CollageIsPowerTwo(height)) {
		width = CollageConvertPowerTwo(_width);
		height = CollageConvertPowerTwo(_height);
	} 
	
	if (__COLLAGE_CLAMP_TEXTURE_SIZE) {
		width = clamp(width, __COLLAGE_MIN_TEXTURE_SIZE, __COLLAGE_MAX_TEXTURE_SIZE);
		height = clamp(height, __COLLAGE_MIN_TEXTURE_SIZE, __COLLAGE_MAX_TEXTURE_SIZE);
	}
	
	#region Methods
	
	static __getName = function() {
		return (is_undefined(name)) ? "" : name + " - ";	
	}
	
	static StartBatch = function() {
		if (__state == CollageStates.BATCHING) {
			__CollageTrace(__getName() + "Currently in batching mode!");
			return self;
		}
		
		__state = CollageStates.BATCHING;
		return self;
	}
	
	static ClearBatch = function() {
		if (__state == CollageStates.BATCHING) {
			var _len = array_length(__batchImageList);
			var _i = 0;
			repeat(_len) {
				if (__batchImageList[_i].isCopy) {
					sprite_delete(__batchImageList[_i].spriteID);	
				}
				++_i;
			} 	
			
			// Clear the list
			array_resize(__batchImageList, 0);
			return self;
			
		} else {
			__CollageTrace(__getName() + "Is not in batching mode!");	
			return self;
		}
	}
	
	static FinishBatch = function(_crop = true) {
		if (__state != CollageStates.BATCHING) {
			__CollageTrace(__getName() + "Is not in batching mode!");
			return self;
		} 
		
		if (!__isWaitingOnAsync) builder.__build();
		__state = CollageStates.NORMAL;
		return self;
	}
	
	static AddFile = function(_fileName, _identifierString = undefined, _subImage = 1, _removeBack = false, _smooth = false, _xOrigin = 0, _yOrigin = 0, _is3D = false) {
		if (!__CollageFileFromWeb(_fileName)) && (!file_exists(_fileName)) {
			// It doesn't exist, obviously!
			__CollageTrace(__getName() + "File " + string(_fileName) + " doesn't exist!");
			exit;
		}
		
		var _identifier = _identifierString ?? __CollageGetName(_fileName);
		
		var _spriteID = sprite_add(_fileName, _subImage, _removeBack, _smooth, _xOrigin, _yOrigin);
		if (_spriteID == -1) {
			__CollageTrace(__getName() + "File " + string(_fileName) + " has an invalid formatting!");
			exit;
		}
		
		var _spriteData = new __CollageSpriteFileDataClass(_identifier, _spriteID, _subImage).SetOrigin(_xOrigin, _yOrigin).Set3D(_is3D);
		
		if (__CollageFileFromWeb(_fileName)) {
			__isWaitingOnAsync = true;
			__status = CollageStatus.WAITING_ON_FILES;
			var _i = 0;
			repeat(array_length(global.__CollageAsyncList)) {
				if (global.__CollageAsyncList[_i] == self) {
					break;	
				}
				++_i;
			}
			
			if (_i == array_length(global.__CollageAsyncList)) {
				array_push(global.__CollageAsyncList, self);
			}
			
			array_push(__asyncList, _spriteData);
		} else {
			array_push(__batchImageList, _spriteData);
		}
		
		if (__state == CollageStates.NORMAL) {
			if (!__isWaitingOnAsync) builder.__build();
		}
		
		return _spriteData;
	}
	
	static AddSprite = function(_spriteIdentifier, _identifierString = undefined, _isCopy = undefined, _xOrigin = sprite_get_xoffset(_spriteIdentifier), _yOrigin = sprite_get_yoffset(_spriteIdentifier), _is3D = false) {
		var _spriteID = _spriteIdentifier;
		var _isCopyValue = _isCopy;
		
		var _identifier = _identifierString ?? sprite_get_name(_spriteID);
		
		if (_spriteID <= global.__CollageGMSpriteCount) {
			_spriteID = sprite_duplicate(_spriteIdentifier);
			if (__COLLAGE_VERBOSE) __CollageTrace(__getName() + _identifier + " is a GMSprite resource added via the IDE, making a copy...");
			_isCopyValue = true;
		}
		
		// Add sprite data
		var _spriteData = new __CollageSpriteFileDataClass(_identifier, _spriteID, sprite_get_number(_spriteID), _isCopyValue).SetOrigin(_xOrigin, _yOrigin).Set3D(_is3D);
		
		array_push(__batchImageList, _spriteData);
		
		if (__state == CollageStates.NORMAL) {
			builder.__build();
		}
		
		return _spriteData;
	}
	
	static AddFileStrip = function(_fileName, _identifierString = undefined, _removeBack = false, _smooth = false, _xOrigin = 0, _yOrigin = 0, _is3D = false) {
		if (!__CollageFileFromWeb(_fileName)) && (!file_exists(_fileName)) {
			// It doesn't exist, obviously!
			__CollageTrace(__getName() + "File " + string(_fileName) + " doesn't exist!");
			return -1;
		}
		
		var _identifier = _identifierString ?? __CollageGetName(_fileName);	
		
		var _spriteSheet = sprite_add(_fileName, 1, _removeBack, _smooth, _xOrigin, _yOrigin);
		if (_spriteSheet == -1) {
			__CollageTrace(__getName() + "File " + string(_fileName) + " has an invalid formatting!");
			exit;
		}
		
		var _width = sprite_get_width(_spriteSheet);
		var _height = sprite_get_height(_spriteSheet);
		var _offset = round(_width / _height);
		_width = _height;
		
		var _subImages = _offset;
		var _i = 0;
		var _surf = surface_create(_width, _height);
		var _sprite = -1;
		
		CollageSterlizeGPUState();
		repeat(_offset) {
			surface_set_target(_surf);
			draw_clear_alpha(0, 0);
			draw_sprite_part(_spriteSheet, 0, _i*_width, 0, _width, _height, 0, 0);
			surface_reset_target();
			++_i;
			if (!sprite_exists(_sprite)) {
				_sprite = sprite_create_from_surface(_surf, 0, 0, _width, _height, _removeBack, _smooth, _xOrigin, _yOrigin);	
			} else {
				sprite_add_from_surface(_sprite, _surf, 0, 0, _width, _height, _removeBack, _smooth);
			}
		}
		CollageRestoreGPUState();
		
		var _spriteData = new __CollageSpriteFileDataClass(_identifier, _sprite, _offset).SetOrigin(_xOrigin, _yOrigin).Set3D(_is3D);
		sprite_delete(_spriteSheet);
		
		if (__CollageFileFromWeb(_fileName)) {
			__isWaitingOnAsync = true;
			__status = CollageStatus.WAITING_ON_FILES;
			var _i = 0;
			repeat(array_length(global.__CollageAsyncList)) {
				if (global.__CollageAsyncList[_i] == self) {
					break;	
				}
				++_i;
			}
			
			if (_i == array_length(global.__CollageAsyncList)) {
				array_push(global.__CollageAsyncList, self);
			}
			
			array_push(__asyncList, _spriteData);
		} else {
			array_push(__batchImageList, _spriteData);
		}
		
		if (__state == CollageStates.NORMAL) {
			builder.__build();
		}
		surface_free(_surf);
		return _spriteData;
	}
	
	static AddSurface = function(_surface, _identifierString = undefined, _x = 0, _y = 0, _w = surface_get_width(_surface), _h = surface_get_height(_surface), _removeBack = false, _smooth = false, _xOrigin = 0, _yOrigin = 0, _is3D = false) {
		
		var _spriteID = sprite_create_from_surface(_surface, _x, _y, _w, _h, _removeBack, _smooth, _xOrigin, _yOrigin);
		
		var _identifier = _identifierString ?? "surface" + string(_surface);	
		// Add sprite data
		
		var _spriteData = new __CollageSpriteFileDataClass(_identifier, _spriteID, 1).SetOrigin(_xOrigin, _yOrigin).Set3D(_is3D);
		
		array_push(__batchImageList, _spriteData);
		
		if (__state == CollageStates.NORMAL) {
			builder.__build();
		}
		return _spriteData;
	}
	
	static AddSpriteSheet = function(_spriteID, _spriteArray, _identifierString, _width, _height, _removeBack = false, _smooth = false, _xOrigin = 0, _yOrigin = 0, _is3D = false) {
		if (is_undefined(_spriteArray)) {
			__CollageThrow("spriteArray String in .AddSpriteSheet() is undefined!");	
		}
		
		if (is_undefined(_identifierString)) {
			__CollageThrow("Identifier String in .AddSpriteSheet() is undefined!");	
		}
		
		//var _width = _spriteSheetStruct.width;// sprite_get_width(_spriteSheet);
		//var _height = _spriteSheetStruct.height;//sprite_get_height(_spriteSheet);
		
		var _i = 0;
		var _surf = surface_create(_width, _height);
		var _newSprite = -1;
		var _imageArray = [];
		
		CollageSterlizeGPUState();
		repeat(array_length(_spriteArray)) {
			var _imageStruct = _spriteArray[_i];
			var _xSize = _imageStruct.pos[2];
			var _ySize = _imageStruct.pos[3];
			var _subImages = max((_xSize >= _ySize ? (_xSize div _ySize) : (_ySize div _xSize)) - 1, 1);
			var _j = 1;
			repeat(_subImages) {
				surface_set_target(_surf);
				draw_clear_alpha(0, 0);
				var _xPos = _subImages > 1 ? (_xSize >= _ySize ? (_j*_width) : (_imageStruct.pos[0])) : _imageStruct.pos[0];
				var _yPos = _subImages > 1 ? (_xSize >= _ySize ? (_imageStruct.pos[1]) : (_j*_height))  : _imageStruct.pos[1];
				draw_sprite_part(_spriteID, 0, _xPos, _yPos, _width, _height, 0, 0);
				surface_reset_target();
				if (!sprite_exists(_newSprite)) {
					_newSprite = sprite_create_from_surface(_surf, 0, 0, _width, _height, _removeBack, _smooth, 0, 0);	
				} else {
					sprite_add_from_surface(_newSprite, _surf, 0, 0, _width, _height, _removeBack, _smooth);
				}
				++_j;
			}
		
			var _spriteData = new __CollageSpriteFileDataClass(_identifierString + _imageStruct.subName, _newSprite, _subImages).SetOrigin(_xOrigin, _yOrigin).Set3D(_is3D);
			array_push(__batchImageList, _spriteData);
			array_push(_imageArray, _spriteData);
			_newSprite = -1;
			++_i;
		}
		CollageRestoreGPUState();
		
		if (__state == CollageStates.NORMAL) {
			builder.__build();
		}
		surface_free(_surf);
		return _imageArray;
	}
	
	static FreePages = function() {
		var _i = 0;
		repeat(array_length(__texPageArray)) {
			__texPageArray[_i++].free();	
		}
		
		texPageCount = 0;
		var _i = 0;
		if (__COLLAGE_IMAGES_ARE_PUBLIC) {
			repeat(imageCount) {
				variable_struct_remove(global.__CollageImageMap, __imageList[_i++].name);
			}	
		}
		
		builder.init = false;
		array_resize(builder.bboxPoints, 0);
		imageCount = 0;
		__imageList = [];
		__imageMap = {};
		__texPageArray = [];
	}
	
	static GetTexturePage = function(_index) {
		if (_index < texPageCount) && (_index >= 0) {
			__texPageArray[_index].checkSurface();
			return __texPageArray[_index];
		}
		
		return undefined;
	}
	
	static GetTexture = function(_index) {
		if (_index < texPageCount) && (_index >= 0) {
			__texPageArray[_index].checkSurface();
			return __texPageArray[_index].GetTexture();
		}
		
		return undefined;
	}
	
	static GetPageCount = function() {
		return texPageCount;
	}
		
	static FlushPages = function() {
		var _len = texPageCount;
		var _i = 0;
		repeat(_len) {
			__texPageArray[_i++].__cacheTexture();
		}
	}
	
	static FlushPage = function(_index) {
		if (_index >= 0 && _index < texPageCount) {
			__texPageArray[_index].__cacheTexture();
		}
	}
	
	static PrefetchPages = function() {
		var _len = texPageCount;
		var _i = 0;
		repeat(_len) {
			__texPageArray[_i++].__restoreFromCache();
		}
	}
	
	static PrefetchPage = function(_index) {
		if (_index >= 0 && _index < texPageCount) {
			__texPageArray[_index].__restoreFromCache();
		}	
	}
		
	static savePageToBuffer = function() {
		var _texPageCount = texPageCount;
		var _imageCount =	imageCount;
		var _bboxPointsCount = array_length(builder.bboxPoints);
		var _stringByte = 0;
		var _subImagesCount = 0;
		
		// Get image names
		var _i = 0;
		repeat(_imageCount) {
			_stringByte += string_byte_length(__imageList[_i].name) + 1;
			_subImagesCount += __imageList[_i]. subImagesCount;
			++_i;
		}
		
		/*#macro __TGM_HEADER_FORMAT 13
		#macro __TGM_SPRITE_FORMAT 12
		#macro __TGM_UV_FORMAT 20 + 8 // 8 for 4byte float
		#macro __TGM_SPACEPOINTS_FORMAT 8
		var _headerSize = __TGM_HEADER_FORMAT + _stringByte + (__TGM_SPRITE_FORMAT * _imageCount) + (__TGM_UV_FORMAT * _subImagesCount) + __TGM_SPACEPOINTS_FORMAT;*/
		
		// Create buffer
		var _groupBuffer = buffer_create(1, buffer_grow, 1);
		
		// Write Header
		buffer_write(_groupBuffer, buffer_u16, width); // 2 Bytes
		buffer_write(_groupBuffer, buffer_u16, height); // 2 Bytes
		buffer_write(_groupBuffer, buffer_u8, _bboxPointsCount); // 1 Bytes
		buffer_write(_groupBuffer, buffer_u32, imageCount); // 4 Bytes
		buffer_write(_groupBuffer, buffer_u32, texPageCount); // 4 Bytes
		
		// Write Image Format
		var _i = 0;
		repeat(_imageCount) {
			buffer_write(_groupBuffer, buffer_string, imageList[_i].name); // String byte length + null
			buffer_write(_groupBuffer, buffer_u16, imageList[_i].width); // 2 byte
			buffer_write(_groupBuffer, buffer_u16, imageList[_i].height);  // 2 byte
			buffer_write(_groupBuffer, buffer_u16, imageList[_i].cropWidth); // 2 byte
			buffer_write(_groupBuffer, buffer_u16, imageList[_i].cropHeight);  // 2 byte
			buffer_write(_groupBuffer, buffer_u16, imageList[_i].xoffset); // 2 byte
			buffer_write(_groupBuffer, buffer_u16, imageList[_i].yoffset); // 2 byte
			buffer_write(_groupBuffer, buffer_u16, imageList[_i].subImagesCount); // 2 byte
			buffer_write(_groupBuffer, buffer_f32, imageList[_i].ratio); // 4 byte
			
			// Write UV format
			var _imageSubImageCount = imageList[_i].subImagesCount;
			var _j = 0;
			var _subImages = imageList[_i].subImagesArray;
			repeat(_imageSubImageCount) {
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].texturePageNum); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].left); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].right); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].top); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].bottom); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].trimLeft); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].trimTop); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].xPos); // 2 Byte
				buffer_write(_groupBuffer, buffer_u16, _subImages[_j].yPos); // 2 Byte
				buffer_write(_groupBuffer, buffer_f32, _subImages[_j].normTop); // 4 Byte
				buffer_write(_groupBuffer, buffer_f32, _subImages[_j].normLeft); // 4 Byte
				buffer_write(_groupBuffer, buffer_f32, _subImages[_j].normRight); // 4 Byte
				buffer_write(_groupBuffer, buffer_f32, _subImages[_j].normBottom); // 4 Byte
				++_j;
			}
			++_i;
		}
		
		// Save texture page data	
	_i = 0;
	repeat(texPageCount) {
		var _size = width*height*4;
		var _texBuffer = buffer_create(_size, buffer_fixed, 4);
		buffer_get_surface(_texBuffer, _surf, 0);
		//var _comTexBuffer = buffer_compress(_texBuffer, 0, _size);
		buffer_resize(_groupBuffer, buffer_get_size(_groupBuffer) + _size);
		buffer_copy(_texBuffer, 0, _size, _groupBuffer, buffer_get_size(_groupBuffer));
		buffer_delete(_texBuffer);
	}
		return _groupBuffer;
	}
	
	static Destroy = function() {
		FreePages();
		var _i = 0;
		repeat(array_length(global.__CollageTexturePagesList)) {
			if (global.__CollageTexturePagesList[_i] == self) {
				array_delete(global.__CollageTexturePagesList, _i, 1);
				break;
			}
			_i++
		}
		if (is_string(name)) {
			variable_struct_remove(global.__CollageTexturePagesMap, name);
		}
		
		// Demolish states
		builder = undefined;
		__imageList = undefined;
		__imageMap = undefined;
		__texPageArray = undefined;
	}
	
	static GetImageInfo = function(_identifier) {
		return __imageMap[$ _identifier];	
	}
	
	static ImagesToArray = function(_sorted = false) {
		var _array = array_create(array_length(__imageList));
		var _i = 0;
		repeat(array_length(_array)) {
			_array[_i] = __imageList[_i];
			++_i;
		}
		if (_sorted) {
			array_sort(_array, true);	
		}
		return _array;
	}
	
	static ImagesNamesToArray = function() {
		var _array = variable_struct_get_names(__imageMap);
		return _array;
	}
	
	static GetStatus = function() {
		return __status;
	}
	
	static Exists = function(_identifier) {
		return variable_struct_exists(__imageMap, _identifier);
	}
	
	#endregion 	
}
