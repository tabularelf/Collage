texPage = new Collage(,256,256);
var _i = 0;
texPage.StartBatch();
repeat(11) {
	texPage.AddSprite(spr_coloured_cubes3, string(_i)).SetClump(true);
	++_i;
}
texPage.AddSprite(spr_coloured_cubes4).SetClump(true);
texPage.AddSprite(spr_coloured_cubes_too_many).SetClump(true);
texPage.AddSprite(spr_coloured_cubes_too_many, "rawr");
texPage.AddSprite(spr_coloured_cubes_far_too_many).SetClump(true);
texPage.FinishBatch();