# Getting Started

## What are texture pages?

Texture pages (also known as texture atlases) are essentially one big image that contains multiple smaller images. As your GPU can only hold onto so much information at a time, things are swapped out whenever needed. The intended use of texture pages is to reduce the amount of memory swap needed by storing as many images as possible, onto as few texture pages as possible.
Computers back in the old days worked with only power of two image sizes. But today texture pages can be any size. Though it's still common to see power of two texture pages. (Power of two as in 512x512, 1024x1024, 2048x2048, 4196x4196, etc.)

While GameMaker does make and use texture pages, there's currently no way to create them on the fly via code. This is where Collage comes in.

## Installing
1. Download Collage's .yymp from [releases!](https://github.com/tabularelf/Collage/releases)
2. With your GameMaker Project, drag the .yymp (or at the top goto Tools -> Import Local Package)
3. Press "Add All" and press "Import".

## Updating to a new version
?> If you've made changes to [`__CollageConfig`](configuration.md), consider backing it up (preferably with source control) before updating!

1. Delete `Collage`'s folder (with all scripts inside.)
2. Follow the steps through [Installing](#installing), but with the latest version.
3. Reimport your [`__CollageConfig`](configuration.md) (if changes were made)

## Using Collage
Collage includes a variety of ways to add images onto its texture pages. We can begin by creating a new [`Collage`](collage.md#collageidentifier-width-height-crop-separation-optimization) instance.<br>
```gml
texPage = new Collage();
```
[`Collage`](collage.md#collageidentifier-width-height-crop-separation-optimization) includes a bunch of optional arguments, which most default to the values defined in [`__CollageConfig`](configuration.md). These configs are changeable from here:<br>
- `__COLLAGE_DEFAULT_TEXTURE_SIZE`
- `__COLLAGE_DEFAULT_CROP`
- `__COLLAGE_DEFAULT_SEPARATION`
- `__COLLAGE_DEFAULT_OPTIMIZE`

The only one that's not included within the config is the `identifier` argument, which defaults to `undefined`. If declared, it can be used with [`CollageGet()`](general.md#collageget). In most cases, you do not need to specify any of these arguments.
However, you're free to include arguments if you need to either give it a name or override the default values. (Such in cases where the game is moddable.) Giving us:
```gml
texPage = new Collage("Characters", 2048, 2048, false, 0, true);
```

## Adding Images to a Collage instance
Here are some of the examples in which you can add images to Collage. (These were mostly taken/referenced from the project from the Github repo.)

<!-- tabs:start -->

#### **.AddSprite**

```gml
texPage = new Collage();
texPage.AddSprite(spr_soldier);
```

?> Unless otherwise specified by `isCopy`, Collage will auto-assign all sprites to be copies (including ones added via the IDE, though those will be duplicated.)

#### **.AddSurface**

```gml
texPage = new Collage();
var surf = surface_create(512, 512);
surface_set_target(surf);
draw_rectangle_color(0,0, 512, 512, c_red, c_blue, c_green, c_yellow, false);
surface_reset_target();

texPage.AddSurface(surf, "colours");
surface_free(surf);
```

?> This will add the underlying surface as a sprite. The surface itself still needs to be freed.

#### **.AddFile**

```gml
texPage = new Collage();
texPage.AddFile("soldier.png");
```

#### **.AddFileStrip**

```gml
texPage = new Collage();
texPage.AddFileStrip("soldier_strip.png");
```

#### **.AddSpriteSheet**

```gml
texPage = new Collage();
var _batSprite = sprite_add("bats.png", 1, false, false, 0, 0);
var _array = [
	CollageDefineSpriteSheet("spr_{{name}}_fly_down", 32, 0, 128, 32),
	CollageDefineSpriteSheet("spr_{{name}}_fly_right", 32, 32, 128, 32),
	CollageDefineSpriteSheet("spr_{{name}}_fly_up", 32, 64, 128, 32),
	CollageDefineSpriteSheet("spr_{{name}}_fly_left", 32, 96, 128, 32),
	CollageDefineSpriteSheet("spr_{{name}}_dead_down", 0, 0, 32, 32),
	CollageDefineSpriteSheet("spr_{{name}}_dead_right", 0, 32, 32, 32),
	CollageDefineSpriteSheet("spr_{{name}}_dead_up", 0, 64, 32, 32),
	CollageDefineSpriteSheet("spr_{{name}}_dead_left", 0, 96, 32, 32),
];
texPage.AddSpriteSheet(_batSprite, _array, "bat", 32, 32, false, false, CollageOrigin.CENTER, CollageOrigin.CENTER);
sprite_delete(_batSprite);
```

?> The spritesheet that's used won't be freed, as copies of it are used instead.

<!-- tabs:end -->

?> Each `.Add*` method has some additional parameters, most are entirely optional. You can see more by reading their specific documentation under [Collage](collage.md).

Once you've added your images, you can get their info via [`CollageImageGetInfo()`](image.md#collageimagegetinfoidentifier) or [`.ImageGetInfo()`](collage.md#imagegetinfoidentifier). Which you can then use to render the image.
```gml
// Getting image info
image = texPage.GetImageInfo("test");

// Rendering
draw_image(image, 0, x, y);
```