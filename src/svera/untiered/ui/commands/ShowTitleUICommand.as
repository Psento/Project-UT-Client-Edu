package svera.untiered.ui.commands {
import svera.lib.framework.ICommand;
import svera.untiered.account.core.signals.UpdateAccountInfoSignal;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.ui.view.TitleView;

public class ShowTitleUICommand implements ICommand {
    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var updateAccount:UpdateAccountInfoSignal;

    public function ShowTitleUICommand() {
        super();
    }

    public function execute():void {
        this.setScreen.dispatch(new TitleView());
        this.updateAccount.dispatch();
    }
}
}
