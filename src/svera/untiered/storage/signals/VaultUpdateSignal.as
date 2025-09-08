package svera.untiered.storage.signals {

import org.osflash.signals.Signal;

import svera.untiered.itemdata.NewItemData;

public class VaultUpdateSignal extends Signal {
    public function VaultUpdateSignal() {
        super(int, Vector.<NewItemData>);
    }
}
}
