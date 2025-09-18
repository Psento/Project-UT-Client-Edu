package svera.untiered.classes.view {
import com.company.ui.SimpleText;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import org.osflash.signals.Signal;

import svera.untiered.assets.model.Animation;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;

public class CharacterSkinListItem extends Sprite {
    private const grayscaleMatrix:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
    private var nameText:SimpleText;
    private var lock:Bitmap;
    private var purchasingText:SimpleText;
    public const over:Signal = new Signal();
    public const out:Signal = new Signal();
    public var selected:Signal = new Signal();
    public var model:CharacterSkin;
    public var state:CharacterSkinState;
    private var isOver:Boolean;
    public var index:int = 0;
    public var initialAngle:Number = 0;
    public var angle:Number = 0;

    public function CharacterSkinListItem() {
        this.state = CharacterSkinState.NULL;
        nameText = makeNameText();
        lock = makeLock();
        purchasingText = makeLockText();
        super();
    }

    private function makeNameText():SimpleText {
        var text:SimpleText = new SimpleText(12, 16777215, false, 0, 0);
        text.setBold(true);
        text.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        text.updateMetrics();
        addChild(text);
        return text;
    }

    private function makeLock():Bitmap {
        var bitmap:Bitmap = new Bitmap();
        bitmap.scaleX = 2;
        bitmap.scaleY = 2;
        bitmap.y = height * 0.5 - 4;
        bitmap.visible = false;
        addChild(bitmap);
        return bitmap;
    }

    public function setLockIcon(data:BitmapData):void {
        this.lock.bitmapData = data;
        this.lock.x = this.purchasingText.x - this.lock.width - 5;
    }

    private function makeLockText():SimpleText {
        var text:SimpleText = new SimpleText(14, 16777215, false, 0, 0);
        addChild(text);
        return text;
    }

    public function setSkin(icon:Animation):void {
        addChild(icon)
        icon.start();
    }

    public function getModel():CharacterSkin {
        return this.model;
    }

    public function setModel(value:CharacterSkin):void {
        this.model && this.model.changed.remove(this.onModelChanged);
        this.model = value;
        this.model && this.model.changed.add(this.onModelChanged);

        this.onModelChanged(this.model);

        addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
    }

    private function onModelChanged(skin:CharacterSkin):void {
        this.state = Boolean(skin) ? skin.getState() : CharacterSkinState.NULL;
        this.updateName();
        this.updateState();
    }

    public function getState():CharacterSkinState {
        return this.state;
    }

    private function updateName():void {
        nameText.text = Boolean(this.model) ? this.model.name : "";
        nameText.updateMetrics();
        nameText.x = (width - nameText.width) / 2;
        nameText.y = height - nameText.textHeight;
    }

    private function updateState():void {
        updateGrayFilter();
    }

    private function onOver(e:MouseEvent):void {
        this.isOver = true;

        this.over.dispatch();
        if (this.state.isDisabled()) {
            transform.colorTransform = new ColorTransform(0.5, 0.5, 0.5);
            return;
        }
        transform.colorTransform = new ColorTransform(1.2, 1.2, 1.2);
    }

    private function onOut(e:MouseEvent):void {
        this.isOver = false;
        this.out.dispatch();
        if (this.state.isDisabled()) {
            transform.colorTransform = new ColorTransform(0.5, 0.5, 0.5);
            return;
        }
        transform.colorTransform = new ColorTransform(1, 1, 1);

    }

    private function updateGrayFilter():void {
        filters = this.state == CharacterSkinState.PURCHASING ? [grayscaleMatrix] : [];
    }
}
}
