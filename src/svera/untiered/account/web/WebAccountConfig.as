package svera.untiered.account.web
{
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

import svera.untiered.account.core.Account;
import svera.untiered.account.core.services.ChangePasswordTask;
import svera.untiered.account.core.services.LoadAccountTask;
import svera.untiered.account.core.services.LoginTask;
import svera.untiered.account.core.services.RegisterAccountTask;
import svera.untiered.account.core.services.SendPasswordReminderTask;
import svera.untiered.account.core.signals.LoginSignal;
import svera.untiered.account.core.signals.LogoutSignal;
import svera.untiered.account.core.signals.OpenAccountInfoSignal;
import svera.untiered.account.core.signals.OpenQuitDialogSignal;
import svera.untiered.account.core.signals.RegisterSignal;
import svera.untiered.account.core.signals.SendPasswordReminderSignal;
import svera.untiered.account.web.commands.WebChangePasswordCommand;
import svera.untiered.account.web.commands.WebLoginCommand;
import svera.untiered.account.web.commands.WebLogoutCommand;
import svera.untiered.account.web.commands.WebOpenAccountInfoCommand;
import svera.untiered.account.web.commands.WebOpenQuitDialogCommand;
import svera.untiered.account.web.commands.WebRegisterAccountCommand;
import svera.untiered.account.web.commands.WebSendPasswordReminderCommand;
import svera.untiered.account.web.services.WebChangePasswordTask;
import svera.untiered.account.web.services.WebLoadAccountTask;
import svera.untiered.account.web.services.WebLoginTask;
import svera.untiered.account.web.services.WebRegisterAccountTask;
import svera.untiered.account.web.services.WebSendPasswordReminderTask;
import svera.untiered.account.web.signals.WebChangePasswordSignal;
import svera.untiered.account.web.view.WebAccountDetailDialog;
import svera.untiered.account.web.view.WebAccountDetailMediator;
import svera.untiered.account.web.view.WebAccountInfoMediator;
import svera.untiered.account.web.view.WebAccountInfoView;
import svera.untiered.account.web.view.WebChangePasswordDialog;
import svera.untiered.account.web.view.WebChangePasswordMediator;
import svera.untiered.account.web.view.WebLoginDialog;
import svera.untiered.account.web.view.WebLoginMediator;
import svera.untiered.account.web.view.WebQuitDialog;
import svera.untiered.account.web.view.WebQuitMediator;
import svera.untiered.account.web.view.WebRegisterDialog;
import svera.untiered.account.web.view.WebRegisterMediator;

public class WebAccountConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      public function WebAccountConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.mapModel();
         this.mapCommands();
         this.mapMediators();
         this.mapTasks();
      }
      
      protected function mapModel() : void
      {
         this.injector.map(Account).toSingleton(WebAccount);
         //this.injector.map(CharListDataSignal).asSingleton();
      }
      
      protected function mapCommands() : void
      {
         this.commandMap.map(OpenQuitDialogSignal).toCommand(WebOpenQuitDialogCommand);
         this.commandMap.map(OpenAccountInfoSignal).toCommand(WebOpenAccountInfoCommand);
         this.commandMap.map(LoginSignal).toCommand(WebLoginCommand);
         this.commandMap.map(LogoutSignal).toCommand(WebLogoutCommand);
         this.commandMap.map(WebChangePasswordSignal).toCommand(WebChangePasswordCommand);
         this.commandMap.map(SendPasswordReminderSignal).toCommand(WebSendPasswordReminderCommand);
         this.commandMap.map(RegisterSignal).toCommand(WebRegisterAccountCommand);
         //this.commandMap.map(CharListDataSignal);
      }
      
      protected function mapMediators() : void
      {
         this.mediatorMap.map(WebQuitDialog).toMediator(WebQuitMediator);
         this.mediatorMap.map(WebAccountInfoView).toMediator(WebAccountInfoMediator);
         this.mediatorMap.map(WebChangePasswordDialog).toMediator(WebChangePasswordMediator);
         this.mediatorMap.map(WebAccountDetailDialog).toMediator(WebAccountDetailMediator);
         this.mediatorMap.map(WebRegisterDialog).toMediator(WebRegisterMediator);
         this.mediatorMap.map(WebLoginDialog).toMediator(WebLoginMediator);
      }
      
      protected function mapTasks() : void
      {
         this.injector.map(ChangePasswordTask).toType(WebChangePasswordTask);
         this.injector.map(LoadAccountTask).toType(WebLoadAccountTask);
         this.injector.map(LoginTask).toType(WebLoginTask);
         this.injector.map(RegisterAccountTask).toType(WebRegisterAccountTask);
         this.injector.map(SendPasswordReminderTask).toType(WebSendPasswordReminderTask);
      }
   }
}
