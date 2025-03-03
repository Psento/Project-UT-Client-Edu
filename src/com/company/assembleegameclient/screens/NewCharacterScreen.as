package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.game.view.CurrencyDisplay;
import svera.untiered.ui.view.components.ScreenBase;

public class NewCharacterScreen extends Sprite {
    private var backButton_:TitleMenuOption;
    private var currencyDisplay_:CurrencyDisplay;
    private var boxes_:Object;
    public var tooltip:Signal;
    public var close:Signal;
    public var selected:Signal;

    private var isInitialized:Boolean = false;

    public function NewCharacterScreen() {
        this.boxes_ = {};
        super();
        this.tooltip = new Signal(Sprite);
        this.selected = new Signal(int);
        this.close = new Signal();
        addChild(new ScreenBase());
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
        this.isInitialized = true;
        this.backButton_ = new TitleMenuOption("back", 36, false);
        this.backButton_.addEventListener(MouseEvent.CLICK, this.onBackClick);
        addChild(this.backButton_);
        this.currencyDisplay_ = new CurrencyDisplay();
        this.currencyDisplay_.draw(model.getTsavorite(), model.getMedallions(), model.getHonor(), model.getFame());
        addChild(this.currencyDisplay_);

        var stripLen:int = GameClient.StageWidth / 140;

        for (var i:int = 0; i < ObjectLibrary.playerChars_.length; i++) {
            playerXML = ObjectLibrary.playerChars_[i];
            objectType = int(playerXML.@type);
            characterType = playerXML.@id;

            trace(objectType.toString(), characterType.toString())
            charBox = new CharacterBox(playerXML, model.getCharStats()[objectType], model);
            charBox.x = 50 + 140 * int(i % stripLen) + 70 - charBox.width / 2;
            charBox.y = 88 + 140 * int(i / stripLen);
            this.boxes_[objectType] = charBox;
            charBox.addEventListener(MouseEvent.ROLL_OVER, this.onCharBoxOver);
            charBox.addEventListener(MouseEvent.ROLL_OUT, this.onCharBoxOut);
            charBox.characterSelectClicked_.add(this.onCharBoxClick);
            addChild(charBox);
        }
        this.backButton_.x = GameClient.HalfStageWidth - this.backButton_.width / 2;
        this.backButton_.y = GameClient.StageHeight - (600 - 524);
        this.currencyDisplay_.x = stage.stageWidth;
        this.currencyDisplay_.y = 20;
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

    public function updateCurrencies(tsavorite:int, medallions:int, honor:int, fame:int):void {
        this.currencyDisplay_.draw(tsavorite, medallions, honor, fame);
    }
}
}
