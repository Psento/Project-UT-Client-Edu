package svera.untiered.tooltips {
import svera.lib.framework.IModule;
import svera.lib.framework.AppContext;

import svera.untiered.tooltips.view.TooltipsMediator;
import svera.untiered.tooltips.view.TooltipsView;

public class TooltipsModule implements IModule {

    public function TooltipsModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.mediators.map(TooltipsView, TooltipsMediator);
    }
}
}
