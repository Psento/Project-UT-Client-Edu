package svera.untiered.ui.view {
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.startup.control.StartupSequence;

public class SplashMediator extends Mediator {
    [Inject]
    public var view:SplashView;

    [Inject]
    public var startup:StartupSequence;

    public function SplashMediator() {
        super();
        trace("SplashMediator: Constructor called");
    }

    override public function initialize():void {
        trace("SplashMediator: Initialize called");
        this.view.fadeCompleted.add(this.onSplashComplete);
        trace("SplashMediator: fadeCompleted listener added");
    }

    override public function destroy():void {
        trace("SplashMediator: Destroy called");
        this.view.fadeCompleted.remove(this.onSplashComplete);
        this.view.destroy();
    }

    private function onSplashComplete():void {
        trace("SplashMediator: Splash completed, starting main startup sequence");
        // Start the main startup sequence after splash completes
        this.startup.start();
        trace("SplashMediator: Startup sequence started");
    }
}
}
