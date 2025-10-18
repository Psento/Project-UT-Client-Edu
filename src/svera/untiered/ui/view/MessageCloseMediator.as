package svera.untiered.ui.view {
import svera.lib.framework.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class MessageCloseMediator extends Mediator {
    [Inject]
    public var account:Account;

    [Inject]
    public var closeDialogs:CloseDialogsSignal;

    private function getMessageCloseDialog():MessageCloseDialog {
        return view as MessageCloseDialog;
    }

    override public function initialize():void {
        this.getMessageCloseDialog.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.getMessageCloseDialog.cancel.remove(this.onCancel);
    }

    public function onCancel():void {
        this.closeDialogs.dispatch();
    }
}
}
