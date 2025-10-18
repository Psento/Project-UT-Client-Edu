package svera.untiered.legends {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.untiered.legends.control.ExitLegendsCommand;
import svera.untiered.legends.control.ExitLegendsSignal;
import svera.untiered.legends.control.HonorListUpdateSignal;
import svera.untiered.legends.control.RequestHonorListCommand;
import svera.untiered.legends.control.RequestHonorListSignal;
import svera.untiered.legends.model.LegendFactory;
import svera.untiered.legends.model.LegendsModel;
import svera.untiered.legends.view.LegendsMediator;
import svera.untiered.legends.view.LegendsView;

public class LegendsModule implements IModule {

    public function LegendsModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(LegendFactory).asSingleton();
        context.injector.map(LegendsModel).asSingleton();
        context.injector.map(HonorListUpdateSignal).asSingleton();
        context.mediators.map(LegendsView, LegendsMediator);
        context.commands.map(RequestHonorListSignal).toCommand(RequestHonorListCommand);
        context.commands.map(ExitLegendsSignal).toCommand(ExitLegendsCommand);
    }
}
}
