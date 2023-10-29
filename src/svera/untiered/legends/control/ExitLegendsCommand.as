package svera.untiered.legends.control
{
   import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
   import svera.untiered.core.signals.InvalidateDataSignal;
   import svera.untiered.core.signals.SetScreenWithValidDataSignal;
   import svera.untiered.death.model.DeathModel;
   import svera.untiered.ui.view.TitleView;
   
   public class ExitLegendsCommand
   {
       
      
      [Inject]
      public var model:DeathModel;
      
      [Inject]
      public var invalidate:InvalidateDataSignal;
      
      [Inject]
      public var setScreen:SetScreenWithValidDataSignal;
      
      public function ExitLegendsCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         if(this.model.getIsDeathViewPending())
         {
            this.clearRecentlyDeceasedAndGotoCharacterView();
         }
         else
         {
            this.gotoTitleView();
         }
      }
      
      private function clearRecentlyDeceasedAndGotoCharacterView() : void
      {
         this.model.clearPendingDeathView();
         this.invalidate.dispatch();
         this.setScreen.dispatch(new CharacterSelectionAndNewsScreen());
      }
      
      private function gotoTitleView() : void
      {
         this.setScreen.dispatch(new TitleView());
      }
   }
}
