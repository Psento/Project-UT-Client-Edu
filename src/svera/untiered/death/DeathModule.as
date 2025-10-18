package svera.untiered.death {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.untiered.death.control.HandleDeathCommand;
import svera.untiered.death.control.HandleDeathSignal;
import svera.untiered.death.control.HandleNormalDeathCommand;
import svera.untiered.death.control.HandleNormalDeathSignal;
import svera.untiered.death.model.DeathModel;

public class DeathModule implements IModule {

    public function DeathModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(DeathModel).asSingleton();
        context.commands.map(HandleDeathSignal).toCommand(HandleDeathCommand);
        context.commands.map(HandleNormalDeathSignal).toCommand(HandleNormalDeathCommand);
    }
}
}
