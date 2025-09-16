package svera.untiered.classes.view {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.utils.getTimer;

public class Orbiter extends Sprite
{
    // Pixels.
    public static const radius:Number = 100;

    // Degrees per second.
    public var speed:Number = 360;

    public var items:Vector.<CharacterSkinListItem>;
    public var lastTime:int;

    public function start()
    {
        stop();

        rotation = 0;
        items = new Vector.<CharacterSkinListItem>();
        lastTime = getTimer();

        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    public function stop():void
    {
        items = null;

        removeEventListener(Event.ENTER_FRAME, onFrame);
    }

    public function onFrame(e:Event = null):void
    {
        var aTime:int = getTimer();

        rotation += speed * (aTime - lastTime) / 1000;
        lastTime = aTime;

        for (var i:int = 0; i < items.length; i++)
        {
            // Get the object.
            var anItem:DisplayObject = items[i];

            // Get the object's designated position.
            var aPos:Point = getPosition(i);

            // Follow the position smoothly.
            anItem.x += (aPos.x - anItem.x) / 10;
            anItem.y += (aPos.y - anItem.y) / 10;
        }
    }

    private function getPosition(index:int):Point
    {
        // Calculate the angle with regard to the present items amount.
        var anAngle:Number = (Math.PI * 2) / items.length +  rotation;
        var result:Point = new Point;

        // Figure the position with regard to (x,y) offset.
        result.x = x + radius * Math.cos(anAngle);
        result.y = y + radius * Math.sin(anAngle);

        return result;
    }
}
}
