package svera.untiered.messaging.impl.outgoing.market
{

import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import svera.untiered.messaging.impl.outgoing.OutgoingMessage;

public class MarketAll extends OutgoingMessage
{

    public function MarketAll(id:uint, callback:Function)
    {
        super(id,callback);
    }

    override public function writeToOutput(data:IDataOutput) : void
    {

    }
}
}
