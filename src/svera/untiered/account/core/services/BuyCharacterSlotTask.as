package svera.untiered.account.core.services {
import svera.lib.tasks.BaseTask;
import svera.untiered.account.core.Account;
import svera.untiered.appengine.api.AppEngineClient;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class BuyCharacterSlotTask extends BaseTask {


    [Inject]
    public var account:Account;

    [Inject]
    public var price:int;

    [Inject]
    public var client:AppEngineClient;

    [Inject]
    public var openDialog:OpenDialogSignal;

    [Inject]
    public var model:PlayerModel;

    public function BuyCharacterSlotTask() {
        super();
    }

    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/purchaseCharSlot", this.account.getCredentials());
    }

    private function onComplete(isOK:Boolean, data:*):void {
        isOK && this.updatePlayerData();
        completeTask(isOK, data);
    }

    private function updatePlayerData():void {
        this.model.setMaxCharacters(this.model.getMaxCharacters() + 1);
        this.model.changeFame(-this.price);
    }
}
}
