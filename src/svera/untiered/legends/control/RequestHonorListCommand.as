package svera.untiered.legends.control {
import svera.lib.framework.ICommand;
import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.lib.tasks.TaskMonitor;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.death.model.DeathModel;
import svera.untiered.honor.model.HonorModel;
import svera.untiered.legends.service.GetLegendsListTask;

public class RequestHonorListCommand implements ICommand {


    [Inject]
    public var task:GetLegendsListTask;

    [Inject]
    public var update:HonorListUpdateSignal;

    [Inject]
    public var error:TaskErrorSignal;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var player:PlayerModel;

    [Inject]
    public var death:DeathModel;

    [Inject]
    public var model:HonorModel;

    public function RequestHonorListCommand() {
        super();
    }

    public function execute():void {
        this.task.charId = this.getCharId();
        var branch:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
        this.monitor.add(branch);
        branch.start();
    }

    private function getCharId():int {
        if (this.player.hasAccount() && this.death.getIsDeathViewPending()) {
            return this.death.getLastDeath().charId_;
        }
        return -1;
    }

    private function makeSuccess():Task {
        return new DispatchSignalTask(this.update);
    }

    private function makeFailure():Task {
        return new DispatchSignalTask(this.error, this.task);
    }
}
}
