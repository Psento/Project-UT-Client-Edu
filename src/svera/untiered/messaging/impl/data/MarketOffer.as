/**
 * Created by Fabian on 17.07.2015.
 */
package svera.untiered.messaging.impl.data {
import flash.utils.ByteArray;

public class MarketOffer {

    public var price:int;
    public var objectSlot:SlotObjectData;

    public function MarketOffer() {
        this.objectSlot = new SlotObjectData();
    }

    public function parseFromInput(rdr:ByteArray):void {
        this.price = rdr.readInt();
        this.objectSlot.parseFromInput(rdr);
    }

    public function writeToOutput(wtr:ByteArray):void {
        wtr.writeInt(this.price);
        objectSlot.writeToOutput(wtr);
    }

    public function toString():String {
        return "price: " + this.price + " objectSlot: " + objectSlot.toString();
    }
}
}
