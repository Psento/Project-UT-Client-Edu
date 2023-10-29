package svera.untiered.dialogs
{
   import svera.untiered.dialogs.control.CloseDialogsSignal;
   import svera.untiered.dialogs.control.OpenDialogSignal;
   import svera.untiered.dialogs.control.ShowDialogBackgroundSignal;
   import svera.untiered.dialogs.view.DialogsMediator;
   import svera.untiered.dialogs.view.DialogsView;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
   import robotlegs.bender.framework.api.IConfig;
   
   public class DialogsConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      public function DialogsConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.injector.map(ShowDialogBackgroundSignal).asSingleton();
         this.injector.map(OpenDialogSignal).asSingleton();
         this.injector.map(CloseDialogsSignal).asSingleton();
         this.mediatorMap.map(DialogsView).toMediator(DialogsMediator);
      }
   }
}
