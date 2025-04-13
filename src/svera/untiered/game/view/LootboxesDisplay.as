package svera.untiered.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.ui.SimpleText;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import org.osflash.signals.Signal;

public class LootboxesDisplay extends Sprite {

    private static const FONT_SIZE:int = 18;
    public static const IMAGE_NAME:String = "legendaries8x8Embed";
    public static const IMAGE_ID:int = 16;

    public var lootbox2Text:SimpleText;
    public var lootbox3Text:SimpleText;
    public var lootbox4Text:SimpleText;
    public var lootbox2Icon:Bitmap;
    public var lootbox3Icon:Bitmap;
    public var lootbox4Icon:Bitmap;
    private var lootBox2_:int = -1;
    private var lootBox3_:int = -1;
    private var lootBox4_:int = -1;
    private var gs:GameSprite;
    public var openAccountDialog:Signal;

    public function LootboxesDisplay(_arg_1:GameSprite = null) {
        this.openAccountDialog = new Signal();
        super();
        this.gs = _arg_1;

            this.lootbox2Text = this.makeTextField();
            addChild(this.lootbox2Text);
        var _local_6:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, 459);
        _local_6 = TextureRedrawer.redraw(_local_6, 40, true, 0);
            this.lootbox2Icon = new Bitmap(_local_6);
            addChild(this.lootbox2Icon);

        this.lootbox3Text = this.makeTextField();
        addChild(this.lootbox3Text);
        var _local_7:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, 18);
        _local_7 = TextureRedrawer.redraw(_local_7, 40, true, 0);
        this.lootbox3Icon = new Bitmap(_local_7);
        addChild(this.lootbox3Icon);

        this.lootbox4Text = this.makeTextField();
        addChild(this.lootbox4Text);
        var _local_8:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, 19);
        _local_8 = TextureRedrawer.redraw(_local_8, 40, true, 0);
        this.lootbox4Icon = new Bitmap(_local_8);
        addChild(this.lootbox4Icon);


        this.draw( 0, 0, 0);
        mouseEnabled = true;
        doubleClickEnabled = true;
        addEventListener(MouseEvent.DOUBLE_CLICK, this.onDoubleClick, false, 0, true);
    }

    private function onDoubleClick(_arg_1:MouseEvent):void {
        if (!(this.gs) || this.gs.isNexus_ || Parameters.data_.clickForTsavorite) {
            this.openAccountDialog.dispatch();
        }
    }

    public function makeTextField(_arg_1:uint = 0xFFFFFF):SimpleText {
        var _local_2:SimpleText = new SimpleText(FONT_SIZE, _arg_1,false ,0,16);
        _local_2.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        return _local_2;
    }

    public function draw( _arg_1:int, _arg_2:int, _arg_3:int):void {
        this.lootBox2_ = _arg_1;
        this.lootBox3_ = _arg_2;
        this.lootBox4_ = _arg_3;
        this.lootbox2Text.setText(this.lootBox2_.toString());
        this.lootbox3Text.setText(this.lootBox3_.toString());
        this.lootbox4Text.setText(this.lootBox4_.toString());
    }



}
}//package svera.untiered.game.view
