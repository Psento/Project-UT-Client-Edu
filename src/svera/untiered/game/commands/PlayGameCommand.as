package svera.untiered.game.commands
{
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.utils.ByteArray;
   import svera.lib.tasks.TaskMonitor;
   import svera.untiered.core.model.PlayerModel;
   import svera.untiered.core.signals.SetScreenSignal;
   import svera.untiered.game.model.GameInitData;
   
   public class PlayGameCommand
   {
       
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var data:GameInitData;
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var monitor:TaskMonitor;
      
      public function PlayGameCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.recordCharacterUseInSharedObject();
         this.makeGameView();
      }
      
      private function recordCharacterUseInSharedObject() : void
      {
         Parameters.data_.charIdUseMap[this.data.charId] = new Date().getTime();
         Parameters.save();
      }
      
      private function makeGameView() : void
      {
         var gameId:int = this.data.isNewGame ? int(this.getInitialGameId()) : int(this.data.gameId);
         var createCharacter:Boolean = this.data.createCharacter;
         var charId:int = this.data.charId;
         this.model.currentCharId = charId;
         this.setScreen.dispatch(new GameSprite(gameId,createCharacter,charId,this.model,null, this.data.traits));
      }
      
      private function getInitialGameId() : int
      {
         var gameId:int = 0;
         gameId = Parameters.NEXUS_GAMEID;
         return gameId;
      }
   }
}
