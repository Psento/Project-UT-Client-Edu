package svera.untiered.account.web.commands
{
   import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
   import flash.display.Sprite;
   import svera.untiered.account.core.Account;
   import svera.untiered.core.model.ScreenModel;
   import svera.untiered.core.signals.InvalidateDataSignal;
   import svera.untiered.core.signals.SetScreenWithValidDataSignal;
   
   public class WebLogoutCommand
   {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var invalidate:InvalidateDataSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var model:ScreenModel;
      
      public function WebLogoutCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.account.clear();
         this.invalidate.dispatch();
         this.setScreenWithValidData.dispatch(this.makeScreen());
      }
      
      private function makeScreen() : Sprite
      {
         return new (this.model.currentType || CharacterSelectionAndNewsScreen)();
      }
   }
}
