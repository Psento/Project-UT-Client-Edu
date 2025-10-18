package svera.untiered.startup {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.untiered.startup.control.StartupCommand;
import svera.untiered.startup.control.StartupSequence;
import svera.untiered.startup.control.StartupSignal;

public class StartupModule implements IModule {

    public function StartupModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(StartupSequence).asSingleton();
        context.injector.map(StartupSignal).asSingleton();
        context.commands.map(StartupSignal).toCommand(StartupCommand);
    }
}
}
