package svera.untiered.startup.control {
import svera.lib.tasks.TaskMonitor;
import svera.untiered.ui.signals.ShowSplashUISignal;

public class StartupCommand {


    [Inject]
    public var startup:StartupSequence;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var showSplash:ShowSplashUISignal;

    public function StartupCommand() {
        super();
    }

    public function execute():void {
        trace("StartupCommand: Showing splash screen first");
        // Show splash first, which will trigger the main startup when complete
        this.showSplash.dispatch();
    }
}
}
