package svera.untiered.storage.signals {
import link.ItemData;

import org.osflash.signals.Signal;

public class GiftUpdateSignal extends Signal {
    public function GiftUpdateSignal() {
        super(int, Vector.<ItemData>);
    }
}
}
