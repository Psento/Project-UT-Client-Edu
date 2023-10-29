package svera.untiered.core
{
   import flash.display.DisplayObjectContainer;
   import svera.lib.json.JsonParser;
   import svera.lib.json.SoftwareJsonParser;
   import svera.lib.tasks.TaskMonitor;
   import svera.untiered.account.core.signals.CharListDataSignal;
   import svera.untiered.core.commands.InvalidateDataCommand;
   import svera.untiered.core.commands.SetScreenWithValidDataCommand;
   import svera.untiered.core.commands.UpdatePlayerModelCommand;
   import svera.untiered.core.model.MapModel;
   import svera.untiered.core.model.PlayerModel;
   import svera.untiered.core.model.ScreenModel;
   import svera.untiered.core.signals.GotoPreviousScreenSignal;
   import svera.untiered.core.signals.HideTooltipsSignal;
   import svera.untiered.core.signals.InvalidateDataSignal;
   import svera.untiered.core.signals.LaunchGameSignal;
   import svera.untiered.core.signals.SetLoadingMessageSignal;
   import svera.untiered.core.signals.SetScreenSignal;
   import svera.untiered.core.signals.SetScreenWithValidDataSignal;
   import svera.untiered.core.signals.ShowTooltipSignal;
   import svera.untiered.core.signals.UpdateNewCharacterScreenSignal;
   import svera.untiered.core.view.Layers;
   import svera.untiered.core.view.ScreensMediator;
   import svera.untiered.core.view.ScreensView;
   import svera.untiered.startup.control.StartupSequence;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
   import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
   import robotlegs.bender.framework.api.IConfig;
   import robotlegs.bender.framework.api.IContext;
   
   public class CoreConfig implements IConfig
   {
       
      
      [Inject]
      public var context:IContext;
      
      [Inject]
      public var contextView:DisplayObjectContainer;
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var startup:StartupSequence;
      
      private var layers:Layers;
      
      public function CoreConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.configureModel();
         this.configureCommands();
         this.configureServices();
         this.configureSignals();
         this.configureViews();
         this.context.lifecycle.afterInitializing(this.init);
      }
      
      private function configureModel() : void
      {
         this.injector.map(PlayerModel).asSingleton();
         this.injector.map(MapModel).asSingleton();
         this.injector.map(ScreenModel).asSingleton();
      }
      
      private function configureCommands() : void
      {
         this.commandMap.map(InvalidateDataSignal).toCommand(InvalidateDataCommand);
         this.commandMap.map(SetScreenWithValidDataSignal).toCommand(SetScreenWithValidDataCommand);
         this.commandMap.map(CharListDataSignal).toCommand(UpdatePlayerModelCommand);
      }
      
      private function configureServices() : void
      {
         this.injector.map(JsonParser).toSingleton(SoftwareJsonParser);
         this.injector.map(TaskMonitor).asSingleton();
      }
      
      private function configureSignals() : void
      {
         this.injector.map(SetScreenSignal).asSingleton();
         this.injector.map(GotoPreviousScreenSignal).asSingleton();
         this.injector.map(LaunchGameSignal).asSingleton();
         this.injector.map(ShowTooltipSignal).asSingleton();
         this.injector.map(HideTooltipsSignal).asSingleton();
         this.injector.map(SetLoadingMessageSignal).asSingleton();
         this.injector.map(UpdateNewCharacterScreenSignal).asSingleton();
      }
      
      private function configureViews() : void
      {
         this.mediatorMap.map(ScreensView).toMediator(ScreensMediator);
      }
      
      private function init() : void
      {
         this.mediatorMap.mediate(this.contextView);
         this.layers = new Layers();
         this.injector.map(Layers).toValue(this.layers);
         this.contextView.addChild(this.layers);
      }
   }
}
