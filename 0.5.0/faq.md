# FAQ
## Does Collage support loading gif files?
Collage entirely depends on `sprite_add` in any places where loading from disk, and as of this time, `sprite_add` does not support gifs. Highly suggested instead to utilize `.AddSprite()`, and utilising an extension like [`sprite_add_gif`](https://yellowafterlife.itch.io/gamemaker-sprite-add-gif) by YellowAfterLife.

## What is a sprite strip (or file strip)?
A sprite strip (or also known as a file strip) is an image with separate frames. Such as this solder walking animation by [`z11z11 from opengameart.org`](https://opengameart.org/content/soldier-walking-animation). 

![](https://raw.githubusercontent.com/tabularelf/Collage/refs/heads/main/datafiles/spr_soldier.png)

## What is a sprite sheet?
A sprite sheet is an image similar to a sprite strip, except with multiple sprite strips in one. Such as this bats sprite sheet by [`bagzie from opengameart.org`](https://opengameart.org/content/bat-sprite). 

![](https://raw.githubusercontent.com/tabularelf/Collage/refs/heads/main/datafiles/bats.png)

GameMaker doesn't support this naturally, so it's advisable that you use [`.AddSpriteSheet()`](collage.md?id=addspritesheetspriteid-spritearray-identifierstring-width-height-removeback-smooth-xorigin-yorigin-separatetexture) for adding in an array of sprite info arrays.