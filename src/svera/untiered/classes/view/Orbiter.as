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
    public var speed:Number = 60;

    public var items:Vector.<CharacterSkinListItem>;
    public var lastTime:int;
    public var rot:Number;

    public function start()
    {
        stop();

        rot = 0;
        lastTime = getTimer();

        addEventListener(Event.ENTER_FRAME, onFrame);
    }

    public function stop():void
    {
        removeEventListener(Event.ENTER_FRAME, onFrame);
    }

    public function onFrame(e:Event = null):void
    {
        var aTime:int = getTimer();

        rot += speed * (aTime - lastTime) / 1000;
        lastTime = aTime;

        var angle:Number = (Math.PI * 2) / items.length ;
        var accumulatedAngle:Number = -(Math.PI * 3) / 2 + rot;
        for (var i:int = 0; i < items.length; i++) {
            var item:DisplayObject = items[i];

            var x:Number = 0 + Math.cos(accumulatedAngle) * radius;
            var y:Number = 0 + Math.sin(accumulatedAngle) * radius * 0.38; // 0.38 for ellipse look

            item.scaleX = item.scaleY = Math.max((y / 19 + 2) / 2, 1); //min scale 1, max scale 2
            item.x = -item.width / 2;
            item.y = -item.height / 2;
            var container:Sprite = item.parent as Sprite;
            container.x = x;
            container.y = y;
            accumulatedAngle += angle;
        }
    }

    private function getPosition(index:int):Point
    {
        // Calculate the angle with regard to the present items amount.
        var anAngle:Number = (Math.PI * 2) / items.length + rot;
        var result:Point = new Point;

        // Figure the position with regard to (x,y) offset.
        result.x = x + radius * Math.cos(anAngle);
        result.y = y + radius * Math.sin(anAngle);

        return result;
    }
}
}
