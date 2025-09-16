package com.company.assembleegameclient.util {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.untiered.graphics.StarGraphic;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

public class HonorUtil {

    public static const STARS:Vector.<int> = new <int>[20, 150, 400, 800, 2000];

    private static const lightBlueCT:ColorTransform = new ColorTransform(138 / 255, 152 / 255, 222 / 255);

    private static const darkBlueCT:ColorTransform = new ColorTransform(49 / 255, 77 / 255, 219 / 255);

    private static const redCT:ColorTransform = new ColorTransform(193 / 255, 39 / 255, 45 / 255);

    private static const orangeCT:ColorTransform = new ColorTransform(247 / 255, 147 / 255, 30 / 255);

    private static const yellowCT:ColorTransform = new ColorTransform(255 / 255, 255 / 255, 0 / 255);

    public static const COLORS:Vector.<ColorTransform> = new <ColorTransform>[lightBlueCT, darkBlueCT, redCT, orangeCT, yellowCT];


    public function HonorUtil() {
        super();
    }

    public static function maxStars():int {
        return ObjectLibrary.playerChars_.length * STARS.length;
    }

    public static function numStars(honor:int):int {
        var num:int = 0;
        while (num < STARS.length && honor >= STARS[num]) {
            num++;
        }
        return num;
    }

    public static function nextStarHonor(bestHonor:int, currHonor:int):int {
        var curr:int = Math.max(bestHonor, currHonor);
        for (var i:int = 0; i < STARS.length; i++) {
            if (STARS[i] > curr) {
                return STARS[i];
            }
        }
        return -1;
    }

    public static function numStarsToBigImage(numStars:int):Sprite {
        var star:Sprite = numStarsToImage(numStars);
        star.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        star.scaleX = 1.4;
        star.scaleY = 1.4;
        return star;
    }

    public static function numStarsToImage(numStars:int):Sprite {
        var star:Sprite = new StarGraphic();
        if (numStars < ObjectLibrary.playerChars_.length) {
            star.transform.colorTransform = lightBlueCT;
        } else if (numStars < ObjectLibrary.playerChars_.length * 2) {
            star.transform.colorTransform = darkBlueCT;
        } else if (numStars < ObjectLibrary.playerChars_.length * 3) {
            star.transform.colorTransform = redCT;
        } else if (numStars < ObjectLibrary.playerChars_.length * 4) {
            star.transform.colorTransform = orangeCT;
        } else if (numStars < ObjectLibrary.playerChars_.length * 5) {
            star.transform.colorTransform = yellowCT;
        }
        return star;
    }

    public static function numStarsToIcon(numStars:int):Sprite {
        var star:Sprite;
        star = numStarsToImage(numStars);
        var sprite:Sprite = new Sprite();
        sprite.graphics.beginFill(0, 0.4);
        var w:int = star.width / 2 + 2;
        var h:int = star.height / 2 + 2;
        sprite.graphics.drawCircle(w, h, w);
        star.x = 2;
        star.y = 1;
        sprite.addChild(star);
        sprite.filters = [new DropShadowFilter(0, 0, 0, 0.5, 6, 6, 1)];
        return sprite;
    }

    public static function getHonorIcon():BitmapData {
        var honor:BitmapData = AssetLibrary.getImageFromSet("Currency_Icons16x16", 0);
        return TextureRedrawer.redraw(honor, 40, true, 0);
    }
}
}
