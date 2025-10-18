// FILE: src/svera/lib/resizing/ResizeModule.as
package svera.lib.resizing {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;
import svera.lib.framework.IModule;
import svera.lib.resizing.signals.Resize;
import svera.lib.resizing.view.Resizable;
import svera.lib.resizing.view.ResizableMediator;

public class ResizeModule implements IModule {

    public function configure(context:AppContext):void {
        var injector:Injector = context.injector;

        // Map signal
        injector.map(Resize).asSingleton();

        // Map mediator
        context.mediators.map(Resizable, ResizableMediator);
    }
}
}