package svera.untiered.ui.commands {
import com.company.assembleegameclient.screens.AccountLoadingScreen;

import robotlegs.bender.framework.api.ILogger;

import svera.untiered.core.signals.SetScreenSignal;

public class ShowLoadingUICommand {
    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var logger:ILogger;

    public function ShowLoadingUICommand() {
        super();
    }

    public function execute():void {
        this.showLoadingScreen();
    }

    private function showLoadingScreen():void {
        this.setScreen.dispatch(new AccountLoadingScreen());
    }
}
}
