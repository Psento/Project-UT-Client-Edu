package svera.untiered.ui.commands {
import com.company.assembleegameclient.screens.AccountLoadingScreen;

import svera.lib.framework.ICommand;

import svera.untiered.core.signals.SetScreenSignal;

public class ShowLoadingUICommand implements ICommand {
    [Inject]
    public var setScreen:SetScreenSignal;

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
