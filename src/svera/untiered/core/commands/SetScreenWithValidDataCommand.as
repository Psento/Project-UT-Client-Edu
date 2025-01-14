package svera.untiered.core.commands
{
import com.company.assembleegameclient.screens.LoadingScreen;

import flash.display.Sprite;

import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.TaskMonitor;
import svera.lib.tasks.TaskSequence;
import svera.untiered.account.core.services.GetCharListTask;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.SetScreenSignal;

public class SetScreenWithValidDataCommand
   {
       
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var view:Sprite;
      
      [Inject]
      public var monitor:TaskMonitor;
      
      [Inject]
      public var task:GetCharListTask;
      
      public function SetScreenWithValidDataCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         if(this.model.isInvalidated)
         {
            this.reloadDataThenSetScreen();
         }
         else
         {
            this.setScreen.dispatch(this.view);
         }
      }
      
      private function reloadDataThenSetScreen() : void
      {
         this.setScreen.dispatch(new LoadingScreen());
         var sequence:TaskSequence = new TaskSequence();
         sequence.add(this.task);
         sequence.add(new DispatchSignalTask(this.setScreen,this.view));
         this.monitor.add(sequence);
         sequence.start();
      }
   }
}
