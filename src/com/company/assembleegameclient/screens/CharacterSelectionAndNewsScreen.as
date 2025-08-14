package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.ui.SimpleText;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.game.view.CurrencyDisplay;
import svera.untiered.ui.view.components.ScreenBase;

public class CharacterSelectionAndNewsScreen extends Sprite {
    private const SCROLLBAR_REQUIREMENT_HEIGHT:Number = 400;

    private const DROP_SHADOW:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 8, 8);

    private var model:PlayerModel;

    private var isInitialized:Boolean;

    private var nameText:SimpleText;

    private var currencyDisplay:CurrencyDisplay;

    private var charactersText:SimpleText;

    private var newsText:SimpleText;

    private var newsList:NewsList;

    private var characterList:CharacterList;

    private var characterListHeight:Number;

    private var playButton:TitleMenuOption;

    private var backButton:TitleMenuOption;

    private var classesButton:TitleMenuOption;

    private var lines:Shape;

    private var scrollBar:Scrollbar;

    public var close:Signal;

    public var showClasses:Signal;

    public var newCharacter:Signal;

    public var playGame:Signal;

    [Embed(source="brickLeft.png")]
    public static var brickLeftSource:Class;
    public static var brickLeft:BitmapData = new brickLeftSource().bitmapData;
    [Embed(source="brickRight.png")]
    public static var brickRightSource:Class;
    public static var brickRight:BitmapData = new brickRightSource().bitmapData;
    public static var brickLeftContainer:Sprite = new Sprite();
    public static var brickRightContainer:Sprite = new Sprite();
    [Embed(source="nameTextSign.png")]
    private var nameTextSignSource:Class;
    private var nameTextSign:Bitmap = new Bitmap(new nameTextSignSource().bitmapData);

    public function CharacterSelectionAndNewsScreen() {
        this.playButton = new TitleMenuOption("play", 36, true);
        this.backButton = new TitleMenuOption("back", 22, false);
        this.classesButton = new TitleMenuOption("classes", 22, false);
        this.newCharacter = new Signal();
        this.playGame = new Signal();
        super();
        addChild(new ScreenBase(2));
        var h:Number = 0;
        var l:Bitmap;
        var r:Bitmap;
        while (h < GameClient.STAGE.fullScreenHeight) {
            l = new Bitmap(brickLeft);
            r = new Bitmap(brickRight);
            l.y = h;
            r.y = h;
            addChild(l);
            brickLeftContainer.addChild(l);
            brickRightContainer.addChild(r);
            h += l.height;
        }
        addChild(nameTextSign);
        addChild(brickLeftContainer);
        addChild(brickRightContainer);
        addChild(new AccountScreen());
        this.close = new NativeMappedSignal(this.backButton, MouseEvent.CLICK);
        this.showClasses = new NativeMappedSignal(this.classesButton, MouseEvent.CLICK);
    }

    public function initialize(model:PlayerModel):void {
        if (this.isInitialized) {
            return;
        }
        this.isInitialized = true;
        this.model = model;
        this.createDisplayAssets(model);
        stage.addEventListener(Event.RESIZE, positionButtons);
    }

    private function createDisplayAssets(model:PlayerModel):void {
        this.createNameText();
        this.createCurrencyDisplay();
        this.createCharactersText();
        this.createCharacterList();

        this.createButtons();
        this.positionButtons();

        if (this.characterListHeight > this.SCROLLBAR_REQUIREMENT_HEIGHT) {
            this.createScrollbar();
        }
    }

    private function createButtons():void {
        addChild(this.playButton);
        addChild(this.classesButton);
        addChild(this.backButton);
        this.playButton.addEventListener(MouseEvent.CLICK, this.onPlayClick);
    }

    private function positionButtons(e:Event = null):void {
        this.playButton.x = (GameClient.StageWidth - this.playButton.width) * 0.5;
        this.playButton.y = GameClient.StageHeight - (600 - 520);
        this.backButton.x = (GameClient.StageWidth - this.backButton.width) * 0.5 - 94;
        this.backButton.y = GameClient.StageHeight - (600 - 532);
        this.classesButton.x = (GameClient.StageWidth - this.classesButton.width) * 0.5 + 96;
        this.classesButton.y = backButton.y;
        nameTextSign.x = (GameClient.StageWidth - nameTextSign.width) * 0.5;
        brickRightContainer.x = GameClient.StageWidth - brickRightContainer.width;
        this.nameText.x = (GameClient.StageWidth - this.nameText.width) * 0.5;
    }

    private function createScrollbar():void {
        this.scrollBar = new Scrollbar(16, 399);
        this.scrollBar.x = 375;
        this.scrollBar.y = 113;
        this.scrollBar.setIndicatorSize(399, this.characterList.height);
        this.scrollBar.addEventListener(Event.CHANGE, this.onScrollBarChange);
        addChild(this.scrollBar);
    }

    private function createCharacterList():void {
        this.characterList = new CharacterList(this.model);
        this.characterList.x = 115;
        this.characterList.y = 153;
        this.characterListHeight = this.characterList.height;
        addChild(this.characterList);
    }

    private function createCharactersText():void {
        this.charactersText = new SimpleText(18, 11776947, false, 0, 0);
        this.charactersText.setBold(true);
        this.charactersText.text = "Characters";
        this.charactersText.updateMetrics();
        this.charactersText.filters = [this.DROP_SHADOW];
        this.charactersText.setAlignment(TextFormatAlign.LEFT);
        this.charactersText.x = (GameClient.StageWidth - charactersText.width) / 2;
        this.charactersText.y = nameText.y + nameText.height;
        addChild(this.charactersText);
    }

    private function createCurrencyDisplay():void {
        this.currencyDisplay = new CurrencyDisplay();
        this.currencyDisplay.draw(this.model.getTsavorite(), this.model.getMedallions(), this.model.getHonor(), true);
        this.currencyDisplay.x = GameClient.StageWidth;
        this.currencyDisplay.y = 20;
        addChild(this.currencyDisplay);
    }

    private function createNameText():void {
        this.nameText = new SimpleText(22, 11776947, false, 0, 0);
        this.nameText.setBold(true);
        this.nameText.text = this.model.getName() || "Undefined";
        this.nameText.updateMetrics();
        this.nameText.filters = [this.DROP_SHADOW];
        this.nameText.y = 24 + this.nameText.height;
        addChild(this.nameText);
    }

    private function onScrollBarChange(event:Event):void {
        this.characterList.setPos(-this.scrollBar.pos() * (this.characterListHeight - 400));
    }

    private function removeIfAble(object:DisplayObject):void {
        if (object && contains(object)) {
            removeChild(object);
        }
    }

    private function onPlayClick(event:Event):void {
        if (this.model.getCharacterCount() == 0) {
            this.newCharacter.dispatch();
        } else {
            this.playGame.dispatch();
        }
    }

    public function setName(name:String):void {
        this.nameText.text = name;
        this.nameText.updateMetrics();
        this.nameText.x = (GameClient.StageWidth - this.nameText.width) * 0.5;
    }
}
}
