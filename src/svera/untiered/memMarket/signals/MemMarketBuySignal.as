package svera.untiered.memMarket.signals {
import svera.untiered.messaging.impl.incoming.market.MarketBuyResult;

import org.osflash.signals.Signal;

public class MemMarketBuySignal extends Signal
{
    public static var instance:MemMarketBuySignal;

    public function MemMarketBuySignal()
    {
        super(MarketBuyResult);
        instance = this;
    }
}
}
