package svera.untiered.storage.signals {
import link.ItemData;

import org.osflash.signals.Signal;

public class VaultUpdateSignal extends Signal {
    public function VaultUpdateSignal() {
        super(int, Vector.<ItemData>);
    }
}
}
