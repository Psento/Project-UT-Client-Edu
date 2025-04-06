package svera.untiered.messaging.impl.incoming {
import flash.utils.ByteArray;

public class GlobalNotification extends IncomingMessage
{
    //   public var type:int;

    public var text:String;

    public function GlobalNotification(param1:uint, param2:Function)
    {
        super(param1,param2);
    }

    override public function parseFromInput(param1:ByteArray) : void
    {
        this.text = param1.readUTF();
    }

    override public function toString() : String
    {
        return formatToString("GLOBAL_NOTIFICATION", "text");
    }
}
}
