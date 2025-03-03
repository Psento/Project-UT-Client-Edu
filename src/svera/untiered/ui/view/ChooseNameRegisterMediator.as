package svera.untiered.ui.view {
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.account.core.signals.OpenAccountInfoSignal;

public class ChooseNameRegisterMediator extends Mediator {


    [Inject]
    public var view:ChooseNameRegisterDialog;

    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;

    public function ChooseNameRegisterMediator() {
        super();
    }

    override public function initialize():void {
        this.view.register.add(this.onRegister);
        this.view.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.view.register.remove(this.onRegister);
        this.view.cancel.remove(this.onCancel);
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
