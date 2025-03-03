package svera.untiered.death.control {
import org.osflash.signals.Signal;

import svera.untiered.messaging.impl.incoming.Death;

public class HandleNormalDeathSignal extends Signal {


    public function HandleNormalDeathSignal() {
        super(Death);
    }
}
}
