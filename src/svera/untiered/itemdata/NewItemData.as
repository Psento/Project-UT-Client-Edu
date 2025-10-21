package svera.untiered.itemdata {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.Base64Decoder;

import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class NewItemData extends Item {

    private const keys:Dictionary = new Dictionary();// Closest thing to a hashset

    private var killTracker:int = 0;
    public final function get KillTracker():int { return killTracker; }
    public final function get HasKillTracker():Boolean { return DataKeys.KillTracker in keys; }

    private var soulbound:Boolean;
    public final override function get Soulbound():Boolean { return (DataKeys.Soulbound in keys) ? soulbound : super.Soulbound; }

    public function NewItemData(item:Item = null) {
        super(item);
        if (item == null) throw new Error("Item cannot be null");
    }

    public static function TempCreate(data:int): NewItemData {
        if (data == -1) return null;
        var item:NewItemData = new NewItemData(ObjectLibrary.baseItems[data]);
        return item;
    }

    public static function FromByteArray(data:ByteArray): NewItemData {
        var oType:int = data.readInt();
        if (oType < 1) return null;

        var item:NewItemData = new NewItemData(ObjectLibrary.baseItems[oType]);

        var keyCount:uint = data.readUnsignedShort();

        for (var i:uint = 0; i < keyCount; i++) {
            var key:int = data.readUnsignedShort();
            item.keys[key] = null;
            switch (key) {
                case DataKeys.KillTracker:
                    item.killTracker = data.readInt();
                    break;
                case DataKeys.Soulbound:
                    item.soulbound = data.readBoolean();
                    break;
            }
        }

        //var low:uint = data.readUnsignedInt();
        //var high:uint = data.readUnsignedInt();
        //var ms:Number = high * 0x100000000 + low;
        //var time:Date = new Date(ms);

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
