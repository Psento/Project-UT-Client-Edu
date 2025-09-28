package svera.untiered.classes.view {
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.util.Currency;
import com.company.ui.SimpleText;
import com.gskinner.motion.GTween;
import com.gskinner.motion.easing.Sine;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.getTimer;

import svera.untiered.classes.control.BuyCharacterSkinSignal;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.util.components.LegacyBuyButton;
import svera.untiered.util.components.api.BuyButton;

public class CharacterSkinListView extends Sprite {
    [Inject]
    public var buyCharacterSkin:BuyCharacterSkinSignal;

    public static const PADDING:int = 5;
    public static const WIDTH:int = 442;
    public static const HEIGHT:int = 400;

    public var skinsContainer:Orbiter;
    public var buyButton:BuyButton;
    public var currentSkin:CharacterSkinListItem;
    private var purchasingText:SimpleText = new SimpleText(14, 16777215, false, 0, 0);
    public var playButton:TitleMenuOption;
    private var selectedSkin:int = 0;
    public var rightSkin:TitleMenuOption = new TitleMenuOption(">", 24, true, true);
    public var leftSkin:TitleMenuOption = new TitleMenuOption("<", 24, true, true);
    private const radius:Number = 100;
    public var lastTime:int = getTimer();
    // Degrees per second.
    public var speed:Number = 60;
    private var angle:Number = 0;
    private var tween:GTween;


    private var _accAngle:Number = -(Math.PI * 3) / 2;
    public var rotationDirection:Number = 0;

    public function get testAngle():Number {
        return rotationDirection;
    }

    public function set testAngle(a:Number):void {
        rotationDirection = a;
    }

    public function get accAngle():Number {
        return _accAngle;
    }

    public function set accAngle(a:Number):void {
        _accAngle = a;
    }

    public function CharacterSkinListView(playButton_:TitleMenuOption) {
        super();
        playButton = playButton_;
        setBuyButton();
        makeList();

        rightSkin.clicked.add(right);
        leftSkin.clicked.add(left);

        addEventListener(Event.RESIZE, function (e:Event):void {
        });

    }

    private function left():void {
        if (++selectedSkin >= skinsContainer.items.length) {
            selectedSkin = 0;
        }
        currentSkin && currentSkin.selected.dispatch(false);

        currentSkin = skinsContainer.items[selectedSkin];
        trace(currentSkin.model.name);
        currentSkin.selected.dispatch(true); // TODO: Fix this cause insane shit with position
        setButtonVisibilities();

        tween = new GTween(this, 0.15, {testAngle: -1}, {ease: Sine.easeIn});
        tween.init();
        //tween.setValues({"testAngle": -1});
        tween.onChange = setPositions;
        tween.onComplete = resetAngle;

    }

    private function right():void {
        if (--selectedSkin < 0) {
            selectedSkin = skinsContainer.items.length - 1;
        }
        currentSkin && currentSkin.selected.dispatch(false);

        currentSkin = skinsContainer.items[selectedSkin];
        trace(currentSkin.model.name);
        currentSkin.selected.dispatch(true); // TODO: Fix this cause insane shit with position
        setButtonVisibilities();

        //var targetVal:Number = _accAngle +
        tween = new GTween(this, 0.15, {testAngle: 1}, {ease: Sine.easeIn});
        tween.init();
        tween.onChange = setPositions;
        tween.onComplete = resetAngle;
    }

    private function resetAngle(change:GTween = null):void {
        _accAngle += angle * testAngle;
        testAngle = 0;
        tween = null;
    }

    private function setPositions(change:GTween = null):void {
        var radius:Number = 100;
        var localAcc:Number = _accAngle + angle * testAngle;
        for each(var item:CharacterSkinListItem in skinsContainer.items) {

            var x:Number = Math.cos(localAcc) * radius;
            var y:Number = Math.sin(localAcc) * radius * 0.38; // 0.38 for ellipse look

            item.scaleX = item.scaleY = Math.max((y / 19 + 2) / 2, 1); //min scale 1, max scale 2
            item.x = -item.width / 2;
            item.y = -item.height / 2;
            item.angle = localAcc;
            var container:Sprite = item.parent as Sprite; // Used only to make thing centered
            container.x = x;
            container.y = y;
            localAcc += angle;
        }
    }

    private function makeList():Sprite {
        skinsContainer = new Orbiter();
        return skinsContainer;
    }

    public function get getListHeight():Number {
        return skinsContainer.height
    }

    public function setItems(items_:Vector.<CharacterSkinListItem>):void {
        skinsContainer.items = items_;
        var counter:Number = 0;
        angle = (Math.PI * 2) / items_.length;
        skinsContainer.speed = angle / 60; // angle / fps

        var radius:Number = 100;
        _accAngle = -(Math.PI * 3) / 2;
        for each(var item:CharacterSkinListItem in items_) {
            var container:Sprite = new Sprite(); // Used only to make thing centered

            var x:Number = Math.cos(_accAngle) * radius;
            var y:Number = Math.sin(_accAngle) * radius * 0.38; // 0.38 for ellipse look

            item.scaleX = item.scaleY = Math.max((y / 19 + 2) / 2, 1); //min scale 1, max scale 2
            item.x = -item.width / 2;
            item.y = -item.height / 2;
            item.initialAngle = _accAngle;
            item.angle = _accAngle;
            counter++;
            container.addChild(item);
            container.x = x;
            container.y = y;
            skinsContainer.addChild(container);
            _accAngle += angle;
        }
        addChild(skinsContainer);
        CharacterSkinView.positionStuff.dispatch();
    }

    private function setButtonVisibilities():void {
        var isOwned:Boolean = currentSkin.state == CharacterSkinState.OWNED;
        var isPurchasable:Boolean = currentSkin.state == CharacterSkinState.PURCHASABLE;
        var isPurchasing:Boolean = currentSkin.state == CharacterSkinState.PURCHASING;
        if (isOwned) {
            playButton && playButton.activate();
        } else {
            playButton && playButton.deactivate();
        }
        if (isPurchasable) {
            setCost(currentSkin.model);
        }
        buyButton && (buyButton.visible = isPurchasable && !isOwned);

        this.purchasingText.visible = isPurchasing;
    }

    public function setBuyButton():void {
        buyButton = new LegacyBuyButton("", 16, 0, Currency.TSAVORITE);
        buyButton.setWidth(40);
        this.buyButton.x = (width - this.buyButton.width) / 2;
        this.buyButton.y = 300;
        this.buyButton.visible = false;
        buyButton.addEventListener(MouseEvent.CLICK, onBuy)
            addChild(buyButton);
    }

    private function onBuy(e:Event):void {
        buyCharacterSkin.dispatch(currentSkin.model);
    }

    private function updatePurchasingText():void {
        this.purchasingText.text = "Purchasing...";
        this.purchasingText.updateMetrics();
        this.purchasingText.x = width - this.purchasingText.width - 15;
        this.purchasingText.y = height / 2 - this.purchasingText.height / 2;
    }

    private function setCost(skin:CharacterSkin):void {
        if (!skin)
            return;

        var cost:int = Boolean(skin) ? skin.cost : 0;
        buyButton.setPrice(cost, Currency.TSAVORITE);
    }
}
}
