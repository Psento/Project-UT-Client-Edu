package svera.untiered.appengine {
import org.swiftsuspenders.Injector;

import svera.lib.framework.IModule;
import svera.lib.framework.AppContext;

import svera.untiered.appengine.api.AppEngineClient;
import svera.untiered.appengine.api.RetryLoader;
import svera.untiered.appengine.impl.AppEngineRetryLoader;
import svera.untiered.appengine.impl.SimpleAppEngineClient;

public class AppEngineModule implements IModule {

    public function AppEngineModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(RetryLoader).toType(AppEngineRetryLoader);
        context.injector.map(AppEngineClient).toType(SimpleAppEngineClient);
    }
}
}
