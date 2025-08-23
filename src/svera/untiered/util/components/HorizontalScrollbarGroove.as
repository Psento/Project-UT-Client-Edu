package svera.untiered.util.components {
import svera.untiered.util.components.*;

import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import svera.untiered.util.graphics.BevelRect;
import svera.untiered.util.graphics.GraphicsHelper;

public final class HorizontalScrollbarGroove extends Sprite {

    public static const HEIGHT:int = HorizontalScrollbar.HEIGHT;

    public static const BEVEL:int = HorizontalScrollbar.BEVEL + HorizontalScrollbar.PADDING * 0.5;


    public const clicked:Signal = new Signal(int);

    public const rect:BevelRect = new BevelRect(0, HEIGHT, BEVEL);

    private const helper:GraphicsHelper = new GraphicsHelper();

    function HorizontalScrollbarGroove() {
        super();
    }

    public function redraw():void {
        graphics.clear();
        graphics.beginFill(5526612);
        this.helper.drawBevelRect(0, 0, this.rect, graphics);
        graphics.endFill();
    }

    public function addMouseListeners():void {
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    public function removeMouseListeners():void {
        removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(event:MouseEvent):void {
        this.clicked.dispatch(int(mouseY));
    }
}
}
