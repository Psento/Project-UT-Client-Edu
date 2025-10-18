package svera.untiered.account.web.commands {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import flash.display.Sprite;

import svera.lib.framework.ICommand;

import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.lib.tasks.TaskMonitor;
import svera.lib.tasks.TaskSequence;
import svera.untiered.account.core.services.RegisterAccountTask;
import svera.untiered.account.core.signals.UpdateAccountInfoSignal;
import svera.untiered.account.web.view.WebAccountDetailDialog;
import svera.untiered.core.model.ScreenModel;
import svera.untiered.core.signals.InvalidateDataSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.core.signals.TaskErrorSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class WebRegisterAccountCommand implements ICommand {


    [Inject]
    public var task:RegisterAccountTask;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var taskError:TaskErrorSignal;

    [Inject]
    public var updateAccount:UpdateAccountInfoSignal;

    [Inject]
    public var openDialog:OpenDialogSignal;

    [Inject]
    public var invalidate:InvalidateDataSignal;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var screenModel:ScreenModel;

    public function WebRegisterAccountCommand() {
        super();
    }

    public function execute():void {
        var branch:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
        this.monitor.add(branch);
        branch.start();
    }

    private function makeSuccess():Task {
        var sequence:TaskSequence = new TaskSequence();
        sequence.add(new DispatchSignalTask(this.updateAccount));
        sequence.add(new DispatchSignalTask(this.openDialog, new WebAccountDetailDialog()));
        sequence.add(new DispatchSignalTask(this.invalidate));
        sequence.add(new DispatchSignalTask(this.setScreenWithValidData, this.getTargetScreen()));
        return sequence;
    }

    private function makeFailure():DispatchSignalTask {
        return new DispatchSignalTask(this.taskError, this.task);
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
