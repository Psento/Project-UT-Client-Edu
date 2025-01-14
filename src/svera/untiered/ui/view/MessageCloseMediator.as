package svera.untiered.ui.view
{
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class MessageCloseMediator extends Mediator
   {
      [Inject]
      public var account:Account;
      
      [Inject]
      public var view:MessageCloseDialog;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      public function MessageCloseMediator()
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
