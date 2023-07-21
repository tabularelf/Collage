# Home
<center>
<p>Texture Page Packer for GameMaker.<br>

[Download the latest .yymp here!](https://github.com/tabularelf/Collage/releases)

</center>

---

Collage is a texture page builder/packer and image manager, built from the ground up to mimic GameMaker's texture page packing, while offer a lot of flexibility.

# Features

- Packing images together onto multiple texture pages.
- Matching power of two constraints, to ensure that you're not making odd texture page sizes.
- On the fly sprite live-reloading. (With some catches.)
- Lots of configurability!

# Supported Platforms

|  Windows  |  MacOSX  |  Linux  |  iOS  |  Android  |  HTML5  |  Opera GX  |  Console  |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |

# FAQ

## **Why was Collage made?**

Collage was designed in mind to work around the limitaitons of `sprite_add()` adding an entire texture page just for each and every sprite sub image, per sprite.
While also enabling the creation of texture pages on the fly. Collage is specifically designed to mimic GameMakers own texture page system, and thus works in much the same logic as GameMakers.

## **What could I use Collage for?**

Here are some examples of that you can use Collage for.<br>
- Live reloading of images.
- Caching shader-baked images.
- Converting a sprite sheet into multiple individual sprites.
- Texture pack support.
- Modding support.
- Generating and caching surface contents as an image.
- Adding images from over the web. (Such as Gravatars)

## **Can Collage work with my existing project?**

Collage is designed first and foremost to bridge as much compatibility as possible with your existing project, without requiring lots of reworking. 
Just drop in Collage, replace all `draw_sprite*` functions with `draw_image*` equivilants and you're good to go!

?> Collage doesn't currently work with `draw_self()`. A future compatibility may be introduced for this.

# License

Collage is under the [MIT License](https://github.com/tabularelf/Collage/blob/main/LICENSE).