package svera.untiered.startup.model.impl
{
   import svera.lib.tasks.Task;
   import svera.untiered.startup.model.api.StartupDelegate;
   import org.swiftsuspenders.Injector;
   
   public class TaskDelegate implements StartupDelegate
   {
       
      
      public var injector:Injector;
      
      public var taskClass:Class;
      
      public var priority:int;
      
      public function TaskDelegate()
      {
         super();
      }
      
      public function getPriority() : int
      {
         return this.priority;
      }
      
      public function make() : Task
      {
         return this.injector.getInstance(this.taskClass);
      }
   }
}
