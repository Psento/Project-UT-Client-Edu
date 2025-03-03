package svera.untiered.account.web.signals {
import org.osflash.signals.Signal;

import svera.untiered.account.web.model.ChangePasswordData;

public class WebChangePasswordSignal extends Signal {


    public function WebChangePasswordSignal() {
        super(ChangePasswordData);
    }
}
}
