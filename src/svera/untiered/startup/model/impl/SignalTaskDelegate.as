package svera.untiered.startup.model.impl
{
import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.untiered.startup.model.api.StartupDelegate;

public class SignalTaskDelegate implements StartupDelegate
   {
       
      
      public var injector:Injector;
      
      public var signalClass:Class;
      
      public var priority:int;
      
      public function SignalTaskDelegate()
      {
         super();
      }
      
      public function getPriority() : int
      {
         return this.priority;
      }
      
      public function make() : Task
      {
         var signal:Signal = this.injector.getInstance(this.signalClass);
         return new DispatchSignalTask(signal);
      }
   }
}
