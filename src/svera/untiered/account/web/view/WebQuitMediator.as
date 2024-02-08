package svera.untiered.account.web.view
{
   import svera.untiered.account.core.Account;
   import svera.untiered.dialogs.control.CloseDialogsSignal;
   import svera.untiered.dialogs.control.OpenDialogSignal;
   import flash.desktop.NativeApplication;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class WebQuitMediator extends Mediator
   {
       
      
      [Inject]
      public var view:WebQuitDialog;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var closeDialog:CloseDialogsSignal;
      
      public function WebQuitMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.view.cancel.add(this.onDone);
         this.view.quit.add(this.onQuit);
      }
      
      override public function destroy() : void
      {
         this.view.quit.remove(this.onQuit);
         this.view.cancel.remove(this.onDone);
      }
      
      private function onDone() : void
      {
         this.closeDialog.dispatch();
      }

      private function onQuit() : void
      {
         this.closeDialog.dispatch();
         NativeApplication.nativeApplication.exit();
      }
   }
}
