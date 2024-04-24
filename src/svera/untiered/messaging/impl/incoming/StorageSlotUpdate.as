package svera.untiered.messaging.impl.incoming {
import flash.utils.IDataInput;

public class StorageSlotUpdate extends IncomingMessage {

    public var type_:int;
    public var slot_:int;
    public var inventory_:int;
    public var itemData_:int;

    public function StorageSlotUpdate(id:uint, callback:Function) {
        super(id,callback);
    }

    override public function parseFromInput(data:IDataInput) : void {
        this.type_ = data.readByte();
        this.slot_ = data.readShort();
        this.inventory_ = data.readInt();
        this.itemData_ = data.readInt();
    }
}
}
