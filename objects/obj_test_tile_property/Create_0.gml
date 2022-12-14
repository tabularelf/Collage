texPage = new Collage();
texPage.StartBatch();
texPage.AddSprite(spr_tiletest).SetTiling(true, true);
var i = 0;
repeat(1000) {
	texPage.AddSprite(spr_tiletest, string(i++)).SetTiling(true, true);	
}

repeat(10) {
	texPage.AddSprite(spr_tiletest9, string(i++)).SetTiling(true, true);	
}
texPage.FinishBatch();

show_debug_overlay(true);