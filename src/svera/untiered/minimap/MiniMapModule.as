package svera.untiered.minimap {
import org.swiftsuspenders.Injector;

import svera.lib.framework.IModule;
import svera.lib.framework.AppContext;

import svera.untiered.minimap.control.MiniMapZoomSignal;
import svera.untiered.minimap.control.SetMiniMapMapSignal;
import svera.untiered.minimap.control.UpdateGameObjectTileSignal;
import svera.untiered.minimap.control.UpdateGroundTileSignal;
import svera.untiered.minimap.view.MiniMap;
import svera.untiered.minimap.view.MiniMapMediator;

public class MiniMapModule implements IModule {

    public function MiniMapModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(MiniMapZoomSignal).asSingleton();
        context.injector.map(SetMiniMapMapSignal).asSingleton();
        context.injector.map(UpdateGameObjectTileSignal).asSingleton();
        context.injector.map(UpdateGroundTileSignal).asSingleton();
        context.mediators.map(MiniMap, MiniMapMediator);
    }
}
}
