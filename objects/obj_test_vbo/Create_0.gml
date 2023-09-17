texPage = new Collage("Test", 2048, 2048, true, 0);
texPage.AddSprite(spr_soldier);

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_color();

format = vertex_format_end();

spriteVBuff = vertex_create_buffer();
collageVBuff = vertex_create_buffer();

batch = new CollageRenderPipeline();
