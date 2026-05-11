texPage = new Collage("Test");
texPage.AddSprite(spr_soldier);
texPage.AddSprite(spr_tiletest);

staticGroup = texPage.ToStatic(true);
sprites = staticGroup.GetSprites();