package svera.untiered.ui.view
{
   import svera.untiered.account.core.Account;
   import svera.untiered.dialogs.control.CloseDialogsSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
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
