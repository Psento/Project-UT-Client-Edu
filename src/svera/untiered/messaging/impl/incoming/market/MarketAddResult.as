package svera.untiered.messaging.impl.incoming.market
{

import flash.utils.ByteArray;
import flash.utils.IDataInput;


import svera.untiered.messaging.impl.incoming.IncomingMessage;

public class MarketAddResult  extends IncomingMessage
{
    public var code_:int;
    public var description_:String;

    public function MarketAddResult(id:uint, callback:Function)
    {
        super(id,callback);
    }

    override public function parseFromInput(data:IDataInput) : void
    {
        this.code_ = data.readInt();
        this.description_ = data.readUTF();
    }
}
}
