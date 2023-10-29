package svera.untiered.fame
{
   import svera.untiered.fame.control.ShowFameViewCommand;
   import svera.untiered.fame.control.ShowFameViewSignal;
   import svera.untiered.fame.model.FameModel;
   import svera.untiered.fame.service.RequestCharacterFameTask;
   import svera.untiered.fame.view.FameMediator;
   import svera.untiered.fame.view.FameView;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
   import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
   import robotlegs.bender.framework.api.IConfig;
   
   public class FameConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      public function FameConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.injector.map(FameModel).asSingleton();
         this.injector.map(RequestCharacterFameTask);
         this.commandMap.map(ShowFameViewSignal).toCommand(ShowFameViewCommand);
         this.mediatorMap.map(FameView).toMediator(FameMediator);
      }
   }
}
