package svera.untiered.ui.view {
import svera.lib.framework.Mediator;

import svera.untiered.startup.control.StartupSequence;

public class SplashMediator extends Mediator {

    [Inject]
    public var startup:StartupSequence;

    private function get getSplashView():SplashView {
        return view as SplashView;
    }



    override public function initialize():void {
        this.getSplashView.fadeCompleted.add(this.onSplashComplete);
    }

    override public function destroy():void {
        this.getSplashView.fadeCompleted.remove(this.onSplashComplete);
        this.getSplashView.destroy();
    }

    private function onSplashComplete():void {
        // Start the main startup sequence after splash completes
        this.startup.start();
    }
}
}
