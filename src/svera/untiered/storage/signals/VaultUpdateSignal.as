package svera.untiered.storage.signals {
import org.osflash.signals.Signal;

import svera.untiered.messaging.impl.data.StorageSlotUpdateData;

public class VaultUpdateSignal extends Signal {
    public function VaultUpdateSignal() {
        super(int, Vector.<StorageSlotUpdateData>);
    }
}
}
