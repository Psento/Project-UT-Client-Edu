package svera.untiered.messaging.impl.data {
import flash.utils.ByteArray;
import flash.utils.IDataInput;

import link.ItemData;

public class TradeItemData {

    public var itemType_:ItemData;
    public var slotType_:int;
    public var tradeable_:Boolean;
    public var included_:Boolean;


    public function parseFromInput(data:IDataInput):void {
        var len:Number = data.readShort();
        var statByteArray:ByteArray = new ByteArray();
        for(var i:Number = 0; i < len; i++) {
            statByteArray.writeByte(data.readUnsignedByte());
        }
        statByteArray.endian = "littleEndian";
        statByteArray.position = 0;
        this.itemType_ = ItemData.loadFromData(statByteArray);
        this.slotType_ = data.readInt();
        this.tradeable_ = data.readBoolean();
        this.included_ = data.readBoolean();
    }

    public function toString():String {
        return "ItemType: " + itemType_ + " SlotType: " + slotType_ + " Tradeable: " + tradeable_ + " Included: " + included_;
    }


}
}
