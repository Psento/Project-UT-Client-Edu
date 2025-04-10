package svera.untiered.messaging.impl.incoming.market
{

import flash.utils.ByteArray;
import flash.utils.IDataInput;


import svera.untiered.messaging.impl.incoming.IncomingMessage;

public class MarketBuyResult  extends IncomingMessage
{
    public var code_:int;
    public var description_:String;
    public var offerId_:int;

    public function MarketBuyResult(id:uint, callback:Function)
    {
        super(id,callback);
    }

    override public function parseFromInput(data:IDataInput) : void
    {
        this.code_ = data.readInt();
        this.description_ = data.readUTF();
        this.offerId_ = data.readInt();
    }
}
}
