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
        x = GameClient.HalfStageWidth - this.modalWidth / 2;
        y = GameClient.HalfStageHeight - this.modalHeight / 2;
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
            this.closeButton = new TextButton(24,"X",30);
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClick);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            addChild(this.closeButton);
        } else if (this.closeButton != null && !_arg1) {
            removeChild(this.closeButton);
            this.closeButton = null;
        }
    }

    protected function getText(text:String, x_:int, y_:int, _arg4:Boolean):SimpleText {
        var simpleText:SimpleText = new SimpleText(18, 0xFFFFFF, false,modalWidth - TEXT_MARGIN * 2 - 10);

        simpleText.setBold(true);
        simpleText.setText(text);
        simpleText.wordWrap = true;
        simpleText.multiline = true;
        simpleText.autoSize = TextFieldAutoSize.CENTER;
        simpleText.setAlignment(TextFormatAlign.CENTER);
        simpleText.filters = [new DropShadowFilter(0, 0, 0)];
        simpleText.x = x_;
        simpleText.y = y_;
        return simpleText;
    }

    protected function makeModalBackground():Sprite {
        x = GameClient.HalfStageWidth - this.modalWidth / 2;
        y = GameClient.HalfStageHeight - this.modalHeight / 2;
        var bg:Sprite = new Sprite();
        bg.graphics.beginFill(3552822);
        bg.graphics.drawRect(0, 0, modalWidth, modalHeight);
/*        if (this.title != null) {
            _local1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        }*/
        return bg;
    }

    public function onCloseClick(_arg1:MouseEvent):void {
        parent.removeChild(this);
    }
}
}
