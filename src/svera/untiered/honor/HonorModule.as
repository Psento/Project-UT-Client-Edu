package svera.untiered.honor {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.untiered.honor.control.ShowHonorViewCommand;
import svera.untiered.honor.control.ShowHonorViewSignal;
import svera.untiered.honor.model.HonorModel;
import svera.untiered.honor.service.RequestCharacterHonorTask;
import svera.untiered.honor.view.HonorMediator;
import svera.untiered.honor.view.HonorView;

public class HonorModule implements IModule {

    public function HonorModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(HonorModel).asSingleton();
        context.injector.map(RequestCharacterHonorTask);
        context.commands.map(ShowHonorViewSignal).toCommand(ShowHonorViewCommand);
        context.mediators.map(HonorView, HonorMediator);
    }
}
}
