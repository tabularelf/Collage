texPage = new Collage();
var _i = 0;
texPage.StartBatch();
texPage.AddSprite(spr_dot).SetPriority(99);
repeat(11) {
	texPage.AddSprite(spr_coloured_cubes3, string(_i)).SetPriority(_i);
	++_i;
}
texPage.AddSprite(spr_coloured_cubes4);
texPage.AddSprite(spr_tiletest9);
texPage.AddSprite(spr_coloured_cubes_too_many, "rawr");
texPage.FinishBatch();