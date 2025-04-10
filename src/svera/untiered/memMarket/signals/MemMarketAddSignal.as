package svera.untiered.memMarket.signals {
import svera.untiered.messaging.impl.incoming.market.MarketAddResult;

import org.osflash.signals.Signal;

public class MemMarketAddSignal extends Signal
{
    public static var instance:MemMarketAddSignal;

    public function MemMarketAddSignal()
    {
        super(MarketAddResult);
        instance = this;
    }
}
}
