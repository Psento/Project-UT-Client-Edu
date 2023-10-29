package svera.untiered.ui.view
{
   import com.company.assembleegameclient.mapeditor.MapEditor;
import com.company.assembleegameclient.parameters.Parameters;

import svera.untiered.account.core.signals.OpenAccountInfoSignal;
   import svera.untiered.core.model.PlayerModel;
   import svera.untiered.core.signals.SetScreenSignal;
   import svera.untiered.core.signals.SetScreenWithValidDataSignal;
   import svera.untiered.dialogs.control.OpenDialogSignal;
   import svera.untiered.legends.view.LegendsView;
   import svera.untiered.ui.signals.EnterGameSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class TitleMediator extends Mediator
   {
      [Inject]
      public var view:TitleView;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var enterGame:EnterGameSignal;
      
      [Inject]
      public var openAccountInfo:OpenAccountInfoSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      public function TitleMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.view.initialize();
         this.view.playClicked.add(this.handleIntentionToPlay);
         this.view.accountClicked.add(this.handleIntentionToReviewAccount);
         this.view.legendsClicked.add(this.showLegendsScreen);
         this.view.editorClicked.add(this.showMapEditor);
      }
      
      override public function destroy() : void
      {
         this.view.playClicked.remove(this.handleIntentionToPlay);
         this.view.accountClicked.remove(this.handleIntentionToReviewAccount);
         this.view.legendsClicked.remove(this.showLegendsScreen);
         this.view.editorClicked.remove(this.showMapEditor);
      }
      
      private function handleIntentionToPlay() : void
      {
         this.enterGame.dispatch();
      }
      
      private function handleIntentionToReviewAccount() : void
      {
         this.openAccountInfo.dispatch(false);
      }
      
      private function showLegendsScreen() : void
      {
         this.setScreen.dispatch(new LegendsView());
      }
      
      private function showMapEditor() : void
      {
         this.setScreen.dispatch(new MapEditor());
      }
   }
}
