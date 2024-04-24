package svera.untiered.storage.signals {
import org.osflash.signals.Signal;

import svera.untiered.messaging.impl.data.StorageSlotUpdateData;

public class GiftUpdateSignal extends Signal {
    public function GiftUpdateSignal() {
        super(int, Vector.<StorageSlotUpdateData>);
    }
}
}
