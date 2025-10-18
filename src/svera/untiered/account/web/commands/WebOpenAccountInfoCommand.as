package svera.untiered.account.web.commands {
import svera.lib.framework.ICommand;
import svera.untiered.account.core.Account;
import svera.untiered.account.web.view.WebAccountDetailDialog;
import svera.untiered.account.web.view.WebRegisterDialog;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class WebOpenAccountInfoCommand implements ICommand {


    [Inject]
    public var account:Account;

    [Inject]
    public var openDialog:OpenDialogSignal;

    public function WebOpenAccountInfoCommand() {
        super();
    }

    public function execute():void {
        if (this.account.isRegistered()) {
            this.openDialog.dispatch(new WebAccountDetailDialog());
        } else {
            this.openDialog.dispatch(new WebRegisterDialog());
        }
    }
}
}
