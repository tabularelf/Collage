var _time = current_time div 1000;
var _xoffset = sprite_get_xoffset(spr_soldier);
var _yoffset = sprite_get_yoffset(spr_soldier);

collageArray = image_get_uvs(CollageImageGetInfo("spr_soldier"), _time);
spriteArray = sprite_get_uvs(spr_soldier, _time);
buildVBO(spriteVBuff, format, spriteArray,  _xoffset, _yoffset);
buildVBO(collageVBuff, format, collageArray, _xoffset + sprite_get_width(spr_soldier), _yoffset);


vertex_submit(collageVBuff, pr_trianglelist, CollageImageGetInfo("spr_soldier").GetTexture(_time));
vertex_submit(spriteVBuff, pr_trianglelist, sprite_get_texture(spr_soldier, _time));
draw_image(spr_soldier, _time, _xoffset, _yoffset + sprite_get_height(spr_soldier));
draw_image(CollageImageGetInfo("spr_soldier"), _time, _xoffset + sprite_get_width(spr_soldier), _yoffset + sprite_get_height(spr_soldier));


batch.Start();
batch.AddImage(CollageImageGetInfo("spr_soldier"), 0, 512, _yoffset);
batch.Finish();
batch.Draw();