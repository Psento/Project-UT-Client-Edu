package svera.untiered.account.web.services
{
import svera.lib.tasks.BaseTask;
import svera.untiered.account.core.Account;
import svera.untiered.account.core.services.RegisterAccountTask;
import svera.untiered.account.web.model.AccountData;
import svera.untiered.appengine.api.AppEngineClient;
import svera.untiered.core.model.PlayerModel;

public class WebRegisterAccountTask extends BaseTask implements RegisterAccountTask
   {
       
      
      [Inject]
      public var data:AccountData;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var client:AppEngineClient;
      
      public function WebRegisterAccountTask()
      {
         super();
      }
      
      override protected function startTask() : void
      {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/account/register",this.makeDataPacket());
      }
      
      private function makeDataPacket() : Object
      {
         var obj:Object = {};
         obj.newUsername = this.data.username;
         obj.newPassword = this.data.password;
         return obj;
      }
      
      private function onComplete(isOK:Boolean, data:*) : void
      {
         isOK && this.onRegisterDone();
         completeTask(isOK,data);
      }
      
      private function onRegisterDone() : void
      {
         this.account.updateUser(this.data.username,this.data.password);
      }
   }
}
