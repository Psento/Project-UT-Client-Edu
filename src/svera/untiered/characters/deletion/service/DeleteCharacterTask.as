package svera.untiered.characters.deletion.service
{
import com.company.assembleegameclient.appengine.SavedCharacter;

import svera.lib.tasks.BaseTask;
import svera.untiered.account.core.Account;
import svera.untiered.appengine.api.AppEngineClient;
import svera.untiered.characters.model.CharacterModel;

public class DeleteCharacterTask extends BaseTask
   {
       
      
      [Inject]
      public var character:SavedCharacter;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var model:CharacterModel;
      
      public function DeleteCharacterTask()
      {
         super();
      }
      
      override protected function startTask() : void
      {
         this.client.setMaxRetries(2);
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/char/delete",this.getRequestPacket());
      }
      
      private function getRequestPacket() : Object
      {
         var params:Object = this.account.getCredentials();
         params.charId = this.character.charId();
         return params;
      }
      
      private function onComplete(isOK:Boolean, data:*) : void
      {
         isOK && this.updateUserData();
         completeTask(isOK,data);
      }
      
      private function updateUserData() : void
      {
         this.model.deleteCharacter(this.character.charId());
      }
   }
}
