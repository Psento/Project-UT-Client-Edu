package svera.untiered.raidLauncher {
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.TextButton;
import com.company.ui.SimpleText;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import svera.untiered.account.core.view.EmptyFrame;
import svera.untiered.core.StaticInjectorContext;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.lootBoxes.PopupWindowBackground;

public class RaidLauncherModal extends EmptyFrame {
    public static const MODAL_WIDTH:int = 440;
    public static const MODAL_HEIGHT:int = 500;

    [Embed(source="RaidLauncher_backgroundImageEmbed.png")]
    public static var backgroundImageEmbed:Class;
    [Embed(source="Raid1_launchFlag.png")]
    public static var raid1launchFlagEmbed:Class;
    [Embed(source="Raid2_launchFlag.png")]
    public static var raid2launchFlagEmbed:Class;
    [Embed(source="Raid3_launchFlag.png")]
    public static var raid3launchFlagEmbed:Class;
    public static var modalWidth:int = MODAL_WIDTH;
    public static var modalHeight:int = MODAL_HEIGHT;

    public var launchButton:TextButton;
    public var launchButton2:TextButton;
    public var launchButton3:TextButton;

    public function RaidLauncherModal() {
        modalWidth = MODAL_WIDTH;
        modalHeight = MODAL_HEIGHT;
        super(modalWidth, modalHeight);
        this.setCloseButton(true);
        this.setTitle("Choose a raid to launch", true);
        closeButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
    }

    public static function getText(_arg1:String, _arg2:int, _arg3:int, _arg4:Boolean):SimpleText {
        var _local5:SimpleText = new SimpleText(18, 0xFFFFFF, false, RaidLauncherModal.modalWidth - TEXT_MARGIN * 2 - 10);
        _local5.setBold(true);
        _local5.setText(_arg1)
        _local5.wordWrap = true;
        _local5.multiline = true;
        _local5.autoSize = TextFieldAutoSize.CENTER;
        _local5.setAlignment(TextFormatAlign.CENTER);
        _local5.filters = [new DropShadowFilter(0, 0, 0)];
        _local5.x = _arg2;
        _local5.y = _arg3;
        return _local5;
    }

    public function onCloseButtonClicked(e:Event):void {
        var _local1:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
        _local1.dispatch();
    }

    public function onClick(_arg1:MouseEvent):void {
    }

    override protected function makeModalBackground():Sprite {
        var _local1:Sprite = new Sprite();
        var _local2:DisplayObject = new Bitmap(new backgroundImageEmbed().bitmapData);
        _local2.width = modalWidth + 1;
        _local2.height = modalHeight - 25;
        _local2.y = 27;
        _local2.alpha = 1.00;
        var _local3:DisplayObject = new Bitmap(new raid1launchFlagEmbed().bitmapData);
        _local3.width = 440;
        _local3.height = 80;
        _local3.y = 30;
        _local3.alpha = 1.00;
        var _local5:DisplayObject = new Bitmap(new raid2launchFlagEmbed().bitmapData);
        _local5.width = 440;
        _local5.height = 80;
        _local5.y = 150;
        _local5.alpha = 1;
        var _local6:DisplayObject = new Bitmap(new raid3launchFlagEmbed().bitmapData);
        _local6.width = 330;
        _local6.height = 80;
        _local6.y = 270;
        _local6.alpha = 1;
        var _local4:PopupWindowBackground = new PopupWindowBackground();
        _local4.draw(modalWidth, modalHeight, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
        _local1.addChild(_local2);
        _local1.addChild(_local3);
        _local1.addChild(_local4);
        _local1.addChild(_local5);
        _local1.addChild(_local6);
        this.launchButton = new TextButton(12, "Launch");
        this.launchButton.y = 118;
        this.launchButton.x = this.launchButton.x + 10;
        this.launchButton.setEnabled(true);
        _local1.addChild(this.launchButton);

        this.launchButton2 = new TextButton(12, "Launch");
        this.launchButton2.y = 236;
        this.launchButton2.x = this.launchButton2.x + 10;
        this.launchButton2.setEnabled(true);
        _local1.addChild(this.launchButton2);

        this.launchButton3 = new TextButton(12, "Launch");
        this.launchButton3.y = 354;
        this.launchButton3.x = this.launchButton3.x + 10;
        this.launchButton3.setEnabled(true);
        _local1.addChild(this.launchButton3);
        return _local1;
    }

    private function onMouseClick(e:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
    }

    override public function onCloseClick(_arg1:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
    }
}
}
