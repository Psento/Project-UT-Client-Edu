package svera.untiered.messaging.impl.incoming {
import flash.utils.IDataInput;

import svera.untiered.itemdata.NewItemData;

import svera.untiered.messaging.impl.data.StorageSlotUpdateData;

public class StorageUpdate extends IncomingMessage {

    public var type_:int;
    public var size_:int;
    public var items_:Vector.<StorageSlotUpdateData>;

    public function StorageUpdate(id:uint, callback:Function) {
        this.items_ = new Vector.<StorageSlotUpdateData>();
        super(id, callback);
    }

    override public function parseFromInput(data:IDataInput):void {
        this.items_.length = 0;

        this.type_ = data.readByte();
        this.size_ = data.readShort();
        for (var i:int = 0; i < this.size_; i++) {
            var update:StorageSlotUpdateData = new StorageSlotUpdateData();
            update.itemType_ = data.readInt();
            update.itemData_ = NewItemData.CreateFromArray(data);
            this.items_.push(update);
        }
    }

    override public function toString():String {
        return "";
    }
}
}
