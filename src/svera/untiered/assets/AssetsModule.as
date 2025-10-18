package svera.untiered.assets {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.untiered.assets.services.CharacterFactory;
import svera.untiered.assets.services.IconFactory;

public class AssetsModule implements IModule {

    public function AssetsModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(CharacterFactory).asSingleton();
        context.injector.map(IconFactory).asSingleton();
    }
}
}
