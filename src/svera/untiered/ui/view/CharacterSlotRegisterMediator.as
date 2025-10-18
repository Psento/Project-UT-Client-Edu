package svera.untiered.ui.view {
import svera.lib.framework.Mediator;

import svera.untiered.account.core.signals.OpenAccountInfoSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class CharacterSlotRegisterMediator extends Mediator {

    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;

    [Inject]
    public var close:CloseDialogsSignal;

    private function getCharacterSlotRegisterDialog():CharacterSlotRegisterDialog {
        return view as CharacterSlotRegisterDialog;
    }

    override public function initialize():void {
        this.getCharacterSlotRegisterDialog.cancel.add(this.onCancel);
        this.getCharacterSlotRegisterDialog.register.add(this.onRegister);
    }

    override public function destroy():void {
        this.getCharacterSlotRegisterDialog.cancel.remove(this.onCancel);
        this.getCharacterSlotRegisterDialog.register.remove(this.onRegister);
    }

    private function onRegister():void {
        this.openAccountManagement.dispatch();
    }

    private function onCancel():void {
        this.close.dispatch();
    }
}
}
