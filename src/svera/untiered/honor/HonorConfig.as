package svera.untiered.honor {
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

import svera.untiered.honor.control.ShowHonorViewCommand;
import svera.untiered.honor.control.ShowHonorViewSignal;
import svera.untiered.honor.model.HonorModel;
import svera.untiered.honor.service.RequestCharacterHonorTask;
import svera.untiered.honor.view.HonorMediator;
import svera.untiered.honor.view.HonorView;

public class HonorConfig implements IConfig {


    [Inject]
    public var injector:Injector;

    [Inject]
    public var mediatorMap:IMediatorMap;

    [Inject]
    public var commandMap:ISignalCommandMap;

    public function HonorConfig() {
        super();
    }

    public function configure():void {
        this.injector.map(HonorModel).asSingleton();
        this.injector.map(RequestCharacterHonorTask);
        this.commandMap.map(ShowHonorViewSignal).toCommand(ShowHonorViewCommand);
        this.mediatorMap.map(HonorView).toMediator(HonorMediator);
    }
}
}
