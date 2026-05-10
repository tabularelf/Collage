texPage = new Collage();
texPage.StartBatch();
texPage.AddEmptyImage("spr_bob").AddSpriteAsFrameExt([
	spr_coloured_cubes_far_too_many,
	spr_soldier,
]);
texPage.AddEmptyImage("spr_alice");
texPage.FinishBatch();

recent = texPage.GetRecent()[0];
index = 0;