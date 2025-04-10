package svera.untiered.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import svera.untiered.core.StaticInjectorContext;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.raidLauncher.RaidLauncherModal;
import svera.untiered.ui.UIUtils;

public class RaidLauncherButton extends Sprite {

    public static const IMAGE_NAME:String = "lofiCharBig";
    public static const IMAGE_ID:int = 100;

    private var bitmap:Bitmap;
    private var background:Sprite;
    private var markShopTexture:BitmapData;
    private var tooltip:TextToolTip;
    public var gs_:GameSprite;

    public function RaidLauncherButton() {
        this.tooltip = new TextToolTip(0x363636, 0x660000, null, "Click to open raid launcher.", 200);
        super();
        mouseChildren = false;
        this.markShopTexture = TextureRedrawer.redraw(AssetLibrary.getImageFromSet(IMAGE_NAME, IMAGE_ID), 28, true, 0);
        this.background = UIUtils.makeHUDBackground(28, 27);
        this.bitmap = new Bitmap(this.markShopTexture);
        this.bitmap.x = -9;
        this.bitmap.y = -9;
        this.drawAsOpen();
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    public function drawAsOpen():void {
        addChild(this.background);
        addChild(this.bitmap);
    }

    public function onClick(_arg_1:MouseEvent):void {
        var _local_2:OpenDialogSignal = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        _local_2.dispatch(new RaidLauncherModal());
        SoundEffectLibrary.play("button_click");
    }

    public function drawAsClosed():void {
        if (((this.background) && ((this.background.parent == this)))) {
            removeChild(this.background);
        }
        if (((this.bitmap) && ((this.bitmap.parent == this)))) {
            removeChild(this.bitmap);
        }
    }


}
}//package svera.untiered.game.view
