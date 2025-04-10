package svera.untiered.memMarket.signals {
import svera.untiered.messaging.impl.incoming.market.MarketMyOffersResult;

import org.osflash.signals.Signal;

public class MemMarketMyOffersSignal extends Signal
{
    public static var instance:MemMarketMyOffersSignal;

    public function MemMarketMyOffersSignal()
    {
        super(MarketMyOffersResult);
        instance = this;
    }
}
}
