package svera.lib.framework {
import flash.display.DisplayObject;

/**
 * Mediator interface - simplified from Robotlegs
 */
public interface IMediator {
    function setView(view:DisplayObject):void;
    function initialize():void;
    function destroy():void;
}
}