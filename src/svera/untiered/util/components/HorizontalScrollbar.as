package svera.untiered.util.components {
import svera.untiered.util.components.api.*;

import flash.display.Sprite;

import org.osflash.signals.Signal;

import svera.lib.ui.api.Scrollbar;

public class HorizontalScrollbar extends Sprite implements Scrollbar {
    public static const HEIGHT:int = 20;
    public static const BEVEL:int = 4;
    public static const PADDING:int = 0;

    private var _positionChanged:Signal;
    public const groove:HorizontalScrollbarGroove = new HorizontalScrollbarGroove();
    public const bar:HorizontalScrollbarBar = new HorizontalScrollbarBar();

    private var position:Number = 0;
    private var range:int;
    private var invRange:Number;
    private var isEnabled:Boolean = true;

    public function HorizontalScrollbar() {
        super();
        addChild(this.groove);
        addChild(this.bar);
        this.addMouseListeners();
    }

    public function get positionChanged():Signal {
        return this._positionChanged = this._positionChanged || new Signal(Number);
    }

    public function getIsEnabled():Boolean {
        return this.isEnabled;
    }

    public function setIsEnabled(isEnabled:Boolean):void {
        if (this.isEnabled != isEnabled) {
            this.isEnabled = isEnabled;
            if (isEnabled) {
                this.addMouseListeners();
            } else {
                this.removeMouseListeners();
            }
        }
    }

    private function addMouseListeners():void {
        this.groove.addMouseListeners();
        this.groove.clicked.add(this.onGrooveClicked);
        this.bar.addMouseListeners();
        this.bar.dragging.add(this.onBarDrag);
    }

    private function removeMouseListeners():void {
        this.groove.removeMouseListeners();
        this.groove.clicked.remove(this.onGrooveClicked);
        this.bar.removeMouseListeners();
        this.bar.dragging.remove(this.onBarDrag);
    }

    public function setSize(barSize:int, grooveSize:int):void {
        this.bar.rect.width = barSize;
        this.groove.rect.width = grooveSize;
        this.range = grooveSize - barSize - PADDING * 2;
        this.invRange = 1 / this.range;
        this.groove.redraw();
        this.bar.redraw();
        this.setPosition(this.getPosition());
    }

    public function getBarSize():int {
        return this.bar.rect.width;
    }

    public function getGrooveSize():int {
        return this.groove.rect.width;
    }

    public function getPosition():Number {
        return this.position;
    }

    public function setPosition(value:Number):void {
        if (value < 0) {
            value = 0;
        } else if (value > 1) {
            value = 1;
        }
        this.position = value;
        this.bar.x = PADDING + this.range * this.position;
        this._positionChanged && this._positionChanged.dispatch(this.position);
    }

    public function scrollPosition(value:Number):void {
        var position:Number = this.position + value;
        this.setPosition(position);
    }

    private function onBarDrag(value:int):void {
        this.setPosition((value - PADDING) * this.invRange);
    }

    private function onGrooveClicked(value:int):void {
        var barWidth:int = this.bar.rect.width;
        var numerator:int = value - barWidth * 0.5;
        var denominator:int = this.groove.rect.width - barWidth;
        this.setPosition(numerator / denominator);
    }
}
}
