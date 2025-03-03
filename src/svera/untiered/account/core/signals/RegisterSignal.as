package svera.untiered.account.core.signals {
import org.osflash.signals.Signal;

import svera.untiered.account.web.model.AccountData;

public class RegisterSignal extends Signal {


    public function RegisterSignal() {
        super(AccountData);
    }
}
}
