package svera.untiered.legends {
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

import svera.untiered.legends.control.ExitLegendsCommand;
import svera.untiered.legends.control.ExitLegendsSignal;
import svera.untiered.legends.control.HonorListUpdateSignal;
import svera.untiered.legends.control.RequestHonorListCommand;
import svera.untiered.legends.control.RequestHonorListSignal;
import svera.untiered.legends.model.LegendFactory;
import svera.untiered.legends.model.LegendsModel;
import svera.untiered.legends.view.LegendsMediator;
import svera.untiered.legends.view.LegendsView;

public class LegendsConfig implements IConfig {
    [Inject]
    public var injector:Injector;

    [Inject]
    public var mediatorMap:IMediatorMap;

    [Inject]
    public var commandMap:ISignalCommandMap;

    public function LegendsConfig() {
        super();
    }

    public function configure():void {
        this.injector.map(LegendFactory).asSingleton();
        this.injector.map(LegendsModel).asSingleton();
        this.injector.map(HonorListUpdateSignal).asSingleton();
        this.mediatorMap.map(LegendsView).toMediator(LegendsMediator);
        this.commandMap.map(RequestHonorListSignal).toCommand(RequestHonorListCommand);
        this.commandMap.map(ExitLegendsSignal).toCommand(ExitLegendsCommand);
    }
}
}
