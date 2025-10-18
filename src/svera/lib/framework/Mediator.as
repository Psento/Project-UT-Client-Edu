package svera.lib.framework {
import flash.display.DisplayObject;

/**
 * Base Mediator class
 * Much lighter than Robotlegs mediator with direct property access
 */
public class Mediator implements IMediator {
    private var _view:DisplayObject;
    private var _initialized:Boolean = false;

    public function setView(view:DisplayObject):void {
        _view = view;
    }

    protected function get view():DisplayObject {
        return _view;
    }

    public function initialize():void {
        if (_initialized) return;
        _initialized = true;
        onInitialize();
    }

    public function destroy():void {
        if (!_initialized) return;
        onDestroy();
        _initialized = false;
        _view = null;
    }

    // Override these in subclasses
    protected function onInitialize():void {}
    protected function onDestroy():void {}
}
}