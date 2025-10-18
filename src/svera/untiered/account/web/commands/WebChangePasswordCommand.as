package svera.untiered.account.web.commands {
import svera.lib.framework.ICommand;
import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.lib.tasks.TaskMonitor;
import svera.lib.tasks.TaskSequence;
import svera.untiered.account.core.services.ChangePasswordTask;
import svera.untiered.account.web.view.WebAccountDetailDialog;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class WebChangePasswordCommand implements ICommand {


    [Inject]
    public var task:ChangePasswordTask;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var close:CloseDialogsSignal;

    [Inject]
    public var openDialog:OpenDialogSignal;

    [Inject]
    public var loginError:TaskErrorSignal;

    public function WebChangePasswordCommand() {
        super();
    }

    public function execute():void {
        var branch:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
        this.monitor.add(branch);
        branch.start();
    }

    private function makeSuccess():Task {
        var sequence:TaskSequence = new TaskSequence();
        sequence.add(new DispatchSignalTask(this.openDialog, new WebAccountDetailDialog()));
        return sequence;
    }

    private function makeFailure():Task {
        return new DispatchSignalTask(this.loginError, this.task);
    }
}
}
