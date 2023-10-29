package svera.untiered.core.commands
{
   import svera.untiered.account.core.model.JSInitializedModel;
   import svera.untiered.core.model.PlayerModel;
   
   public class InvalidateDataCommand
   {
       
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var jsInitialized:JSInitializedModel;
      
      public function InvalidateDataCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.model.isInvalidated = true;
         this.jsInitialized.isInitialized = false;
      }
   }
}
