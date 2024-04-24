package svera.untiered.storage.signals {
import org.osflash.signals.Signal;

public class GiftSlotUpdateSignal extends Signal {
    public function GiftSlotUpdateSignal() {
        super(int, int, int);
    }
}
}
