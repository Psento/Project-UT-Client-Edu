package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.ui.SimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.Dictionary;

import org.osflash.signals.Signal;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.game.view.CurrencyDisplay;
import svera.untiered.ui.view.components.ScreenBase;

public class NewCharacterScreen extends Sprite {
    private var backButton_:TitleMenuOption;
    private var currencyDisplay_:CurrencyDisplay;
    public var tooltip:Signal;
    public var close:Signal;
    public var selected:Signal;
    private var isInitialized:Boolean = false;
    private var boxes_:Vector.<Dictionary>;
    private var tiny:SimpleText = new SimpleText(18, 0xFFFFFF, false);
    private var short:SimpleText = new SimpleText(18, 0xFFFFFF, false);
    private var medium:SimpleText = new SimpleText(18, 0xFFFFFF, false);
    private var long:SimpleText = new SimpleText(18, 0xFFFFFF, false);
    private var textList:Sprite = new Sprite();

    public function NewCharacterScreen() {
        this.boxes_ = new Vector.<Dictionary>(4, true);
        super();
        this.tooltip = new Signal(Sprite);
        this.selected = new Signal(int);
        this.close = new Signal();
        addChild(new ScreenBase(2));
        addChild(CharacterSelectionAndNewsScreen.brickLeftContainer);
        addChild(CharacterSelectionAndNewsScreen.brickRightContainer);
        addChild(new AccountScreen());
    }

    public function initialize(model:PlayerModel):void {
        var playerXML:XML = null;
        var objectType:int = 0;
        var characterType:String = null;
        var charBox:CharacterBox = null;
        if (this.isInitialized) {
            return;
        }
        addEventListener(Event.RESIZE, positionStuff);
        this.isInitialized = true;
        this.backButton_ = new TitleMenuOption("back", 36, false);
        this.backButton_.addEventListener(MouseEvent.CLICK, this.onBackClick);
        this.currencyDisplay_ = new CurrencyDisplay();
        this.currencyDisplay_.draw(model.getTsavorite(), model.getMedallions(), model.getHonor());
        addChild(this.currencyDisplay_);

        function strToRange(s:String):int {
            if (s == 'tiny')
                return 0;
            if (s == 'short')
                return 1;
            if (s == "medium")
                return 2;
            if (s == 'long')
                return 3;
        }

        tiny.text = "tiny";
        short.text = "short";
        medium.text = "medium";
        long.text = "long";
        tiny.updateMetrics();
        short.updateMetrics();
        medium.updateMetrics();
        long.updateMetrics();

        textList.addChild(tiny);
        textList.addChild(short);
        textList.addChild(medium);
        textList.addChild(long);
        addChild(textList);

        for (var i:int = 0; i < ObjectLibrary.playerChars_.length; i++) {
            playerXML = ObjectLibrary.playerChars_[i];
            objectType = int(playerXML.@type);
            characterType = playerXML.@id;
            if (playerXML.hasOwnProperty("SubClassOf")) {
                continue;
            }
            charBox = new CharacterBox(playerXML, model.getCharStats()[objectType], model);
            var range:int = strToRange(playerXML.Range);
            if (boxes_.length < range || boxes_[range] == null) {
                boxes_[range] = new Dictionary();
            }

            boxes_[range][objectType] = charBox;
            charBox.addEventListener(MouseEvent.ROLL_OVER, this.onCharBoxOver);
            charBox.addEventListener(MouseEvent.ROLL_OUT, this.onCharBoxOut);
            charBox.characterSelectClicked_.add(this.onCharBoxClick);
            addChild(charBox);
        }
        addChild(this.backButton_);

        positionStuff();
    }

    private function positionStuff(e:Event = null):void {
        this.backButton_.x = GameClient.HalfStageWidth - this.backButton_.width / 2;
        this.backButton_.y = GameClient.StageHeight - (600 - 524);
        this.currencyDisplay_.x = stage.stageWidth;
        this.currencyDisplay_.y = 20;

        var charBox:CharacterBox;
        var range:Dictionary;
        var stripLen:int = (GameClient.StageWidth - CharacterSelectionAndNewsScreen.brickRightContainer.width) / 140;

        var position:Vector.<int> = new Vector.<int>(4, true);
        var j:int = 0;
        for each(range in boxes_) {
            var i:int = 0;
            for each(charBox in range) {
                charBox.x = 115 + 140 * int(i % 2 + j) + 140 * j + 70 - charBox.width / 2;
                charBox.y = 153 + 140 * int(i / 2);
                i++;
            }
            if (charBox != null) {
                var a:SimpleText = textList.getChildAt(j) as SimpleText;
                a.x = charBox.x - 22 - a.width / 2;
            }
            j++;
        }
        textList.y = 153 - tiny.height * 1.5; // 18 is textSize
    }

    private function onBackClick(event:Event):void {
        this.close.dispatch();
    }

    private function onCharBoxOver(event:MouseEvent):void {
        var charBox:CharacterBox = event.currentTarget as CharacterBox;
        charBox.setOver(true);
        this.tooltip.dispatch(charBox.getTooltip());
    }

    private function onCharBoxOut(event:MouseEvent):void {
        var charBox:CharacterBox = event.currentTarget as CharacterBox;
        charBox.setOver(false);
        this.tooltip.dispatch(null);
    }

    private function onCharBoxClick(event:MouseEvent):void {
        this.tooltip.dispatch(null);
        var charBox:CharacterBox = event.currentTarget.parent as CharacterBox;
        var objectType:int = charBox.objectType();
        var displayId:String = ObjectLibrary.typeToDisplayId_[objectType];
        this.selected.dispatch(objectType);
    }

    public function updateCurrencies(tsavorite:int, medallions:int, honor:int):void {
        this.currencyDisplay_.draw(tsavorite, medallions, honor);
    }
}
}
