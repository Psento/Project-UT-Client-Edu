package svera.untiered.classes.services {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import svera.lib.tasks.BaseTask;
import svera.untiered.account.core.Account;
import svera.untiered.appengine.api.AppEngineClient;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class BuySkinTask extends BaseTask {


    [Inject]
    public var skin:CharacterSkin;

    [Inject]
    public var client:AppEngineClient;

    [Inject]
    public var account:Account;

    [Inject]
    public var player:PlayerModel;

    [Inject]
    public var openDialog:OpenDialogSignal;

    public function BuySkinTask() {
        super();
    }

    override protected function startTask():void {
        this.skin.setState(CharacterSkinState.PURCHASING);
        this.player.changeTsavorite(-this.skin.cost);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("account/purchaseSkin", this.makeCredentials());
    }

    private function makeCredentials():Object {
        var credentials:Object = this.account.getCredentials();
        credentials.skinType = this.skin.id;
        return credentials;
    }

    private function onComplete(isOK:Boolean, data:*):void {
        if (isOK) {
            this.completePurchase();
        } else {
            this.abandonPurchase(data);
        }
        completeTask(isOK, data);
    }

    private function completePurchase():void {
        this.skin.setState(CharacterSkinState.OWNED);
        this.skin.setIsSelected(true);
        skin.bought.dispatch(skin);
    }

    private function abandonPurchase(problem:String):void {
        var errorDialog:ErrorDialog = new ErrorDialog(problem);
        this.openDialog.dispatch(errorDialog);
        this.skin.setState(CharacterSkinState.PURCHASABLE);
        this.player.changeTsavorite(this.skin.cost);
    }
}
}
