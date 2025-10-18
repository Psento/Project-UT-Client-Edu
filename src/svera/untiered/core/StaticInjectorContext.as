package svera.untiered.core {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

public class StaticInjectorContext extends AppContext {

    public static var injector:Injector;


    public function StaticInjectorContext() {
        super();
        if (!StaticInjectorContext.injector) {
            StaticInjectorContext.injector = this.injector;
        }
    }

    public static function getInjector():Injector {
        return injector;
    }
}
}
