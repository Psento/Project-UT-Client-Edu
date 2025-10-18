package svera.untiered.account.core.view {
import svera.lib.framework.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.account.core.signals.UpdateAccountInfoSignal;

public class AccountInfoMediator extends Mediator {


    [Inject]
    public var account:Account;

    [Inject]
    public var view:AccountInfoView;

    [Inject]
    public var update:UpdateAccountInfoSignal;

    public function AccountInfoMediator() {
        super();
    }

    override public function initialize():void {
        this.view.setInfo(this.account.getUserName(), this.account.isRegistered());
        this.update.add(this.updateLogin);
    }

    override public function destroy():void {
        this.update.remove(this.updateLogin);
    }

    private function updateLogin():void {
        this.view.setInfo(this.account.getUserName(), this.account.isRegistered());
    }
}
}
