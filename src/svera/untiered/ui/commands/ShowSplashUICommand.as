package svera.untiered.ui.commands {
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.ui.view.SplashView;

public class ShowSplashUICommand {
    [Inject]
    public var setScreen:SetScreenSignal;

    public function ShowSplashUICommand() {
        super();
    }

    public function execute():void {
        this.setScreen.dispatch(new SplashView());
    }
}
}