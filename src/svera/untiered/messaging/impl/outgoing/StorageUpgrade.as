package svera.untiered.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class StorageUpgrade extends OutgoingMessage {

    public var objectId_:int;

    public function StorageUpgrade(id:uint, callback:Function) {
        super(id,callback);
    }

    override public function writeToOutput(data:IDataOutput) : void {
        data.writeInt(this.objectId_);
    }

    override public function toString() : String {
        return formatToString("VAULTREQUEST","objectId_");
    }
}
}
