package svera.untiered.honor.control {
import org.osflash.signals.Signal;

import svera.untiered.honor.model.HonorVO;

public class ShowHonorViewSignal extends Signal {


    public function ShowHonorViewSignal() {
        super(HonorVO);
    }
}
}
