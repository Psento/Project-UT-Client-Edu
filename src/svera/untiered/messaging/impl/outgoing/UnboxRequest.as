package svera.untiered.messaging.impl.outgoing {
import flash.utils.ByteArray;

public class UnboxRequest extends OutgoingMessage {

    public var lootboxType_:int;

    public function UnboxRequest(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:ByteArray):void {
        _arg1.writeInt(this.lootboxType_);
    }

    override public function toString():String {
        return (formatToString("UNBOXREQUEST", "lootboxType_"));
    }


}
}
