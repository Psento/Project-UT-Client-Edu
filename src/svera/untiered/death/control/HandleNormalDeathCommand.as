package svera.untiered.death.control {
import robotlegs.bender.framework.api.ILogger;

import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.TaskMonitor;
import svera.lib.tasks.TaskSequence;
import svera.untiered.account.core.services.GetCharListTask;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.honor.control.ShowHonorViewSignal;
import svera.untiered.honor.model.HonorVO;
import svera.untiered.honor.model.SimpleHonorVO;
import svera.untiered.game.signals.DisconnectGameSignal;
import svera.untiered.messaging.impl.incoming.Death;

public class HandleNormalDeathCommand {


    [Inject]
    public var death:Death;

    [Inject]
    public var player:PlayerModel;

    [Inject]
    public var task:GetCharListTask;

    [Inject]
    public var showHonor:ShowHonorViewSignal;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var disconnect:DisconnectGameSignal;

    [Inject]
    public var logger:ILogger;

    private var honorVO:HonorVO;

    public function HandleNormalDeathCommand() {
        super();
    }

    public function execute():void {
        this.honorVO = new SimpleHonorVO(this.death.accountId_, this.death.charId_);
        this.gotoHonorView();
    }

    private function gotoHonorView():void {
        if (this.player.getAccountId() == -1) {
            this.gotoHonorViewOnceDataIsLoaded();
        } else {
            this.showHonor.dispatch(this.honorVO);
        }
    }

    private function gotoHonorViewOnceDataIsLoaded():void {
        var sequence:TaskSequence = new TaskSequence();
        sequence.add(this.task);
        sequence.add(new DispatchSignalTask(this.showHonor, this.honorVO));
        this.monitor.add(sequence);
        sequence.start();
    }
}
}
