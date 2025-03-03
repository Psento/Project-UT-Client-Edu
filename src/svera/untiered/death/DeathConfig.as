package svera.untiered.death {
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

import svera.untiered.death.control.HandleDeathCommand;
import svera.untiered.death.control.HandleDeathSignal;
import svera.untiered.death.control.HandleNormalDeathCommand;
import svera.untiered.death.control.HandleNormalDeathSignal;
import svera.untiered.death.model.DeathModel;

public class DeathConfig implements IConfig {


    [Inject]
    public var injector:Injector;

    [Inject]
    public var commandMap:ISignalCommandMap;

    [Inject]
    public var mediatorMap:IMediatorMap;

    public function DeathConfig() {
        super();
    }

    public function configure():void {
        this.injector.map(DeathModel).asSingleton();
        this.commandMap.map(HandleDeathSignal).toCommand(HandleDeathCommand);
        this.commandMap.map(HandleNormalDeathSignal).toCommand(HandleNormalDeathCommand);
    }
}
}
