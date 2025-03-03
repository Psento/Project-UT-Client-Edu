package svera.lib.resizing {
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

import svera.lib.resizing.signals.Resize;
import svera.lib.resizing.view.Resizable;
import svera.lib.resizing.view.ResizableMediator;

public class ResizeConfig {


    [Inject]
    public var injector:Injector;

    [Inject]
    public var mediatorMap:IMediatorMap;

    public function ResizeConfig() {
        super();
    }

    [PostConstruct]
    public function setup():void {
        this.injector.map(Resize).asSingleton();
        this.mediatorMap.map(Resizable).toMediator(ResizableMediator);
    }
}
}
