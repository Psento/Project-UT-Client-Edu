package svera.untiered.vault.signals {
import org.osflash.signals.Signal;

import svera.untiered.messaging.impl.data.VaultUpdateSlot;

public class VaultUpdateSignal extends Signal {
    public function VaultUpdateSignal() {
        super(int, Vector.<VaultUpdateSlot>);
    }
}
}
