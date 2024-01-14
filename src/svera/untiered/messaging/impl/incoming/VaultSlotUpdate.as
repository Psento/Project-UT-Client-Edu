package svera.untiered.messaging.impl.incoming {
import flash.utils.IDataInput;

public class VaultSlotUpdate extends IncomingMessage {

    public var slotIndex_:int;
    public var inventory_:int;
    public var itemData_:int;

    public function VaultSlotUpdate(id:uint, callback:Function)
    {
        super(id,callback);
    }

    override public function parseFromInput(data:IDataInput) : void
    {
        this.slotIndex_ = data.readShort();
        this.inventory_ = data.readInt();
        this.itemData_ = data.readInt();
    }
}
}
