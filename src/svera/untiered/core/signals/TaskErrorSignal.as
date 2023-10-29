package svera.untiered.core.signals
{
   import svera.lib.tasks.Task;
   import org.osflash.signals.Signal;
   
   public class TaskErrorSignal extends Signal
   {
       
      
      public function TaskErrorSignal()
      {
         super(Task);
      }
   }
}
