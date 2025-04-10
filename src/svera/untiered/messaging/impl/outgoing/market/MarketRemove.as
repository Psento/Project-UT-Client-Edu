package svera.untiered.messaging.impl.outgoing.market
{

import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import svera.untiered.messaging.impl.outgoing.OutgoingMessage;

public class MarketRemove extends OutgoingMessage
{
    public var id_:int;

    public function MarketRemove(id:uint, callback:Function)
    {
        super(id,callback);
    }

    override public function writeToOutput(data:IDataOutput) : void
    {
        data.writeInt(this.id_);
    }
}
}
