package svera.untiered.startup
{
   import svera.untiered.startup.control.StartupCommand;
   import svera.untiered.startup.control.StartupSequence;
   import svera.untiered.startup.control.StartupSignal;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
   import robotlegs.bender.framework.api.IConfig;
   
   public class StartupConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      public function StartupConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.injector.map(StartupSequence).asSingleton();
         this.commandMap.map(StartupSignal).toCommand(StartupCommand);
      }
   }
}
