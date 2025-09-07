package svera.untiered.itemdata {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.Base64Decoder;

import flash.utils.ByteArray;
import flash.utils.IDataInput;

import link.Item;

public class NewItemData {

    public function NewItemData() {}

    public var BaseItem:Item = null;

    public static function CreateNew(data:IDataInput): NewItemData{
        var item:NewItemData = new NewItemData();
        item.BaseItem = ObjectLibrary.baseItems[data.readInt()];
        return item;
    }

    public static function TempCreate(data:int): NewItemData {
        if (data == -1) return null;
        var item:NewItemData = new NewItemData();
        item.BaseItem = ObjectLibrary.baseItems[data];
        trace("TEMP | NULL =", item.BaseItem == null, "TYPE: ", item.BaseItem.ObjectType);
        return item;
    }

    public static function FromByteArray(data:ByteArray): NewItemData {
        var item:NewItemData = new NewItemData();
        item.BaseItem = ObjectLibrary.baseItems[data.readInt()];
        return item;
    }

    public static function fromPlayerXML(obj:Object) : Vector.<NewItemData> {
        var equipment:Vector.<NewItemData> = new Vector.<NewItemData>();
        var data:Array = obj.toString().split(", ");
        //var bytes:ByteArray;
        //var decoder:Base64Decoder = new Base64Decoder();
        equipment.length = data.length;
        var i:Number = 0;
        /*while (i < equipment.length) {
            decoder.decode(data[i])
            bytes = decoder.toByteArray()
            bytes.position = 0;
            bytes.endian = "littleEndian"
            equipment[i] = NewItemData.CreateNew(bytes);
            i++;
        }*/
        while (i < equipment.length) {
            equipment[i] = NewItemData.TempCreate(parseInt(data[i]));
            i++;
        }

        return equipment;
    }
}
}
