package svera.untiered.account.core.view {
import com.company.assembleegameclient.ui.TextButton;
import com.company.ui.SimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import org.osflash.signals.Signal;

public class EmptyFrame extends Sprite {
    public static const TEXT_MARGIN:int = 20;

    public var register:Signal;
    public var cancel:Signal;
    protected var modalWidth:Number;
    protected var modalHeight:Number;
    protected var closeButton:TextButton;
    protected var background:Sprite;
    protected var backgroundContainer:Sprite;
    protected var title:SimpleText;
    protected var desc:SimpleText;

    public function EmptyFrame(_arg1:int = 288, _arg2:int = 150, _arg3:String = "") {
        this.modalWidth = _arg1;
        this.modalHeight = _arg2;
        x = 400 - this.modalWidth / 2;
        y = 300 - this.modalHeight / 2;
        if (_arg3 != "") {
            this.setTitle(_arg3, true);
        }
        if (this.background == null) {
            this.backgroundContainer = new Sprite();
            this.background = this.makeModalBackground();
            this.backgroundContainer.addChild(this.background);
            addChild(this.backgroundContainer);
        }
        if (_arg3 != "") {
            this.setTitle(_arg3, true);
        }
    }

    private function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        if (this.closeButton != null) {
            this.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
        }
    }

    public function setTitle(_arg1:String, _arg2:Boolean):void {
        if (!(this.title == null) && !(this.title.parent == null)) {
            removeChild(this.title);
        }
        if (_arg1 != null) {
            this.title = this.getText(_arg1, TEXT_MARGIN, 5, _arg2);
            addChild(this.title);
        } else {
            this.title = null;
        }
    }

    public function setDesc(_arg1:String, _arg2:Boolean):void {
        if (_arg1 != null) {
            if (!(this.desc == null) && !(this.desc.parent == null)) {
                removeChild(this.desc);
            }
            this.desc = this.getText(_arg1, TEXT_MARGIN, 50, _arg2);
            addChild(this.desc);
        }
    }

    public function setCloseButton(_arg1:Boolean):void {
        if (this.closeButton == null && _arg1) {
            this.closeButton = new TextButton(24,"X",modalWidth);
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClick);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            addChild(this.closeButton);
        } else {
            if (!(this.closeButton == null) && !_arg1) {
                removeChild(this.closeButton);
                this.closeButton = null;
            }
        }
    }

    protected function getText(_arg1:String, _arg2:int, _arg3:int, _arg4:Boolean):SimpleText {
        var _local5:SimpleText = new SimpleText(18, 0xFFFFFF, modalWidth - TEXT_MARGIN * 2 - 10);

        _local5.setBold(true);
        _local5.setText(_arg1);

        _local5.wordWrap = true;
        _local5.multiline = true;
        _local5.autoSize = TextFieldAutoSize.CENTER;
        _local5.setAlignment(TextFormatAlign.CENTER);
        _local5.filters = [new DropShadowFilter(0, 0, 0)];
        _local5.x = _arg2;
        _local5.y = _arg3;
        return _local5;
    }

    protected function makeModalBackground():Sprite {
        x = 400 - this.modalWidth / 2;
        y = 300 - this.modalHeight / 2;
        var bg:Sprite = new Sprite();
        bg.graphics.beginFill(3552822);
        bg.graphics.drawRect(0, 0, modalWidth, modalHeight);
/*        if (this.title != null) {
            _local1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        }*/
        return bg;
    }

    public function onCloseClick(_arg1:MouseEvent):void {
    }
}
}
