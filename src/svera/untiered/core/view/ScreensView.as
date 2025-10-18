package svera.untiered.core.view {
import flash.display.Sprite;

import svera.lib.framework.MediatorFactory;

public class ScreensView extends Sprite {
    private var current:Sprite;

    private var previous:Sprite;

    private var mediatorFactory:MediatorFactory;

    public function ScreensView() {
        super();
    }

    public function setMediatorFactory(factory:MediatorFactory):void {
        this.mediatorFactory = factory;
    }

    public function setScreen(sprite:Sprite):void {
        if (this.current == sprite) {
            return;
        }
        this.removePrevious();
        this.current = sprite;
        addChild(sprite);

        if (this.mediatorFactory) {
            this.mediatorFactory.create(sprite);
        }
    }

    private function removePrevious():void {
        if (this.current && contains(this.current)) {
            this.previous = this.current;
            removeChild(this.current);
        }
    }

    public function getPrevious():Sprite {
        return this.previous;
    }
}
}
