package svera.untiered.core.signals
{
import org.osflash.signals.Signal;

import svera.lib.tasks.Task;

public class TaskErrorSignal extends Signal
   {
       
      
      public function TaskErrorSignal()
      {
         super(Task);
      }
   }
}
