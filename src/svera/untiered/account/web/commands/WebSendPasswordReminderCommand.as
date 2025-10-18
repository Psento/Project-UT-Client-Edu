package svera.untiered.account.web.commands {
import svera.lib.framework.ICommand;
import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.TaskGroup;
import svera.lib.tasks.TaskMonitor;
import svera.untiered.account.core.services.SendPasswordReminderTask;
import svera.untiered.account.web.view.WebLoginDialog;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class WebSendPasswordReminderCommand implements ICommand {


    [Inject]
    public var email:String;

    [Inject]
    public var task:SendPasswordReminderTask;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var taskError:TaskErrorSignal;

    [Inject]
    public var openDialog:OpenDialogSignal;

    public function WebSendPasswordReminderCommand() {
        super();
    }

    public function execute():void {
        var success:TaskGroup = new TaskGroup();
        success.add(new DispatchSignalTask(this.openDialog, new WebLoginDialog()));
        var failure:TaskGroup = new TaskGroup();
        failure.add(new DispatchSignalTask(this.taskError, this.task));
        var branch:BranchingTask = new BranchingTask(this.task, success, failure);
        this.monitor.add(branch);
        branch.start();
    }
}
}
