package svera.untiered.classes.view {
import com.company.assembleegameclient.screens.charrects.CharacterRect;
import com.company.assembleegameclient.util.Currency;
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
import org.osflash.signals.natives.NativeMappedSignal;

import svera.untiered.assets.model.Animation;

import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.util.components.LegacyBuyButton;
import svera.untiered.util.components.RadioButton;
import svera.untiered.util.components.api.BuyButton;

public class CharacterSkinListItem extends Sprite {
    private const grayscaleMatrix:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
    private var bg:Bitmap;
    private var nameText:SimpleText;
    private var lock:Bitmap;
    private var purchasingText:SimpleText;
    private var buyButtonContainer:Sprite;
    private var selectionButton:RadioButton;
    public var buy:NativeMappedSignal;
    public const over:Signal = new Signal();
    public const out:Signal = new Signal();
    public var selected:Signal;
    public var model:CharacterSkin;
    private var state:CharacterSkinState;
    private var isSelected:Boolean = false;
    private var buyButton:BuyButton;
    private var isOver:Boolean;
    public var index:int = 0;

    public function CharacterSkinListItem() {
        this.state = CharacterSkinState.NULL;
        nameText = makeNameText();
        lock = makeLock();
        purchasingText = makeLockText();
        buyButtonContainer = makeBuyButtonContainer();
        selectionButton = makeSelectionButton();
        selected = selectionButton.changed;
        buy = new NativeMappedSignal(buyButtonContainer, MouseEvent.CLICK);
        super();
    }

    private function makeNameText():SimpleText {
        var text:SimpleText = new SimpleText(18, 16777215, false, 0, 0);
        text.setBold(true);
        text.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        text.updateMetrics();
        addChild(text);
        return text;
    }

    private function makeSelectionButton():RadioButton {
        var button:RadioButton = new RadioButton();
        button.setSelected(false);
        button.x = 2;
        button.y = 0;
        addChild(button);
        return button;
    }

    private function makeLock():Bitmap {
        var bitmap:Bitmap = new Bitmap();
        bitmap.scaleX = 2;
        bitmap.scaleY = 2;
        bitmap.y = bg.height * 0.5 - 4;
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
        this.buyButton && this.setCost();
        this.updatePurchasingText();
        this.setIsSelected(skin && skin.getIsSelected());
    }

    public function getState():CharacterSkinState {
        return this.state;
    }

    private function updateName():void {
        nameText.text = Boolean(this.model) ? this.model.name : "";
        nameText.updateMetrics();
        nameText.x = (bg.width - nameText.width) / 2;
        nameText.y = bg.height - nameText.textHeight;
    }

    private function updateState():void {
        setButtonVisibilities();
        setEventListeners();
        updateGrayFilter();
    }

    private function setButtonVisibilities():void {
        var isOwned:Boolean = this.state == CharacterSkinState.OWNED;
        var isPurchasable:Boolean = this.state == CharacterSkinState.PURCHASABLE;
        var isPurchasing:Boolean = this.state == CharacterSkinState.PURCHASING;
        this.selectionButton.visible = isOwned;
        this.buyButtonContainer && (this.buyButtonContainer.visible = isPurchasable);
        this.purchasingText.visible = isPurchasing;
    }

    private function setEventListeners():void {
        if (this.state == CharacterSkinState.OWNED) {
            this.addEventListeners();
        } else {
            this.removeEventListeners();
        }
    }

    private function setCost():void {
        var cost:int = Boolean(model) ? model.cost : 0;
        this.buyButton.setPrice(cost, Currency.TSAVORITE);
        this.buyButton.setWidth(50);
    }

    public function getIsSelected():Boolean {
        return this.isSelected;
    }

    public function setIsSelected(value:Boolean):void {
        this.isSelected = value && this.state == CharacterSkinState.OWNED;
        this.selectionButton.setSelected(value);
    }

    private function updatePurchasingText():void {
        this.purchasingText.text = "Purchasing...";
        this.purchasingText.updateMetrics();
        this.purchasingText.x = bg.width - this.purchasingText.width - 15;
        this.purchasingText.y = bg.height / 2 - this.purchasingText.height / 2;
        this.lock.x = this.purchasingText.x - this.lock.width - 5;
    }

    private function addEventListeners():void {
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function removeEventListeners():void {
        removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(e:MouseEvent):void {
        this.setIsSelected(true);
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
