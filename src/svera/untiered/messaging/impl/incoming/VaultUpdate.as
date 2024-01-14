package svera.untiered.messaging.impl.incoming {
import flash.utils.IDataInput;

import svera.untiered.messaging.impl.data.VaultUpdateSlot;

public class VaultUpdate extends IncomingMessage {

    public var vaultSize_:int;
    public var items_:Vector.<VaultUpdateSlot>;

    public function VaultUpdate(id:uint, callback:Function)
    {
        this.items_ = new Vector.<VaultUpdateSlot>();
        super(id,callback);
    }

    override public function parseFromInput(data:IDataInput) : void
    {
        this.items_.length = 0;

        this.vaultSize_ = data.readShort();
        for (var i:int = 0; i < this.vaultSize_; i++) {
            var update:VaultUpdateSlot = new VaultUpdateSlot();
            update.itemType_ = data.readInt();
            update.itemData_ = data.readInt();
            this.items_.push(update);
        }
    }

    override public function toString() : String {
        return "";
    }
}
}
