package svera.untiered.account.web.view
{
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.lib.tasks.Task;
import svera.untiered.account.core.signals.LoginSignal;
import svera.untiered.account.web.model.AccountData;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class WebLoginMediator extends Mediator
   {
       
      
      [Inject]
      public var view:WebLoginDialog;
      
      [Inject]
      public var login:LoginSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var closeDialog:CloseDialogsSignal;
      
      [Inject]
      public var loginError:TaskErrorSignal;
      
      public function WebLoginMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.view.signIn.add(this.onSignIn);
         this.view.register.add(this.onRegister);
         this.view.cancel.add(this.onCancel);
         this.loginError.add(this.onLoginError);
      }
      
      override public function destroy() : void
      {
         this.view.signIn.remove(this.onSignIn);
         this.view.register.remove(this.onRegister);
         this.view.cancel.remove(this.onCancel);
         this.loginError.remove(this.onLoginError);
      }
      
      private function onSignIn(data:AccountData) : void
      {
         this.view.disable();
         this.login.dispatch(data);
      }
      
      private function onRegister() : void
      {
         this.openDialog.dispatch(new WebRegisterDialog());
      }
      
      private function onCancel() : void
      {
         this.closeDialog.dispatch();
      }
      
      private function onLoginError(task:Task) : void
      {
         this.view.setError(task.error);
         this.view.enable();
      }
   }
}
