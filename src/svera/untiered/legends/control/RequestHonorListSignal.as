package svera.untiered.legends.control {
import org.osflash.signals.Signal;

import svera.untiered.legends.model.Timespan;

public class RequestHonorListSignal extends Signal {


    public function RequestHonorListSignal() {
        super(Timespan);
    }
}
}
