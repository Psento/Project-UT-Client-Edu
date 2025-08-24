package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.screens.charrects.CharacterRect;
import com.company.assembleegameclient.ui.tooltip.ClassToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.HonorUtil;
import com.company.ui.SimpleText;
import com.company.untiered.graphics.StarGraphic;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;
import flash.ui.Keyboard;
import flash.utils.getTimer;

import org.osflash.signals.natives.NativeSignal;

import svera.untiered.core.model.PlayerModel;

public class CharacterBox extends Sprite {
    public static const DELETE_CHAR:String = "DELETE_CHAR";
    public static const ENTER_NAME:String = "ENTER_NAME";
    private static const fullCT:ColorTransform = new ColorTransform(0.8, 0.8, 0.8);
    private static const emptyCT:ColorTransform = new ColorTransform(0.2, 0.2, 0.2);
    private static const doneCT:ColorTransform = new ColorTransform(0.87, 0.62, 0);

    public var playerXML_:XML = null;
    public var charStats_:CharacterStats;
    public var model:PlayerModel;
    private var graphicContainer_:Sprite;
    private var bitmap_:Bitmap;
    private var classNameText_:SimpleText;
    private var cost:int = 0;
    private var lock_:Bitmap;
    public var characterSelectClicked_:NativeSignal;
    public const POSE_TIME:int = 600;
    public var poseStart_:int = -2147483648;
    public var poseDir_:int;
    public var poseAction_:int;

    private var bg:Bitmap = new Bitmap(new CharacterRect.charBg().bitmapData);
    private var graphic_:Sprite = new Sprite();

    public function CharacterBox(playerXML:XML, charStats:CharacterStats, model:PlayerModel) {
        var stars:Sprite = null;
        super();
        this.model = model;
        this.playerXML_ = playerXML;
        this.charStats_ = charStats;
        this.graphicContainer_ = new Sprite();
        graphic_.graphics.beginBitmapFill(bg.bitmapData, null, false);
        graphic_.graphics.drawRect(0,0, bg.width, bg.height);
        graphic_.graphics.endFill();
        addChild(this.graphicContainer_);
        this.graphicContainer_.addChild(this.graphic_);
        this.characterSelectClicked_ = new NativeSignal(this.graphicContainer_, MouseEvent.CLICK, MouseEvent);
        this.bitmap_ = new Bitmap(null);
        this.setImage(AnimatedChar.DOWN, AnimatedChar.STAND, 0);
        this.graphic_.addChild(this.bitmap_);
        this.classNameText_ = new SimpleText(14, 16777215, false, 0, 0);
        this.classNameText_.setBold(true);
        this.classNameText_.htmlText = "<p align=\"center\">" + this.playerXML_.@id + "</p>";
        this.classNameText_.autoSize = TextFieldAutoSize.CENTER;
        this.classNameText_.updateMetrics();
        this.classNameText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        this.graphic_.addChild(this.classNameText_);
        stars = this.getStars(HonorUtil.numStars(model.getBestHonor(this.objectType())), HonorUtil.STARS.length);
        stars.y = 10;
        stars.x = this.graphic_.width / 2 - stars.width / 2;
        stars.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        this.graphicContainer_.addChild(stars);
        this.classNameText_.y = graphic_.height - this.classNameText_.actualHeight_;
    }

    public function objectType():int {
        return int(this.playerXML_.@type);
    }

    public function getTooltip():ToolTip {
        return new ClassToolTip(this.playerXML_, this.model, this.charStats_);
    }

    public function setOver(over:Boolean):void {
        if (over) {
            transform.colorTransform = new ColorTransform(1.2, 1.2, 1.2);
        } else {
            transform.colorTransform = new ColorTransform(1, 1, 1);
        }
    }

    private function onKeyDown(e:KeyboardEvent):void {
        if (e.charCode == Keyboard.ENTER) {
            dispatchEvent(new Event(ENTER_NAME));
            e.stopPropagation();
        }
    }

    private function onDeleteClick(event:MouseEvent):void {
        dispatchEvent(new Event(DELETE_CHAR));
        event.stopPropagation();
    }

    private function onEnterFrame(event:Event):void {
        var p:Number = NaN;
        var time:int = getTimer();
        if (time < this.poseStart_ + this.POSE_TIME) {
            p = (time - this.poseStart_) / this.POSE_TIME;
            this.setImage(this.poseDir_, this.poseAction_, p);
        } else {
            this.setImage(AnimatedChar.DOWN, AnimatedChar.STAND, 0);
            if (Math.random() < 0.005) {
                this.poseStart_ = time;
                this.poseDir_ = Math.random() > 0.5 ? int(AnimatedChar.LEFT) : int(AnimatedChar.RIGHT);
                this.poseAction_ = AnimatedChar.ATTACK;
            }
        }
    }

    private function setImage(dir:int, action:int, p:Number):void {
        this.bitmap_.bitmapData = SavedCharacter.getImage(null, this.playerXML_, dir, action, p, false, false);
        this.bitmap_.x = this.graphic_.width / 2 - this.bitmap_.bitmapData.width / 2;
    }

    private function getStars(full:int, total:int):Sprite {
        var star:Sprite = null;
        var stars:Sprite = new Sprite();
        var i:int = 0;
        for (var xOffset:int = 0; i < full;) {
            star = new StarGraphic();
            star.x = xOffset;
            star.transform.colorTransform = fullCT;
            stars.addChild(star);
            xOffset = xOffset + star.width;
            i++;
        }
        while (i < total) {
            star = new StarGraphic();
            star.x = xOffset;
            star.transform.colorTransform = emptyCT;
            stars.addChild(star);
            xOffset = xOffset + star.width;
            i++;
        }
        return stars;
    }
}
}
