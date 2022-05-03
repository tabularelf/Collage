/// @func Collage(width, height, [crop], [separation], [identifier])
/// @param width
/// @param height
/// @param [crop]
/// @param [separation]
/// @param [identitifer]
function Collage(_width = COLLAGE_DEFAULT_TEXTURE_SIZE, _height = COLLAGE_DEFAULT_TEXTURE_SIZE, _crop = COLLAGE_DEFAULT_CROP, _sep = COLLAGE_DEFAULT_SEPARATION, _identifier = undefined) constructor {
	#region Methods
	static __builder = function() constructor {
		owner = other;
		bboxPoints = [];
		init = false;
		freeSpacePoints = [];
		
		static __checkImage = function(_str) {
			if (COLLAGE_IMAGES_ARE_PUBLIC) {
				return variable_struct_exists(global.__CollageImageMap, _str);	
			} else {
				return variable_struct_exists(owner.__imageMap, _str);	
			}
		}
		
		static __getImage = function(_str) {
			if (COLLAGE_IMAGES_ARE_PUBLIC) {
				return global.__CollageImageMap[$ _str];	
			} else {
				return owner.__imageMap[$ _str];	
			}
		}
		
		static __setImage = function(_str, _data) {
			if (COLLAGE_IMAGES_ARE_PUBLIC) {
				global.__CollageImageMap[$ _str] = _data;	
			} else {
				owner.__imageMap[$ _str] = _data;	
			}
		}
		
		static __build = function() {	
			// Store building time for verbose later
			var _startTime = get_timer();
			
			// Separate entries
			var _len = array_length(owner.__batchImageList);
			var _collageName = (owner.name != undefined) ? owner.name + " - ": "";
			if (_len == 0) {
				__CollageTrace(_collageName +"Building was commenced but there was no images to pack!");
				exit;
			}
			
			__CollageTrace(_collageName +"Building commenced! Attempting to pack " + string(array_length(owner.__batchImageList)) + " images!");
			// Begin gather texture data
			var _crop = owner.crop;
			var _texWidth = owner.width;
			var _texHeight = owner.height;
			var _spriteList = owner.__batchImageList;
			var _normalSprites = array_create(array_length(_spriteList));
			var _3DSprites = array_create(array_length(_spriteList));
			var _texPage = array_length(owner.__texPageArray) == 0 ? new __CollageTexturePageClass(_texWidth, _texHeight) : owner.__texPageArray[array_length(owner.__texPageArray)-1];
			var _sep = owner.separation;
			var _3DArraySize = 0;
			var _normalArraySize = 0;

			CollageSterlizeGPUState();
			
			// Early check out of boundaries + data.
			// This check is here to ensure that sprites are both ordered, and that we only get sprites that are valid.
			var _i = 0;
			repeat(_len) {
					var _spriteData = _spriteList[_i];
					var _spriteID = _spriteData.spriteID;
					var _spriteInfo = sprite_get_info(_spriteID);
					var _sprWidth = _spriteInfo.width;
					var _sprHeight = _spriteInfo.height;
					var _drawX, _drawY, _drawW, _drawH;
					var _xScale = 1;
					var _yScale = 1;
					var _forceScaled = false;
					if (_crop == true) {
						_drawX =		_spriteInfo.bbox_left;
						_drawY =		_spriteInfo.bbox_top;
						_drawW =	_spriteInfo.bbox_right-_drawX+1;
						_drawH =		_spriteInfo.bbox_bottom-_drawY+1;	
					} else {
						_drawX = 0;
						_drawY = 0;
						_drawW = _sprWidth;
						_drawH =  _sprHeight;		
					}
					
					var _bbWidth = _drawW;
					var _bbHeight = _drawH;
					var _ratio = 1;
					
					// Exit early code
					if (_drawW > _texWidth || _drawH > _texHeight) {
						if (!COLLAGE_SCALE_TO_TEXTURES_ON_PAGE) {
							__CollageTrace("Image " + string(_spriteData.name) + " is too big! Skipping...");
							if (_spriteData.isCopy) {
								sprite_delete(_spriteID);
							}
							array_delete(_spriteList, _i, 1);
							--_i;
						} else {
							_xScale = _texWidth/_drawW;
							_yScale = _texHeight/_drawH;
							_ratio = min(_xScale, _yScale);
							_bbWidth = _ratio * _drawW;
							_bbHeight = _ratio * _drawH;
							//_xScale = _xScale / (_ratio*2);
							//_yScale = _yScale / (_ratio*2);
							//_drawW = _bbWidth;
							//_drawH = _bbHeight;
							__CollageTrace("Sprite " + string(_spriteData.name) + " has been rescaled from width: " +  string(_drawW) + ", height: " + string(_drawH) + ", " + " to width: " + string(_bbWidth) + ", height: " + string(_bbHeight));
						}
					}
					
					
					var _newSpriteData = {
						spriteData: _spriteData,
						spriteID: _spriteID,
						spriteInfo: _spriteInfo,
						spriteWidth: _sprWidth,
						spriteHeight: _sprHeight,
						xScale: _xScale,
						yScale: _xScale,
						ratio: _ratio,
						bbWidth: _bbWidth,
						bbHeight: _bbHeight,
						drawX: _drawX,
						drawY: _drawY,
						drawW: _drawW,
						drawH: _drawH,
						wScale: _drawW * _ratio,
						hScale: _drawH * _ratio,
						originalWidth: _sprWidth,
						originalHeight: _sprHeight,
					}
					_spriteList[_i] = _newSpriteData;
					++_i;
			}
			_len = array_length(_spriteList);
			
			
			// Sort out by bbox
			if (_len > 1) {
				array_sort(_spriteList, function(elm1, elm2) {
					var _sizeA, _sizeB;
					_sizeA = (elm2.bbWidth + elm2.bbHeight) * .5; 
					_sizeB = (elm1.bbWidth + elm1.bbHeight) * .5;
					return  _sizeA - _sizeB;
				});
			}
			
			var _i = 0;
			
			// Separate sprites into two groups
			repeat(_len) {
			if (_spriteList[_i].spriteData.is3D) {
				_3DSprites[_3DArraySize++] = _spriteList[_i];	
			} else {
				_normalSprites[_normalArraySize++] = _spriteList[_i];	
			}	
			
				++_i;
			}
			
						
			// Resize back down
			array_resize(_normalSprites, _normalArraySize);	
			
			array_resize(_3DSprites, _3DArraySize);	
			
			// Clear List
			array_delete(_spriteList, 0, _len);
			
			if (init == false) {
				array_push(bboxPoints, {
					left: _sep,
					top: _sep,
					right: _texWidth - _sep,
					bottom: _texHeight - _sep
				});	
				init = true;
			}
			
			// Normal texture pages first
			if (array_length(_normalSprites) > 0) {
				// Begin texture mapping
				_texPage.start();	
			}
			
			for(var _ii = 0; _ii < array_length(_normalSprites); ++_ii) {
				var _spriteStruct = _normalSprites[_ii];
				var _spriteData = _spriteStruct.spriteData;
					var _spriteID = _spriteStruct.spriteID;
					var _spriteInfo = _spriteStruct.spriteInfo;
					var _sprWidth = _spriteStruct.spriteWidth;
					var _sprHeight = _spriteStruct.spriteHeight;
					var _drawX = _spriteStruct.drawX, _drawY = _spriteStruct.drawY, _drawW = _spriteStruct.drawW, _drawH = _spriteStruct.drawH;
					var _xScale = _spriteStruct.xScale;
					var _yScale = _spriteStruct.yScale;
					var _wScale = _spriteStruct.wScale;
					var _hScale = _spriteStruct.hScale;
					var _ogW = _spriteStruct.originalWidth;
					var _ogH = _spriteStruct.originalHeight;
					
					
					var _bbWidth = _spriteStruct.bbWidth;
					var _bbHeight = _spriteStruct.bbHeight;
					var _ratio = _spriteStruct.ratio;
					
					var _subStart = 0;
					if (COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... 0/" + string(_spriteInfo.num_subimages));
					if (__checkImage(_spriteData.name)) {
						switch(COLLAGE_IMAGE_NAME_COLLISION_HANDLE) {
							case 0:
								__CollageTrace(_collageName + _spriteData.name + " already exists! Skipping...");
								--_normalArraySize;
								continue;
								break;
							case 1:
								if !(((_spriteInfo.width == __getImage(_spriteData.name).width) && (_spriteInfo.height == __getImage(_spriteData.name).height))
								&& (_spriteInfo.bbox_right-_spriteInfo.bbox_left+1 == __getImage(_spriteData.name).cropWidth) && (_spriteInfo.bbox_bottom-_spriteInfo.bbox_top+1 == __getImage(_spriteData.name).cropHeight)) {
									var _spriteName = _spriteData.name;
									var _num = 1;
									var _name = _spriteName + string(_num);
									while(__checkImage(_name)) {
											var _name = _spriteName + string(++_num);
									}
									__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
									_spriteData.name = _name;
									
									var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
									// Lets add it to database
									__setImage(_spriteData.name, _imageInfo);
									
									var _subImages = _spriteInfo.num_subimages;
								} else {
									// Same width/height
									// Loop
									var _subImageLen = _spriteInfo.num_subimages;
									var _imageInfo = CollageGetImageInfo(_spriteData.name);
									var _uvsArray = _imageInfo.subImagesArray;
									var _uvsArrayLength = array_length(_uvsArray);
									var _uvi = 0;
									var _currentTexPage = _texPage;
									var _newTexPage = _texPage;
									var _changedTexPage = false;
									gpu_set_blendenable(true);
									repeat(_subImageLen) {
										if (_uvi >= _uvsArrayLength) break;
										var _uvs = _uvsArray[_uvi++];
										 _newTexPage = _uvs.texturePageStruct;
										if (_texPage != _newTexPage) {
											_changedTexPage = true;
											_texPage.finish();
											_texPage = _newTexPage;
											_texPage.start();
										}
										gpu_set_blendmode(bm_subtract);
										draw_rectangle_color(_uvs.left, _uvs.top, _uvs.left+_uvs.right,_uvs.top+ _uvs.bottom, c_black, c_black, c_black, c_black, false);
										gpu_set_blendmode(bm_normal);
										draw_sprite_part_ext(_spriteID, _uvi-1, _drawX, _drawY, _drawW,  _drawH, _uvs.left, _uvs.top, _ratio, _ratio, c_white, 1);
										if (COLLAGE_RENDER_DEBUG_LINES) {
											draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
											draw_rectangle(_uvs.left+1,_uvs.top+1,_uvs.left+_drawW-2,_uvs.top+_drawH-2, true);
											draw_set_colour(c_white);	
										}
									}
									
									if (_changedTexPage) {
										_texPage.finish();
										_texPage = _currentTexPage;
										_texPage.start();
									}
									
									gpu_set_blendenable(false);
									var _subImages = _subImageLen;
									var _subStart = (_subImageLen > _uvsArrayLength) ? (_subImageLen - _uvsArrayLength) : _subImageLen;
									_imageInfo.subImagesCount = _subImageLen;
									__CollageTrace(_collageName + _spriteData.name + " overwritten! (" + string(_subImageLen) + "/" + string(_uvsArrayLength) + ") Left over: " + string(max(_subImageLen - _uvsArrayLength, 0)));
								}
							break;
							
							case 2:
								var _spriteName = _spriteData.name;
								var _num = 1;
								var _name = _spriteName + string(_num);
								while(__checkImage(_name)) {
										var _name = _spriteName + string(++_num);
								}
								__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
								_spriteData.name = _name;
								
								var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
								// Lets add it to database
								__setImage(_spriteData.name, _imageInfo);
								var _subImages = _spriteInfo.num_subimages;
							break;
						}
					} else {
						var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
						// Lets add it to database
						__setImage(_spriteData.name, _imageInfo);
						
						var _subImages = _spriteInfo.num_subimages;
						owner.imageCount++;
						array_push(owner.__imageList, _imageInfo);
						if (COLLAGE_IMAGES_ARE_PUBLIC) owner.__imageMap[$ _spriteData.name] = _imageInfo;
					}
					for(var _sub = _subStart; _sub < _subImages; ++_sub) {
						var _emptySpaceSize = 0xFFFFFF;
						var _emptySpaceID = -1;
						for( var _n = 0; _n < array_length(bboxPoints); ++_n) {
						     if( _bbWidth <= bboxPoints[_n].right && _bbHeight <= bboxPoints[_n].bottom) {
						         var _resolve = (bboxPoints[_n].right + bboxPoints[_n].bottom ) / 2;
								 if (_resolve < _emptySpaceSize) {
						             _emptySpaceSize = _resolve;
						             _emptySpaceID = _n;
						        } 
						    }
						}
						
						// Refresh empty areas
						
						if(_emptySpaceID != -1) {
							var _currentPoint = bboxPoints[_emptySpaceID];
							draw_sprite_part_ext(_spriteID , _sub , _drawX  , _drawY , _drawW, _drawH, _currentPoint.left, _currentPoint.top, _ratio, _ratio, c_white, 1);
							/*if (_forceScaled) {
								_drawW = _drawW * _ratio;
								_drawH = _drawH * _ratio;
							}*/
							if (COLLAGE_RENDER_DEBUG_LINES) {
								draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
								draw_rectangle(_currentPoint.left+1,_currentPoint.top+1,_currentPoint.left+_wScale-2,_currentPoint.top+_hScale-2, true);
								draw_set_colour(c_white);	
							}
							
							var _uvX = _currentPoint.left; 
							var _uvY = _currentPoint.top;
							var _uvW = _wScale;
							var _uvH = _hScale;
							//show_debug_message([_currentPoint.left,_currentPoint.top,_currentPoint.left+_drawW,_currentPoint.top+_drawH]);
							var _uvs = new __CollageImageUVsClass(_texPage, owner.texPageCount, _uvX, _uvY, _uvW, _uvH, _drawX, _drawY, _ogW, _ogH, /*_sprWidth - _drawW - 2, _sprHeight - _drawH - 2,*/ _imageInfo.xoffset, _imageInfo.yoffset);
							_imageInfo.subImagesArray[_sub] = _uvs;
							//if (!_forceScaled) {
								// Store next available space
								if( _bbHeight < _currentPoint.bottom){ 
								    var _struct = {left: _currentPoint.left , top: _currentPoint.top + _drawH + _sep , right: _currentPoint.right , bottom: _currentPoint.bottom - _drawH - _sep};
									array_push(bboxPoints,_struct);
								}
								
								if( _bbWidth < _currentPoint.right) {
									var _struct = {left: _currentPoint.left + _drawW + _sep, top: _currentPoint.top, right: _currentPoint.right - _drawW - _sep, bottom: _drawH};
									array_push(bboxPoints,_struct);
								} 
							/*} else {
								array_push(bboxPoints, {left: 0, right: 0, top: 0, bottom: 0});
							}*/
							// Remove non-empty area
							if (COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... " + string(_sub+1) + "/" + string(_subImages));
							if (_sub == _subImages-1) {
								if (COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " has been processed...");	
							}
							array_delete(bboxPoints, _emptySpaceID, 1);
						} else {
							
							// We declare this finished
							_texPage.finish();
							
							// Save texture page
							if (owner.texPageCount == 0) || (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
								owner.__texPageArray[owner.texPageCount++] = _texPage;
							}
							_texPage = new __CollageTexturePageClass(_texWidth, _texHeight);
							_texPage.start();
							
							
							// Clear spaces and add new one
							array_delete(bboxPoints,0,array_length(bboxPoints));
							array_push(bboxPoints, {
								left: _sep,
								top: _sep,
								right: _texWidth - _sep,
								bottom: _texHeight - _sep
							});
							--_sub;
						}
					}
						
			}
			if (array_length(_normalSprites) > 0) {
				_texPage.finish();
			}
			
			// Give texture page + safety check
			if (array_length(_normalSprites) > 0) {
				if (owner.texPageCount != 0) {
					if (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
						owner.__texPageArray[owner.texPageCount++] = _texPage;
					}
				} else if (array_length(owner.__texPageArray) > 0) && (owner.__texPageArray[owner.texPageCount] == _texPage) {
					// Do nothing
				} else {
					owner.__texPageArray[owner.texPageCount++] = _texPage;	
				}
			}
			
			// Now do 3D textures
			for(var _ii = 0; _ii < array_length(_3DSprites); ++_ii) {
				var _spriteStruct = _3DSprites[_ii];
				var _spriteData = _spriteStruct.spriteData;
					var _spriteID = _spriteStruct.spriteID;
					var _spriteInfo = _spriteStruct.spriteInfo;
					var _sprWidth = _spriteStruct.spriteWidth;
					var _sprHeight = _spriteStruct.spriteHeight;
					var _drawX = _spriteStruct.drawX, _drawY = _spriteStruct.drawY, _drawW = _spriteStruct.drawW, _drawH = _spriteStruct.drawH;
					var _xScale = _spriteStruct.xScale;
					var _yScale = _spriteStruct.yScale;
					var _wScale = _spriteStruct.wScale;
					var _hScale = _spriteStruct.hScale;
					var _ogW = _spriteStruct.originalWidth;
					var _ogH = _spriteStruct.originalHeight;
					
					
					var _bbWidth = _spriteStruct.bbWidth;
					var _bbHeight = _spriteStruct.bbHeight;
					var _ratio = _spriteStruct.ratio;
					
					var _subStart = 0;
					if (COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... 0/" + string(_spriteInfo.num_subimages));
					if (__checkImage(_spriteData.name)) {
						switch(COLLAGE_IMAGE_NAME_COLLISION_HANDLE) {
							case 0:
								__CollageTrace(_collageName + _spriteData.name + " already exists! Skipping...");
								--_3DArraySize;
								continue;
							break;
							
							case 1:
								if !(((_spriteInfo.width == __checkImage(_spriteData.name).width) && (_spriteInfo.height == __checkImage(_spriteData.name).height))
								&& (_spriteInfo.bbox_right-_spriteInfo.bbox_left+1 == __checkImage(_spriteData.name).cropWidth) && (_spriteInfo.bbox_bottom-_spriteInfo.bbox_top+1 == __checkImage(_spriteData.name).cropHeight)) {
									var _spriteName = _spriteData.name;
									var _num = 1;
									var _name = _spriteName + string(_num);
									while(__checkImage(_spriteData.name)) {
											var _name = _spriteName + string(++_num);
									}
									__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
									_spriteData.name = _name;
									
									var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
									// Lets add it to database
									__setImage(_spriteData.name, _imageInfo);
									
									var _subImages = _spriteInfo.num_subimages;
								} else {
									// Same width/height
									// Loop
									var _subImageLen = _spriteInfo.num_subimages;
									var _imageInfo = CollageGetImageInfo(_spriteData.name);
									var _uvsArray = _imageInfo.subImagesArray;
									var _uvsArrayLength = array_length(_uvsArray);
									var _uvi = 0;
									var _newTexPage = _texPage;
									_texPage.start();
									repeat(_subImageLen) {
										if (_uvi >= _uvsArrayLength) break;
										var _uvs = _uvsArray[_uvi++];
										_newTexPage = _uvs.texturePageStruct;
										
										if (_texPage != _newTexPage) {
											_texPage.finish();
											_texPage = _newTexPage;
											_texPage.start();	
										}
										gpu_set_blendenable(true);
										gpu_set_blendmode(bm_subtract);
										draw_rectangle_color(_uvs.left, _uvs.top, _uvs.left+_uvs.right,_uvs.top+ _uvs.bottom, c_black, c_black, c_black, c_black, false);
										gpu_set_blendmode(bm_normal);
										gpu_set_blendenable(false);
										draw_sprite_part_ext(_spriteID, _uvi-1, _drawX, _drawY, _drawW,  _drawH, _uvs.left, _uvs.top, _ratio, _ratio, c_white, 1);
										if (COLLAGE_RENDER_DEBUG_LINES) {
											draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
											draw_rectangle(_uvs.left+1,_uvs.top+1,_uvs.left+_drawW-2,_uvs.top+_drawH-2, true);
											draw_set_colour(c_white);	
										}
									}
									_texPage.finish();
									gpu_set_blendenable(false);
									var _subImages = _subImageLen;
									var _subStart = (_subImageLen > _uvsArrayLength) ? (_subImageLen - _uvsArrayLength) : _subImageLen;
									_imageInfo.subImagesCount = _subImageLen;
									__CollageTrace(_spriteData.name + " overwritten! (" + string(_subImageLen) + "/" + string(_uvsArrayLength) + ") Left over: " + string(max(_subImageLen - _uvsArrayLength, 0)));
								}
							break;
							
							case 2:
								var _spriteName = _spriteData.name;
								var _num = 1;
								var _name = _spriteName + string(_num);
								while(__checkImage(_name)) {
										var _name = _spriteName + string(++_num);
								}
								__CollageTrace(_collageName + _spriteData.name + " already exists! Reidentified as " + _name);
								_spriteData.name = _name;
								
								var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
								// Lets add it to database
								__setImage(_spriteData.name, _imageInfo);
								var _subImages = _spriteInfo.num_subimages;
							break;
						}
					} else {
						var _imageInfo = new __CollageImageClass(_spriteInfo, _spriteData.name, _drawW, _drawH, _ratio);
						// Lets add it to database
						__setImage(_spriteData.name, _imageInfo);
						
						var _subImages = _spriteInfo.num_subimages;
						owner.imageCount++;
						array_push(owner.__imageList, _imageInfo);
						if (COLLAGE_IMAGES_ARE_PUBLIC) owner.__imageMap[$ _spriteData.name] = _imageInfo;
					}
					for(var _sub = _subStart; _sub < _subImages; ++_sub) {
							_texPage = new __CollageTexturePageClass(_texWidth, _texHeight);
							_texPage.start();
							draw_sprite_part_ext(_spriteID , _sub , _drawX  , _drawY , _drawW, _drawH, 0, 0, _ratio, _ratio, c_white, 1);
							/*if (_forceScaled) {
								_drawW = _drawW * _ratio;
								_drawH = _drawH * _ratio;
							}*/
							if (COLLAGE_RENDER_DEBUG_LINES) {
								draw_set_colour(make_color_hsv((current_time * 5) mod 256, 255, 255));
								draw_rectangle(_spriteInfo.bbox_left+1,_spriteInfo.bbox_top+1,_spriteInfo.bbox_left+_wScale-2,_spriteInfo.bbox_top+_hScale-2, true);
								draw_set_colour(c_white);	
							}
							
							var _uvX = 0; 
							var _uvY = 0;
							var _uvW = _wScale;
							var _uvH = _hScale;
							//show_debug_message([_currentPoint.left,_currentPoint.top,_currentPoint.left+_drawW,_currentPoint.top+_drawH]);
							var _uvs = new __CollageImageUVsClass(_texPage, owner.texPageCount, _uvX, _uvY, _uvW, _uvH, _drawX, _drawY, _ogW, _ogH,/*_sprWidth - _drawW - 2, _sprHeight - _drawH - 2,*/ _imageInfo.xoffset, _imageInfo.yoffset);
							_imageInfo.subImagesArray[_sub] = _uvs;
							// We declare this finished
							_texPage.finish();
							
							// Save texture page
							if (owner.texPageCount == 0) || (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
								owner.__texPageArray[owner.texPageCount++] = _texPage;
							}
							
							if (COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " is currently being processed... " + string(_sub+1) + "/" + string(_subImages));
							if (_sub == _subImages-1) {
								if (COLLAGE_VERBOSE) __CollageTrace(_collageName + _spriteData.name + " has been processed...");	
							}
						} 
					}			
			
			// Give texture page + safety check
			if (array_length(_3DSprites) > 0) {
				if (owner.texPageCount != 0) {
					if (owner.__texPageArray[owner.texPageCount-1] != _texPage) {
						owner.__texPageArray[owner.texPageCount++] = _texPage;
					}
				} else if (array_length(owner.__texPageArray) > 0) && (owner.__texPageArray[owner.texPageCount] == _texPage) {
					// Do nothing
				} else {
					owner.__texPageArray[owner.texPageCount++] = _texPage;	
				}
			}
			
			
			// Remove Sprites
			var _len = array_length(_normalSprites);
			var _i = 0;
			repeat(_len) {
				if (_normalSprites[_i].spriteData.isCopy) {
					sprite_delete(_normalSprites[_i].spriteID);
				}
				++_i;
			}
			
			var _len = array_length(_3DSprites);
			var _i = 0;
			repeat(_len) {
				if (_3DSprites[_i].spriteData.isCopy) {
					sprite_delete(_3DSprites[_i].spriteID);
				}
				++_i;
			}
			array_resize(owner.__batchImageList, 0);
			CollageRestoreGPUState();
			
			__CollageTrace(_collageName + "Building finished! Packed " + string(_normalArraySize) + " images and " + string(_3DArraySize) + " images with separate texture pages.");
			var _finalTime = (get_timer()-_startTime)/1000;
			if (COLLAGE_VERBOSE) __CollageTrace(_collageName + "Building took " + string(_finalTime) + "ms");
		}
	}
	
	static __getName = function() {
		return (is_undefined(name)) ? "" : name + " - ";	
	}
	
	static StartBatch = function() {
		if (__state == __CollageStates.BATCHING) {
			__CollageTrace(__getName() + "Currently in batching mode!");
			return self;
		}
		
		__state = __CollageStates.BATCHING;
		return self;
	}
	
	static ClearBatch = function() {
		if (__state == __CollageStates.BATCHING) {
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
		if (__state != __CollageStates.BATCHING) {
			__CollageTrace(__getName() + "Is not in batching mode!");
			return self;
		} 
		
		if (!__isWaitingOnAsync) builder.__build(_crop);
		__state = __CollageStates.NORMAL;
		return self;
	}
	
	static AddFile = function(_fileName, _identifierString = undefined, _subImage = 1, _removeBack = false, _smooth = false, _xOrigin = 0, _yOrigin = 0, _is3D = false) {
		if (!__CollageFileFromWeb(_fileName)) && (!file_exists(_fileName)) {
			// It doesn't exist, obviously!
			__CollageTrace(__getName() + "File " + string(_fileName) + " doesn't exist!");
			exit;
		}
		
		var _identifier = _identifierString;
		if (_identifier == undefined) {
			_identifier = __CollageGetName(_fileName);	
		}
		
		var _spriteID = sprite_add(_fileName, _subImage, _removeBack, _smooth, _xOrigin, _yOrigin);
		if (_spriteID == -1) {
			__CollageTrace(__getName() + "File " + string(_fileName) + " has an invalid formatting!");
			exit;
		}
		var _spriteData = new __CollageSpriteFileData(_identifier, _spriteID, _subImage, _xOrigin, _yOrigin, _is3D, true);
		
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
		
		if (__state == __CollageStates.NORMAL) {
			if (!__isWaitingOnAsync) builder.__build();
		}
	}
	
	static AddSprite = function(_spriteIdentifier, _identifierString = undefined, _isCopyBool = undefined, _is3D = false) {
		var _spriteID = _spriteIdentifier;
		var _isCopy = _isCopyBool;
		
		var _identifier = _identifierString;
		if (_identifier == undefined) {
			_identifier = sprite_get_name(_spriteID);
		}
		
		if (is_undefined(_isCopyBool)) {
			if (_spriteID < global.__CollageGMSpriteCount) {
				_isCopy = false;
				if (COLLAGE_VERBOSE) __CollageTrace(__getName() + _identifier + " is a GMSprite resource added via the IDE, making a copy...")
			} else {
				_isCopy = true;
			}
		} else {
			if ((_spriteID < global.__CollageGMSpriteCount) && (_isCopyBool == true)) {
				__CollageThrow(__getName() + "isCopy was provided true when the spriteID is a GMSprite asset provided via the IDE!");
			}
		}
		
		if (_isCopy == false) {
			_spriteID = sprite_duplicate(_spriteID);
		}
		
		// Add sprite data
		var _spriteData = new __CollageSpriteFileData(_identifier, _spriteID, sprite_get_number(_spriteID), sprite_get_xoffset(_spriteID), sprite_get_yoffset(_spriteID), _is3D, _isCopy);
		
		array_push(__batchImageList, _spriteData);
		
		if (__state == __CollageStates.NORMAL) {
			builder.__build();
		}
	}
	
	static AddFileStrip = function(_fileName, _identifierString = undefined, _removeBack = false, _smooth = false, _xOrigin = 0, _yOrigin = 0, _is3D = false) {
		if (!__CollageFileFromWeb(_fileName)) && (!file_exists(_fileName)) {
			// It doesn't exist, obviously!
			__CollageTrace(__getName() + "File " + string(_fileName) + " doesn't exist!");
			return -1;
		}
		
		var _identifier = _identifierString;
		if (_identifier == undefined) {
			_identifier = __CollageGetName(_fileName);	
		}
		
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
			if !(sprite_exists(_sprite)) {
				_sprite = sprite_create_from_surface(_surf, 0, 0, _width, _height, _removeBack, _smooth, _xOrigin, _yOrigin);	
			} else {
				sprite_add_from_surface(_sprite, _surf, 0, 0, _width, _height, _removeBack, _smooth);
			}
		}
		CollageRestoreGPUState();
		
		var _spriteData = new __CollageSpriteFileData(_identifier, _sprite, _offset, _xOrigin, _yOrigin, _is3D, true);
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
		
		if (__state == __CollageStates.NORMAL) {
			builder.__build();
		}
		surface_free(_surf);
	}
	
	static AddSurface = function(_surface, _identifierString = undefined, _x = 0, _y = 0, _w = surface_get_width(_surface), _h = surface_get_height(_surface), _removeBack = false, _smooth = false, _xOrigin = 0, _yOrigin = 0, _is3D = false) {
		var _spriteID = sprite_create_from_surface(_surface, _x, _y, _w, _h, _removeBack, _smooth, _xOrigin, _yOrigin);
		
		var _identifier = _identifierString;
		if (_identifier == undefined) {
			_identifier = "surface" + string(_surface);	
		}
		
		// Add sprite data
		var _spriteData = new __CollageSpriteFileData(_identifier, _spriteID, 1, _xOrigin, _yOrigin, _is3D, true);
		
		array_push(__batchImageList, _spriteData);
		
		if (__state == __CollageStates.NORMAL) {
			builder.__build();
		}
	}
	
	static FreePages = function() {
		var _i = 0;
		repeat(array_length(__texPageArray)) {
			__texPageArray[_i++].free();	
		}
		
		texPageCount = 0;
		var _i = 0;
		if (COLLAGE_IMAGES_ARE_PUBLIC) {
			repeat(imageCount) {
				variable_struct_remove(global.__CollageImageMap, __imageList[_i++].name);
			}	
		}
		
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
	
	static ImagesToArray = function() {
		var _array = array_create(array_length(__imageList));
		var _i = 0;
		repeat(array_length(_array)) {
			_array[_i] = __imageList[_i];
			++_i;
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
	
	// Members
	
	__state = __CollageStates.NORMAL;
	__texPageArray = [];
	texPageCount = 0;
	imageCount = 0;
	__batchImageList = [];
	__imageMap = {};
	__imageList = [];
	__asyncList = [];
	__isWaitingOnAsync = false;
	__status = CollageStatus.READY;
	builder = new __builder();
	separation = _sep;
	width = _width;
	height = _height;
	crop = _crop;
	name = is_undefined(_identifier) ? _identifier : string(_identifier);
	array_push(global.__CollageTexturePagesList, self);
	if (is_string(_identifier)) {
		if (variable_struct_exists(global.__CollageTexturePagesMap, _identifier)) {
			__CollageThrow(_identifier + " already exists as a Collage name!");	
		}
		
		global.__CollageTexturePagesMap[$ _identifier] = self;
	}
	
	// Init texture settings
	if (COLLAGE_ENSURE_POWER_TWO) && !(CollageIsPowerTwo(width) || CollageIsPowerTwo(height)) {
		width = CollageConvertPowerTwo(_width);
		height = CollageConvertPowerTwo(_height);
	} 
	
	if (COLLAGE_CLAMP_TEXTURE_SIZE) {
		width = clamp(width, COLLAGE_MIN_TEXTURE_SIZE, COLLAGE_MAX_TEXTURE_SIZE);
		height = clamp(height, COLLAGE_MIN_TEXTURE_SIZE, COLLAGE_MAX_TEXTURE_SIZE);
	}
	
}
