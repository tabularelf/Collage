texPage = new Collage();
texPage.StartBatch();
texPage.AddSprite(spr_alphatest, "1").SetPremultiplyAlpha(true);
texPage.AddSprite(spr_alphatest_premulti, "2");
texPage.FinishBatch();