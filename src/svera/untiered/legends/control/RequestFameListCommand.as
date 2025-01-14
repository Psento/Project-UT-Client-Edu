package svera.untiered.legends.control
{
import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.lib.tasks.TaskMonitor;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.death.model.DeathModel;
import svera.untiered.fame.model.FameModel;
import svera.untiered.legends.service.GetLegendsListTask;

public class RequestFameListCommand
   {
       
      
      [Inject]
      public var task:GetLegendsListTask;
      
      [Inject]
      public var update:FameListUpdateSignal;
      
      [Inject]
      public var error:TaskErrorSignal;
      
      [Inject]
      public var monitor:TaskMonitor;
      
      [Inject]
      public var player:PlayerModel;
      
      [Inject]
      public var death:DeathModel;
      
      [Inject]
      public var model:FameModel;
      
      public function RequestFameListCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.task.charId = this.getCharId();
         var branch:BranchingTask = new BranchingTask(this.task,this.makeSuccess(),this.makeFailure());
         this.monitor.add(branch);
         branch.start();
      }
      
      private function getCharId() : int
      {
         if(this.player.hasAccount() && this.death.getIsDeathViewPending())
         {
            return this.death.getLastDeath().charId_;
         }
         return -1;
      }
      
      private function makeSuccess() : Task
      {
         return new DispatchSignalTask(this.update);
      }
      
      private function makeFailure() : Task
      {
         return new DispatchSignalTask(this.error,this.task);
      }
   }
}
