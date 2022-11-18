texPage = new Collage();
surf = surface_create(512, 512);
surface_set_target(surf);
draw_rectangle_color(0,0, 512, 512, c_red, c_blue, c_green, c_yellow, false);
surface_reset_target();

texPage.AddSurface(surf, "test");
/*
tempsurf = surface_create(512, 512);
surface_set_target(tempsurf);
draw_rectangle_color(0, 0, 512, 512, c_red, c_blue, c_green, c_yellow, false);
surface_reset_target();
sprite = sprite_create_from_surface(tempsurf, 0, 0, 512, 512, false, false, 0, 0);
surf2 = surface_create(1024, 1024);
surface_set_target(surf2);
draw_sprite(sprite, 0, 0, 0);
surface_reset_target();