package svera.untiered.account.web.commands {
import svera.lib.framework.ICommand;
import svera.untiered.account.core.Account;
import svera.untiered.account.web.view.WebQuitDialog;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class WebOpenQuitDialogCommand implements ICommand {


    [Inject]
    public var account:Account;

    [Inject]
    public var openDialog:OpenDialogSignal;

    public function WebOpenQuitDialogCommand() {
        super();
    }

    public function execute():void {
        this.openDialog.dispatch(new WebQuitDialog());
    }
}
}
