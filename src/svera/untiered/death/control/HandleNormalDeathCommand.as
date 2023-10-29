package svera.untiered.death.control
{
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import svera.lib.tasks.DispatchSignalTask;
   import svera.lib.tasks.TaskMonitor;
   import svera.lib.tasks.TaskSequence;
   import svera.untiered.account.core.services.GetCharListTask;
   import svera.untiered.core.model.PlayerModel;
   import svera.untiered.fame.control.ShowFameViewSignal;
   import svera.untiered.fame.model.FameVO;
   import svera.untiered.fame.model.SimpleFameVO;
   import svera.untiered.game.signals.DisconnectGameSignal;
   import svera.untiered.messaging.impl.incoming.Death;
   import robotlegs.bender.framework.api.ILogger;
   
   public class HandleNormalDeathCommand
   {
       
      
      [Inject]
      public var death:Death;
      
      [Inject]
      public var player:PlayerModel;
      
      [Inject]
      public var task:GetCharListTask;
      
      [Inject]
      public var showFame:ShowFameViewSignal;
      
      [Inject]
      public var monitor:TaskMonitor;
      
      [Inject]
      public var disconnect:DisconnectGameSignal;
      
      [Inject]
      public var logger:ILogger;
      
      private var fameVO:FameVO;
      
      public function HandleNormalDeathCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.fameVO = new SimpleFameVO(this.death.accountId_,this.death.charId_);
         this.gotoFameView();
      }
      
      private function gotoFameView() : void
      {
         if(this.player.getAccountId() == -1)
         {
            this.gotoFameViewOnceDataIsLoaded();
         }
         else
         {
            this.showFame.dispatch(this.fameVO);
         }
      }
      
      private function gotoFameViewOnceDataIsLoaded() : void
      {
         var sequence:TaskSequence = new TaskSequence();
         sequence.add(this.task);
         sequence.add(new DispatchSignalTask(this.showFame,this.fameVO));
         this.monitor.add(sequence);
         sequence.start();
      }
   }
}
