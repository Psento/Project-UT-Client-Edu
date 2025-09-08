package svera.untiered.storage.signals {

import org.osflash.signals.Signal;

import svera.untiered.itemdata.NewItemData;

public class GiftUpdateSignal extends Signal {
    public function GiftUpdateSignal() {
        super(int, Vector.<NewItemData>);
    }
}
}
