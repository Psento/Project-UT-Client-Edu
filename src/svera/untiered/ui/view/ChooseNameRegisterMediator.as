package svera.untiered.ui.view {
import svera.lib.framework.Mediator;

import svera.untiered.account.core.signals.OpenAccountInfoSignal;

public class ChooseNameRegisterMediator extends Mediator {

    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;

    private function getChooseNameRegisterDialog():ChooseNameRegisterDialog {
       return view as ChooseNameRegisterDialog;
    }

    override public function initialize():void {
        this.getChooseNameRegisterDialog.register.add(this.onRegister);
        this.getChooseNameRegisterDialog.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.getChooseNameRegisterDialog.register.remove(this.onRegister);
        this.getChooseNameRegisterDialog.cancel.remove(this.onCancel);
    }

    private function onRegister():void {
        this.onCancel();
        this.openAccountManagement.dispatch();
    }

    private function onCancel():void {
        this.view.parent.removeChild(this.view);
    }
}
}
