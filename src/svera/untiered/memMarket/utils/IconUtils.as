package svera.untiered.memMarket.utils
{
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class IconUtils
{
    /* Draw the honor icon */
    public static function getHonorIcon(size:int = 40) : BitmapData
    {
        var honorBD:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",224);
        return TextureRedrawer.redraw(honorBD,size,true,0);
    }

    /* Draw the gold icon */
    public static function getCoinIcon(size:int = 40) : BitmapData
    {
        var honorBD:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        return TextureRedrawer.redraw(honorBD,size,true,0);
    }
}
}
