package svera.untiered.account.core.view {
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.account.core.signals.OpenAccountInfoSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class RegisterPromptDialogMediator extends Mediator {


    [Inject]
    public var view:RegisterPromptDialog;

    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;

    [Inject]
    public var close:CloseDialogsSignal;

    public function RegisterPromptDialogMediator() {
        super();
    }

    override public function initialize():void {
        this.view.cancel.add(this.onCancel);
        this.view.register.add(this.onRegister);
    }

    override public function destroy():void {
        this.view.cancel.remove(this.onCancel);
        this.view.register.remove(this.onRegister);
    }

    private function onRegister():void {
        this.onCancel();
        this.openAccountManagement.dispatch();
    }

    private function onCancel():void {
        this.close.dispatch();
    }
}
}
