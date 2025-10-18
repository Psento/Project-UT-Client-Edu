package svera.untiered.ui.view {
import svera.lib.framework.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class NotEnoughTsavoriteMediator extends Mediator {
    [Inject]
    public var account:Account;

    [Inject]
    public var closeDialogs:CloseDialogsSignal;

    private function getNotEnoughTsavoriteDialog():NotEnoughTsavoriteDialog {
        return view as NotEnoughTsavoriteDialog;
    }

    override public function initialize():void {
        this.getNotEnoughTsavoriteDialog.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.getNotEnoughTsavoriteDialog.cancel.remove(this.onCancel);
    }

    public function onCancel():void {
        this.closeDialogs.dispatch();
    }
}
}
