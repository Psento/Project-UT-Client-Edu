package svera.lib.resizing.view {
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.geom.Rectangle;

import svera.lib.framework.Mediator;
import svera.lib.resizing.signals.Resize;

public class ResizableMediator extends Mediator {

    [Inject]
    public var resize:Resize;

    // Type-safe view accessor
    private function get resizableView():Resizable {
        return view as Resizable;
    }

    override protected function onInitialize():void {
        var stage:Stage = (view as DisplayObject).stage;
        var rectangle:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        resize.add(onResize);
        resizableView.resize(rectangle);
    }

    override protected function onDestroy():void {
        resize.remove(onResize);
    }

    private function onResize(rectangle:Rectangle):void {
        resizableView.resize(rectangle);
    }
}
}