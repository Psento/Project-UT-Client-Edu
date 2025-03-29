package svera.untiered.messaging.impl.outgoing {
import flash.utils.ByteArray;

public class LaunchRaid extends OutgoingMessage {

    public function LaunchRaid(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    public var raidId_:int;


    override public function writeToOutput(_arg1:ByteArray):void {
        _arg1.writeInt(this.raidId_);

    }

    override public function toString():String {
        return formatToString("LAUNCHRAID", "raidId_");
    }
}
}
