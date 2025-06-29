package svera.untiered.account.core.view {
import com.company.assembleegameclient.ui.dialogs.Dialog;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class RegisterPromptDialog extends Dialog {


    public var cancel:Signal;

    public var register:Signal;

    public function RegisterPromptDialog(message:String) {
        super(message, "Not Registered", "Cancel", "Register");
        this.cancel = new NativeMappedSignal(this, LEFT_BUTTON);
        this.register = new NativeMappedSignal(this, RIGHT_BUTTON);
    }
}
}
