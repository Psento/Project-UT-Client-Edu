package com.company.util {
import flash.utils.IDataInput;

public class Guid {

    public static const Empty:String = "00000000-0000-0000-0000-000000000000";

    private static var tempData:Vector.<int> = new Vector.<int>(16, true);

    public static function guidDataToString(data:IDataInput): String {
        for (var i:int = 0; i < 16; i++) {
            tempData[i] = data.readUnsignedByte();
        }

        var part1:String = toHex(tempData[3]) + toHex(tempData[2]) + toHex(tempData[1]) + toHex(tempData[0]);
        var part2:String = toHex(tempData[5]) + toHex(tempData[4]);
        var part3:String = toHex(tempData[7]) + toHex(tempData[6]);
        var part4:String = toHex(tempData[8]) + toHex(tempData[9]);
        var part5:String = toHex(tempData[10]) + toHex(tempData[11]) + toHex(tempData[12]) + toHex(tempData[13]) + toHex(tempData[14]) + toHex(tempData[15]);

        return part1 + "-" + part2 + "-" + part3 + "-" + part4 + "-" + part5;
    }

    private static function toHex(n:int):String {
        return ("0" + n.toString(16)).substr(-2);
    }
}
}