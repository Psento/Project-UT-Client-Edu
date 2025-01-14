package svera.untiered.startup.model.api
{
import svera.lib.tasks.Task;

public interface StartupDelegate
   {
       
      
      function getPriority() : int;
      
      function make() : Task;
   }
}
