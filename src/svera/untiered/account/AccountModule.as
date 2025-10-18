package svera.untiered.account {
import flash.display.DisplayObjectContainer;
import flash.display.LoaderInfo;

import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;
import svera.lib.framework.IModule;
import svera.untiered.account.core.BuyCharacterSlotCommand;
import svera.untiered.account.core.control.IsAccountRegisteredGuard;
import svera.untiered.account.core.services.GetCharListTask;
import svera.untiered.account.core.signals.UpdateAccountInfoSignal;
import svera.untiered.account.web.WebAccountModule;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.ui.signals.BuyCharacterSlotSignal;

public class AccountModule implements IModule {

    public function configure(context:AppContext):void {
        this.configureCommonFunctionality(context);
        this.configureAccountSpecificFunctionality(context);
    }

    private function configureCommonFunctionality(context:AppContext):void {
        var injector:Injector = context.injector;

        // Map signals and services
        injector.map(TaskErrorSignal).asSingleton();
        injector.map(UpdateAccountInfoSignal).asSingleton();
        injector.map(GetCharListTask);

        // Map commands with guards
        context.commands.map(BuyCharacterSlotSignal)
                .toCommand(BuyCharacterSlotCommand)
                .withGuards(IsAccountRegisteredGuard);
    }

    private function configureAccountSpecificFunctionality(context:AppContext):void {
        // Install sub-module
        var webAccountModule:WebAccountModule = new WebAccountModule();
        webAccountModule.configure(context);
    }
}
}