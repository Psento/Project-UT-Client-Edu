package svera.untiered.messaging.impl.incoming {
import flash.utils.ByteArray;
import flash.utils.IDataInput;

import link.ItemData;

public class StorageUpdate extends IncomingMessage {

    public var type_:int;
    public var size_:int;
    public var items_:Vector.<ItemData>;

    public function StorageUpdate(id:uint, callback:Function) {
        this.items_ = new Vector.<ItemData>();
        super(id, callback);
    }

    override public function parseFromInput(data:IDataInput):void {
        this.items_.length = 0;

        this.type_ = data.readByte();
        this.size_ = data.readShort();
        for (var i:int = 0; i < this.size_; i++) {
            var update:ItemData = new ItemData();
            var len:Number = data.readShort();
            var statByteArray:ByteArray = new ByteArray();
            for(var j:Number = 0; i < len; i++) {
                statByteArray.writeByte(data.readUnsignedByte());
            }
            statByteArray.endian = "littleEndian";
            statByteArray.position = 0;
            update = ItemData.loadFromData(statByteArray);
            this.items_.push(update);
        }
    }

    override public function toString():String {
        return "";
    }
}
}
