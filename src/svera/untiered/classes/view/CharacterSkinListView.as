package svera.untiered.classes.view {
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.util.Currency;
import com.company.ui.SimpleText;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
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
    private var purchasingText:SimpleText;
    public var playButton:TitleMenuOption;
    private var selectedSkin:int = 0;
    public var leftSkin:TitleMenuOption = new TitleMenuOption(">", 24, true, true);
    public var rightSkin:TitleMenuOption = new TitleMenuOption("<", 24, true, true);
    private const radius:Number = 100;
    public var lastTime:int = getTimer();
    // Degrees per second.
    public var speed:Number = 60;


    public function CharacterSkinListView(playButton_:TitleMenuOption) {
        super();
        playButton = playButton_;
        makeList();

        function left():void
        {
            if(++selectedSkin >= skinsContainer.items.length){
                selectedSkin = 0;
            }
            currentSkin = skinsContainer.items[selectedSkin];
            currentSkin.selected.dispatch();
        }
        function right():void
        {
            if(--selectedSkin <= 0){
                selectedSkin = skinsContainer.items.length - 1;
            }
            currentSkin = skinsContainer.items[selectedSkin];
            currentSkin.selected.dispatch();
        }
        leftSkin.clicked.add(left);
        rightSkin.clicked.add(right);

        addEventListener(Event.RESIZE, function (e:Event):void {
        });

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
        var angle:Number = (Math.PI * 2) / items_.length;
        trace(items_.length);
        var radius:Number = 100;
        var accumulatedAngle:Number = angle;
        for each(var item:CharacterSkinListItem in items_) {
            item.model.changed.add(setBuyButton);


            var x:Number = 0 + Math.cos(accumulatedAngle) * radius;
            var y:Number = 0 + Math.sin(accumulatedAngle) * radius /** 0.38*/; // 0.38 for ellipse look
            item.x = x;
            item.y = y;
            counter++;
            addChild(item);

            accumulatedAngle += angle;
        }

        addChild(skinsContainer);
        //skinsContainer.start();
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
        buyButton && (buyButton.visible = isPurchasable);
        this.purchasingText.visible = isPurchasing;
    }

    public function setBuyButton(skin:CharacterSkin):void {
        var button:LegacyBuyButton = new LegacyBuyButton("", 16, skin.cost, Currency.TSAVORITE);
        button.setWidth(40);
        this.buyButton = button;

        this.buyButton.x = (width - this.buyButton.width) / 2;
        this.buyButton.y = 300;
        this.buyButton.visible = skin.getState() == CharacterSkinState.PURCHASABLE;
        addChild(buyButton);
    }
    private function onBuy(skin:CharacterSkinListItem):void {
        buyCharacterSkin.dispatch(skin);
    }
    private function setCost(skin:CharacterSkinListItem):void {
        if (!skin.model)
            return;

        if (!buyButton)
            setBuyButton(skin.model);

        var cost:int = Boolean(skin.model) ? skin.model.cost : 0;
        this.buyButton.setPrice(cost, Currency.TSAVORITE);
        this.buyButton.setWidth(40);
    }
}
}
