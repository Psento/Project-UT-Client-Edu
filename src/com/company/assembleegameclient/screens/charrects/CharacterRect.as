package com.company.assembleegameclient.screens.charrects {
import flash.display.Bitmap;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class CharacterRect extends Sprite {
    public static const WIDTH:int = 96;
    public static const HEIGHT:int = 123;

    private var color_:uint;
    private var overColor_:uint;
    private var box_:Shape;
    public var selectContainer:Sprite;
    [Embed(source="CharacterRectBg.png")]
    public static var charBg:Class;
    private var bg:Bitmap = new Bitmap(new charBg().bitmapData);

    public function CharacterRect(color:uint, overColor:uint) {
        super();
        this.color_ = color;
        this.overColor_ = overColor;
        this.box_ = new Shape();
        //this.drawBox(false);
        //addChild(this.box_);
        addChild(bg);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    protected function onMouseOver(event:MouseEvent):void {
        this.drawBox(true);
    }

    protected function onRollOut(event:MouseEvent):void {
        this.drawBox(false);
    }

    private function drawBox(over:Boolean):void {
        var g:Graphics = this.box_.graphics;
        g.clear();
        g.beginFill(over ? this.overColor_ : this.color_, over ? 1 : 0);
        g.drawRect(0, 0, WIDTH, HEIGHT);
        g.endFill();
    }

    public function makeContainer():void {
        this.selectContainer = new Sprite();
        this.selectContainer.mouseChildren = false;
        this.selectContainer.buttonMode = true;
        this.selectContainer.graphics.beginFill(16711935, 0);
        this.selectContainer.graphics.drawRect(0, 0, WIDTH, HEIGHT);
        addChild(this.selectContainer);
    }
}
}
