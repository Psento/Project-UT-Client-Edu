package svera.untiered.game.view {

import svera.untiered.account.core.Account;
import svera.untiered.game.signals.UpdateLootboxButtonSignal;

public class LootboxMediator {

    [Inject]
    public var updateLootboxButtonSignal:UpdateLootboxButtonSignal;
    [Inject]
    public var view:LootboxModalButton;
    [Inject]
    public var account:Account;

    public function initialize():void {
        this.updateLootboxButtonSignal.add(this.onLootboxUpdate);
        if (this.account.isRegistered()) {
            this.view.drawAsOpen();
        }
        else {
            this.view.drawAsClosed();
        }
    }

    private function onLootboxUpdate():void {
        if (this.account.isRegistered()) {
            this.view.drawAsOpen();
        }
        else {
            this.view.drawAsClosed();
        }
    }


}
}//package svera.untiered.game.view
