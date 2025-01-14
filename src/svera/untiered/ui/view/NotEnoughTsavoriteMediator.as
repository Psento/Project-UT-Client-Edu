package svera.untiered.ui.view
{
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class NotEnoughTsavoriteMediator extends Mediator
   {
      [Inject]
      public var account:Account;
      
      [Inject]
      public var view:NotEnoughTsavoriteDialog;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      public function NotEnoughTsavoriteMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.view.cancel.add(this.onCancel);
      }
      
      override public function destroy() : void
      {
         this.view.cancel.remove(this.onCancel);
      }
      
      public function onCancel() : void
      {
         this.closeDialogs.dispatch();
      }
   }
}
