package svera.untiered.util.components {
import svera.untiered.util.components.*;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import svera.untiered.util.graphics.BevelRect;
import svera.untiered.util.graphics.GraphicsHelper;

public final class HorizontalScrollbarBar extends Sprite {
    public static const HEIGHT:int = HorizontalScrollbar.HEIGHT;
    public static const BEVEL:int = HorizontalScrollbar.BEVEL;
    public static const PADDING:int = HorizontalScrollbar.PADDING;

    public const dragging:Signal = new Signal(int);
    public const rect:BevelRect = new BevelRect(0, HEIGHT - PADDING * 2, BEVEL);
    private const helper:GraphicsHelper = new GraphicsHelper();
    private var downOffset:Number;
    private var isOver:Boolean;
    private var isDown:Boolean;

    function HorizontalScrollbarBar() {
        super();
    }

    public function redraw():void {
        var color:int = this.isOver || this.isDown ? int(16767876) : int(13421772);
        graphics.clear();
        graphics.beginFill(color);
        this.helper.drawBevelRect(0, PADDING, this.rect, graphics);
        graphics.endFill();
    }

    public function addMouseListeners():void {
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    public function removeMouseListeners():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.onMouseUp();
    }

    private function onMouseDown(event:MouseEvent = null):void {
        this.isDown = true;
        this.downOffset = parent.mouseX - x;
        stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        addEventListener(Event.ENTER_FRAME, this.iterate);
        this.redraw();
    }

    private function onMouseUp(event:MouseEvent = null):void {
        this.isDown = false;
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        removeEventListener(Event.ENTER_FRAME, this.iterate);
        this.redraw();
    }

    private function onMouseOver(event:MouseEvent):void {
        this.isOver = true;
        this.redraw();
    }

    private function onMouseOut(event:MouseEvent):void {
        this.isOver = false;
        this.redraw();
    }

    private function iterate(event:Event):void {
        this.dragging.dispatch(int(parent.mouseX - this.downOffset));
    }
}
}
