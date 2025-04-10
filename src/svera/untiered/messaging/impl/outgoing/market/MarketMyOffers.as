package svera.untiered.messaging.impl.outgoing.market
{

import flash.utils.ByteArray;
import flash.utils.IDataOutput;

import svera.untiered.messaging.impl.outgoing.OutgoingMessage;

public class MarketMyOffers extends OutgoingMessage
{

    public function MarketMyOffers(id:uint, callback:Function)
    {
        super(id,callback);
    }

    override public function writeToOutput(data:IDataOutput) : void
    {
    }
}
}
