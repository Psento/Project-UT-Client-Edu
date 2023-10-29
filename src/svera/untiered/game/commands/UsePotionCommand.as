package svera.untiered.game.commands
{
   import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.sound.SoundEffectLibrary;

import svera.untiered.game.model.PotionInventoryModel;
   import svera.untiered.game.model.UsePotionVO;
   import svera.untiered.messaging.impl.GameServerConnection;
   import svera.untiered.ui.model.HUDModel;
   import svera.untiered.ui.model.PotionModel;
   import robotlegs.bender.framework.api.ILogger;
   
   public class UsePotionCommand
   {
       
      
      [Inject]
      public var vo:UsePotionVO;
      
      [Inject]
      public var potInventoryModel:PotionInventoryModel;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var logger:ILogger;
      
      private var gsc:GameServerConnection;
      
      private var player:Player;
      
      private var potionId:int;
      
      private var count:int;
      
      private var potion:PotionModel;
      
      public function UsePotionCommand()
      {
         this.gsc = GameServerConnection.instance;
         super();
      }
      
      public function execute() : void
      {
         this.player = this.hudModel.gameSprite.map.player_;
         this.potionId = this.vo.objectId;
         this.count = this.player.getPotionCount(this.potionId);
         this.potion = this.potInventoryModel.getPotionModel(this.potionId);
         if(this.count > 0)
         {
            this.usePotionIfEffective();
         }
      }

      private function usePotionIfEffective() : void
      {
         if(this.isPlayerStatMaxed())
         {
            this.logger.info("UsePotionCommand.execute: User has MAX of that attribute, not requesting a use from server.");
         }
         else
         {
            this.sendServerRequest();
         }
      }
      
      private function isPlayerStatMaxed() : Boolean
      {
         if(this.potionId == PotionInventoryModel.HEALTH_POTION_ID)
         {
            return this.player.hp_ >= this.player.maxHP_;
         }
         if(this.potionId == PotionInventoryModel.MAGIC_POTION_ID)
         {
            return this.player.rp_ >= this.player.maxRP_;
         }
         return false;
      }
      
      private function sendServerRequest() : void
      {
         var slot:int = PotionInventoryModel.getPotionSlot(this.vo.objectId);
         this.gsc.useItem(this.gsc.gs_.lastUpdate_,this.player.objectId_,slot,this.player.x_,this.player.y_);
         SoundEffectLibrary.play("use_potion");
      }
   }
}
