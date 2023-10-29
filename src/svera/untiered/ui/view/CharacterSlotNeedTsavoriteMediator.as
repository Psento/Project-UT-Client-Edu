package svera.untiered.ui.view
{
import com.company.assembleegameclient.parameters.Parameters;

import svera.untiered.core.model.PlayerModel;
   import svera.untiered.dialogs.control.CloseDialogsSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class CharacterSlotNeedTsavoriteMediator extends Mediator
   {
       
      
      [Inject]
      public var view:CharacterSlotNeedTsavoriteDialog;
      
      [Inject]
      public var closeDialog:CloseDialogsSignal;
      
      [Inject]
      public var model:PlayerModel;
      
      public function CharacterSlotNeedTsavoriteMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.view.cancel.add(this.onCancel);
         this.view.setPrice(Parameters.CHARACTER_SLOT_PRICE);
      }
      
      override public function destroy() : void
      {
         this.view.cancel.remove(this.onCancel);
      }
      
      public function onCancel() : void
      {
         this.closeDialog.dispatch();
      }
   }
}
