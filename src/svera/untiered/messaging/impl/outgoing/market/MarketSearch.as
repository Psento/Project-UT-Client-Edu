package svera.untiered.messaging.impl.outgoing.market
{

import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import svera.untiered.messaging.impl.outgoing.OutgoingMessage;

public class MarketSearch extends OutgoingMessage
{
    public var itemType_:int;

    public function MarketSearch(id:uint, callback:Function)
    {
        super(id,callback);
    }

    override public function writeToOutput(data:IDataOutput) : void
    {
        data.writeInt(this.itemType_);
    }
}
}
