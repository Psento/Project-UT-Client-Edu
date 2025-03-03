package svera.untiered.account.web.services {
import svera.lib.tasks.BaseTask;
import svera.untiered.account.core.Account;
import svera.untiered.account.core.services.LoginTask;
import svera.untiered.account.web.model.AccountData;
import svera.untiered.appengine.api.AppEngineClient;

public class WebLoginTask extends BaseTask implements LoginTask {


    [Inject]
    public var account:Account;

    [Inject]
    public var data:AccountData;

    [Inject]
    public var client:AppEngineClient;

    public function WebLoginTask() {
        super();
    }

    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/verify", {
            "username": this.data.username,
            "password": this.data.password
        });
    }

    private function onComplete(isOK:Boolean, data:*):void {
        if (isOK) {
            this.updateUser(data);
        }
        completeTask(isOK, data);
    }

    private function updateUser(response:String):void {
        this.account.updateUser(this.data.username, this.data.password);
    }
}
}
