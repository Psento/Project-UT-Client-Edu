package svera.untiered.classes.view {
import com.company.assembleegameclient.screens.charrects.CharacterRect;
import com.company.assembleegameclient.util.Currency;
import com.company.ui.SimpleText;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.util.components.RadioButton;
import svera.untiered.util.components.api.BuyButton;

public class CharacterSkinListItem extends Sprite {
    public static const WIDTH:int = 96;
    public static const HEIGHT:int = 123;
    private static const HIGHLIGHTED_COLOR:uint = 8092539;
    private static const AVAILABLE_COLOR:uint = 5921370;
    private static const LOCKED_COLOR:uint = 2631720;

    private const grayscaleMatrix:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
    private const bg:Bitmap = makeBg();
    private const skinContainer:Sprite = makeSkinContainer();
    private const nameText:SimpleText = makeNameText();
    private const selectionButton:RadioButton = makeSelectionButton();
    private const lock:Bitmap = makeLock();
    private const purchasingText:SimpleText = makeLockText();
    private const buyButtonContainer:Sprite = makeBuyButtonContainer();
    public const buy:Signal = new NativeMappedSignal(buyButtonContainer, MouseEvent.CLICK);
    public const over:Signal = new Signal();
    public const out:Signal = new Signal();
    public const selected:Signal = selectionButton.changed;
    private var model:CharacterSkin;
    private var state:CharacterSkinState;
    private var isSelected:Boolean = false;
    private var skinIcon:Bitmap;
    private var buyButton:BuyButton;
    private var isOver:Boolean;


    public function CharacterSkinListItem() {
        this.state = CharacterSkinState.NULL;

        super();
    }
    private function makeBg():Bitmap {
        var bg2:Bitmap = new Bitmap(new CharacterRect.charBg().bitmapData)
        addChild(bg2);
        return bg2;
    }
    private function makeSkinContainer():Sprite {
        var sprite:Sprite = new Sprite();
        sprite.x = 20; //TODO: make not hardcoded maybe
        sprite.y = 40;
        addChild(sprite);
        return sprite;
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
        bitmap.y = HEIGHT * 0.5 - 4;
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

    private function makeBuyButtonContainer():Sprite {
        var container:Sprite = new Sprite();
        container.x = width / 2;
        container.y = 0;
        addChild(container);
        return container;
    }

    public function setBuyButton(buyButton:BuyButton):void {
        this.buyButton = buyButton;
        this.model && this.setCost();
        this.buyButtonContainer.addChild(buyButton);
        buyButton.x = -buyButton.width / 2;
        buyButton.y = -buyButton.height - 2;
        this.buyButtonContainer.visible = this.state == CharacterSkinState.PURCHASABLE;
    }

    public function setSkin(icon:Bitmap):void {
        this.skinIcon && this.skinContainer.removeChild(this.skinIcon);
        this.skinIcon = icon;
        this.skinIcon && this.skinContainer.addChild(this.skinIcon);
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
        this.state = Boolean(this.model) ? this.model.getState() : CharacterSkinState.NULL;
        this.updateName();
        this.updateState();
        this.buyButton && this.setCost();
        this.updatePurchasingText();
        this.setIsSelected(this.model && this.model.getIsSelected());
    }

    public function getState():CharacterSkinState {
        return this.state;
    }

    private function updateName():void {
        nameText.text = Boolean(this.model) ? this.model.name : "";
        nameText.updateMetrics();
        nameText.x = (WIDTH - nameText.width) / 2;
        nameText.y = HEIGHT - nameText.textHeight;
    }

    private function updateState():void {
        setButtonVisibilities();
        updateBackground();
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
        this.updateBackground();
    }

    private function updatePurchasingText():void {
        this.purchasingText.text = "Purchasing...";
        this.purchasingText.updateMetrics();
        this.purchasingText.x = WIDTH - this.purchasingText.width - 15;
        this.purchasingText.y = HEIGHT / 2 - this.purchasingText.height / 2;
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
        this.updateBackground();
        this.over.dispatch();
    }

    private function onOut(e:MouseEvent):void {
        this.isOver = false;
        this.updateBackground();
        this.out.dispatch();
    }

    private function updateBackground():void {
        var ct:ColorTransform = bg.transform.colorTransform;
        ct.color = this.getColor();
        bg.transform.colorTransform = ct;
    }

    private function getColor():uint {
        if (this.state.isDisabled()) {
            return LOCKED_COLOR;
        }
        if (this.isSelected || this.isOver) {
            return HIGHLIGHTED_COLOR;
        }
        return AVAILABLE_COLOR;
    }

    private function updateGrayFilter():void {
        filters = this.state == CharacterSkinState.PURCHASING ? [this.grayscaleMatrix] : [];
    }
}
}
