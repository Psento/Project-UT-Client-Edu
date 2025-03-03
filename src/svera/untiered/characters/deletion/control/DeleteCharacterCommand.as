package svera.untiered.characters.deletion.control {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.lib.tasks.TaskMonitor;
import svera.lib.tasks.TaskSequence;
import svera.untiered.characters.deletion.service.DeleteCharacterTask;
import svera.untiered.characters.deletion.view.DeletingCharacterView;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class DeleteCharacterCommand {


    [Inject]
    public var task:DeleteCharacterTask;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var openDialog:OpenDialogSignal;

    [Inject]
    public var closeDialogs:CloseDialogsSignal;

    [Inject]
    public var setScreen:SetScreenSignal;

    public function DeleteCharacterCommand() {
        super();
    }

    public function execute():void {
        var sequence:TaskSequence = new TaskSequence();
        sequence.add(new DispatchSignalTask(this.openDialog, new DeletingCharacterView()));
        sequence.add(new BranchingTask(this.task, this.onSuccess(), this.onFailure()));
        this.monitor.add(sequence);
        sequence.start();
    }

    private function onSuccess():Task {
        var sequence:TaskSequence = new TaskSequence();
        sequence.add(new DispatchSignalTask(this.setScreen, new CharacterSelectionAndNewsScreen()));
        sequence.add(new DispatchSignalTask(this.closeDialogs));
        return sequence;
    }

    private function onFailure():Task {
        return new DispatchSignalTask(this.openDialog, "Unable to delete character");
    }
}
}
