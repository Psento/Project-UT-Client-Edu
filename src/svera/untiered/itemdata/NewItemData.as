package svera.untiered.itemdata {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.Base64Decoder;
import com.company.util.Guid;

import flash.utils.ByteArray;
import flash.utils.IDataInput;

import svera.untiered.itemdata.Item;

public class NewItemData {

    private var item:Item;
    private var uuid:String;
    private var time:Date;

    public function get BaseItem(): Item { return item }
    public function get Uuid(): String { return uuid }
    public function get CreationTime(): Date { return time }

    public function NewItemData(item:Item = null, uuid:String = null, time:Date = null) {
        this.item = item;
        this.uuid = uuid;
        this.time = time;
    }

    public static function TempCreate(data:int): NewItemData {
        if (data == -1) return null;
        var item:NewItemData = new NewItemData(ObjectLibrary.baseItems[data]);
        return item;
    }

    public static function FromByteArray(data:IDataInput): NewItemData {
        var oType:int = data.readInt();
        if (oType < 1) return null;

        var uuid:String = Guid.guidDataToString(data);
        var low:uint = data.readUnsignedInt();
        var high:uint = data.readUnsignedInt();
        var ms:Number = high * 0x100000000 + low;
        var time:Date = new Date(ms);

        var item:NewItemData = new NewItemData(ObjectLibrary.baseItems[oType], uuid, time);
        trace(oType, item.BaseItem == null, uuid, time.toLocaleString());
        return item;
    }

    public static function fromPlayerXML(obj:Object) : Vector.<NewItemData> {
        var equipment:Vector.<NewItemData> = new Vector.<NewItemData>();
        var data:Array = obj.toString().split(", ");
        var bytes:ByteArray;
        var decoder:Base64Decoder = new Base64Decoder();
        equipment.length = data.length;
        var i:Number = 0;
        while (i < equipment.length) {
            decoder.decode(data[i])
            bytes = decoder.toByteArray()
            bytes.position = 0;
            bytes.endian = "littleEndian"
            equipment[i] = NewItemData.FromByteArray(bytes);
            i++;
        }

        return equipment;
    }
}
}
