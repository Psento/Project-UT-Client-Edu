package svera.untiered.memMarket.signals {
import svera.untiered.messaging.impl.incoming.market.MarketRemoveResult;

import org.osflash.signals.Signal;

public class MemMarketRemoveSignal extends Signal
{
    public static var instance:MemMarketRemoveSignal;

    public function MemMarketRemoveSignal()
    {
        super(MarketRemoveResult);
        instance = this;
    }
}
}
