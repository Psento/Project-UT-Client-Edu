package svera.untiered.itemdata {
import com.company.util.Base64Decoder;
import com.company.util.Guid;

import flash.utils.ByteArray;
import flash.utils.IDataInput;


public class NewItemData {

    public var Uuid:String = "";
    public var Time:Date = new Date(0);
    public var Transmog:uint = 0;
    public var KillTracker:int = 0;



    public function NewItemData() { }

    public static function CreateFromArray(data:IDataInput) : NewItemData {
        var item:NewItemData = new NewItemData();

        var _:uint = data.readUnsignedShort();
        data.endian = "littleEndian";
        NewTickUpdate(item, data);
        data.endian = "bigEndian";
        return item;
    }

    public static function NewTickUpdate(item:NewItemData, data:IDataInput): void {
        if (data.bytesAvailable == 2) return;
        var uuid:String = Guid.guidDataToString(data);
        if (item == null){
            item = new NewItemData();
            item.Uuid = uuid;
        } else if (item.Uuid != uuid) {
            return;
        }

        var low:uint = data.readUnsignedInt();
        var high:uint = data.readUnsignedInt();
        var ticks:Number = high * 0x100000000 + low;
        item.Time = new Date(ticks);

        var count:uint = data.readUnsignedShort();

        for (var i:int = 0; i < count; i++) {
            var key:uint = data.readUnsignedShort();

            switch (key) {
                case ItemDataKey.Transmog:
                    item.Transmog = data.readUnsignedShort();
                    break;
                case ItemDataKey.KillTracker:
                    item.KillTracker = data.readInt();
                    break;
            }
        }
    }

    public static function fromPlayerXML(obj:Object) : Vector.<NewItemData> {
        var equipment:Vector.<NewItemData> = new Vector.<NewItemData>();
        var data:Array = obj.toString().split(", ");
        var bytes:ByteArray;
        var decoder:Base64Decoder = new Base64Decoder();
        equipment.length = data.length;
        var i:Number = 0;
        while(i < equipment.length) {
            decoder.decode(data[i]);
            bytes = decoder.toByteArray();
            bytes.position = 0;
            bytes.endian = "littleEndian";
            NewItemData.NewTickUpdate(equipment[i], bytes);
            i++;
        }
        return equipment;
    }
}
}
