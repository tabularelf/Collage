texPage = new Collage();
texPage.StartBatch();
var i = 0;
var _maxCol = power(2, 24);
repeat(1000) {
	texPage.AddSprite(spr_tiletest, string(i++)).SetBlend(irandom(_maxCol), random_range(0.01, 0.7));
}
texPage.FinishBatch();