package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Bitmap;

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
    private var boxes_:Dictionary;
    public var tooltip:Signal;
    public var close:Signal;
    public var selected:Signal;
    private var isInitialized:Boolean = false;


    public function NewCharacterScreen() {
        this.boxes_ = new Dictionary();
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
        addChild(this.backButton_);
        this.currencyDisplay_ = new CurrencyDisplay();
        this.currencyDisplay_.draw(model.getTsavorite(), model.getMedallions(), model.getHonor());
        addChild(this.currencyDisplay_);

        for (var i:int = 0; i < ObjectLibrary.playerChars_.length; i++) {
            playerXML = ObjectLibrary.playerChars_[i];
            objectType = int(playerXML.@type);
            characterType = playerXML.@id;

            charBox = new CharacterBox(playerXML, model.getCharStats()[objectType], model);
            this.boxes_[objectType] = charBox;
            charBox.addEventListener(MouseEvent.ROLL_OVER, this.onCharBoxOver);
            charBox.addEventListener(MouseEvent.ROLL_OUT, this.onCharBoxOut);
            charBox.characterSelectClicked_.add(this.onCharBoxClick);
            addChild(charBox);
        }
        positionStuff();
    }
    private function positionStuff(e:Event = null):void {
        this.backButton_.x = GameClient.HalfStageWidth - this.backButton_.width / 2;
        this.backButton_.y = GameClient.StageHeight - (600 - 524);
        this.currencyDisplay_.x = stage.stageWidth;
        this.currencyDisplay_.y = 20;

        var charBox:CharacterBox;
        var stripLen:int = (GameClient.StageWidth - CharacterSelectionAndNewsScreen.brickRightContainer.width) / 140;

        var i:int = 0;
        for each(charBox in boxes_){
            charBox.x = 115 + 140 * int(i % stripLen) + 70 - charBox.width / 2;
            charBox.y = 153 + 140 * int(i / stripLen);
            i++;
        }
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
