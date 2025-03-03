package svera.untiered.ui.view {
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.account.core.signals.OpenAccountInfoSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class CharacterSlotRegisterMediator extends Mediator {


    [Inject]
    public var view:CharacterSlotRegisterDialog;

    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;

    [Inject]
    public var close:CloseDialogsSignal;

    public function CharacterSlotRegisterMediator() {
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
        this.openAccountManagement.dispatch();
    }

    private function onCancel():void {
        this.close.dispatch();
    }
}
}
