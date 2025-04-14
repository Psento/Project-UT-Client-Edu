package svera.untiered.messaging.impl.data {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class StatData {

    public var statType_:uint = 0;

    public var statValue_:int;

    public var strStatValue_:String;

    public var uintStatValue:uint;

    public var slotStatValue:int;

    public var byteArrayValue:ByteArray;

    public function StatData() {
        super();
    }

    public static function statToName(stat:int):String {
        switch (stat) {
            case 0:
                return "Maximum HP";
            case 1:
                return "Maximum SP";
            case 2:
                return "Maximum RP";
            case 3:
                return "Attack";
            case 4:
                return "Armor";
            case 5:
                return "Speed";
            case 6:
                return "Dexterity";
            case 7:
                return "Vigor";
            case 8:
                return "Intelligence";
            default:
                return "Unknown Stat";
        }
    }

    public function isStringStat():Boolean {
        switch (this.statType_) {
            case StatType.Name:
            case StatType.GuildName:
                return true;
            default:
                return false;
        }
    }

    public function parseFromInput(data:IDataInput):void {
        this.statType_ = data.readUnsignedByte();

        switch (this.statType_) {
            case StatType.Name:
            case StatType.GuildName:
                this.strStatValue_ = data.readUTF();
                break;
            case StatType.ItemData:
            case StatType.ItemDataChange:
                this.slotStatValue = data.readUnsignedShort();
                var len:Number = data.readShort();
                this.byteArrayValue = new ByteArray();
                for(var i:Number = 0; i < len; i++) {
                    this.byteArrayValue.writeByte(data.readUnsignedByte());
                }
                this.byteArrayValue.endian = "littleEndian";
                this.byteArrayValue.position = 0;
                break;
            case StatType.Inventory:
                this.slotStatValue = data.readUnsignedShort();
                this.statValue_ = data.readInt();
                break;
            default:
                this.statValue_ = data.readInt();
                break;
        }
    }

    public function writeToOutput(data:IDataOutput):void {
        data.writeByte(this.statType_);
        if (this.isStringStat()) {
            data.writeUTF(this.strStatValue_);
        } else {
            data.writeInt(this.statValue_);
        }
    }

    public function toString():String {
        if (this.isStringStat()) {
            return "[" + this.statType_ + ": \"" + this.strStatValue_ + "\"]";
        }
        return "[" + this.statType_ + ": " + this.statValue_ + "]";
    }
}
}
