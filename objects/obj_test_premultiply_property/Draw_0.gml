var _info1 = texPage.GetImageInfo("1");
var _info2 = texPage.GetImageInfo("2");
var _time = current_time/100;
draw_image(_info1, _time, 50, 50);	
draw_image(_info2, _time, 306, 50);

draw_image_ext(_info1, _time, 306, 450, -1, 1, 0, c_white, 1);	
draw_image(_info2, _time, 306, 450);

draw_image(spr_alphatest, _time, 800, 50);
draw_image(spr_alphatest_premulti, _time, 800, 450);