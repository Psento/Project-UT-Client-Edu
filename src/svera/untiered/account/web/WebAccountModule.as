package svera.untiered.account.web {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

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

public class WebAccountModule implements IModule {


    public function WebAccountModule() {
        super();
    }

    public function configure(context:AppContext):void {
        this.mapModel(context);
        this.mapCommands(context);
        this.mapMediators(context);
        this.mapTasks(context);
    }

    protected function mapModel(context:AppContext):void {
        context.injector.map(Account).toSingleton(WebAccount);
    }

    protected function mapCommands(context:AppContext):void {
        context.commands.map(OpenQuitDialogSignal).toCommand(WebOpenQuitDialogCommand);
        context.commands.map(OpenAccountInfoSignal).toCommand(WebOpenAccountInfoCommand);
        context.commands.map(LoginSignal).toCommand(WebLoginCommand);
        context.commands.map(LogoutSignal).toCommand(WebLogoutCommand);
        context.commands.map(WebChangePasswordSignal).toCommand(WebChangePasswordCommand);
        context.commands.map(SendPasswordReminderSignal).toCommand(WebSendPasswordReminderCommand);
        context.commands.map(RegisterSignal).toCommand(WebRegisterAccountCommand);
        //context.commands.map(CharListDataSignal);
    }

    protected function mapMediators(context:AppContext):void {
        context.mediators.map(WebQuitDialog, WebQuitMediator);
        context.mediators.map(WebAccountInfoView, WebAccountInfoMediator);
        context.mediators.map(WebChangePasswordDialog, WebChangePasswordMediator);
        context.mediators.map(WebAccountDetailDialog, WebAccountDetailMediator);
        context.mediators.map(WebRegisterDialog, WebRegisterMediator);
        context.mediators.map(WebLoginDialog, WebLoginMediator);
    }

    protected function mapTasks(context:AppContext):void {
        context.injector.map(ChangePasswordTask).toType(WebChangePasswordTask);
        context.injector.map(LoadAccountTask).toType(WebLoadAccountTask);
        context.injector.map(LoginTask).toType(WebLoginTask);
        context.injector.map(RegisterAccountTask).toType(WebRegisterAccountTask);
        context.injector.map(SendPasswordReminderTask).toType(WebSendPasswordReminderTask);
    }
}
}
