package svera.untiered.account.web.commands {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import flash.display.Sprite;

import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.lib.tasks.TaskMonitor;
import svera.lib.tasks.TaskSequence;
import svera.untiered.account.core.services.LoginTask;
import svera.untiered.account.core.signals.UpdateAccountInfoSignal;
import svera.untiered.account.web.model.AccountData;
import svera.untiered.account.web.view.WebAccountDetailDialog;
import svera.untiered.core.model.ScreenModel;
import svera.untiered.core.signals.InvalidateDataSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class WebLoginCommand {


    [Inject]
    public var data:AccountData;

    [Inject]
    public var task:LoginTask;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var openDialog:OpenDialogSignal;

    [Inject]
    public var loginError:TaskErrorSignal;

    [Inject]
    public var updateLogin:UpdateAccountInfoSignal;

    [Inject]
    public var invalidate:InvalidateDataSignal;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var screenModel:ScreenModel;

    public function WebLoginCommand() {
        super();
    }

    public function execute():void {
        var branch:BranchingTask = new BranchingTask(this.task, this.makeSuccessTask(), this.makeFailureTask());
        this.monitor.add(branch);
        branch.start();
    }

    private function makeSuccessTask():TaskSequence {
        var sequence:TaskSequence = new TaskSequence();
        sequence.add(new DispatchSignalTask(this.openDialog, new WebAccountDetailDialog()));
        sequence.add(new DispatchSignalTask(this.updateLogin));
        sequence.add(new DispatchSignalTask(this.invalidate));
        sequence.add(new DispatchSignalTask(this.setScreenWithValidData, this.getTargetScreen()));
        return sequence;
    }

    private function makeFailureTask():Task {
        return new DispatchSignalTask(this.loginError, this.task);
    }

    private function getTargetScreen():Sprite {
        var type:Class = this.screenModel.currentType;
        if (type == null || type == GameSprite) {
            type = CharacterSelectionAndNewsScreen;
        }
        return new type();
    }
}
}
