package svera.untiered.ui.commands {
import svera.lib.framework.ICommand;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.ui.view.SplashView;

public class ShowSplashUICommand implements ICommand {
    [Inject]
    public var setScreen:SetScreenSignal;

    public function ShowSplashUICommand() {
        super();
    }

    public function execute():void {
        var splash:SplashView = new SplashView();
        this.setScreen.dispatch(splash);
    }
}
}