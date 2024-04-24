package svera.untiered.storage.signals {
import org.osflash.signals.Signal;

public class VaultSlotUpdateSignal extends Signal{
    public function VaultSlotUpdateSignal() {
        super(int, int, int);
    }
}
}
