package svera.untiered.account.core {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import svera.lib.tasks.BranchingTask;
import svera.lib.tasks.DispatchSignalTask;
import svera.lib.tasks.Task;
import svera.lib.tasks.TaskMonitor;
import svera.lib.tasks.TaskSequence;
import svera.untiered.account.core.services.BuyCharacterSlotTask;
import svera.untiered.account.core.view.BuyingDialog;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.ui.view.MessageCloseDialog;

public class BuyCharacterSlotCommand {


    [Inject]
    public var price:int;

    [Inject]
    public var task:BuyCharacterSlotTask;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var openDialog:OpenDialogSignal;

    [Inject]
    public var closeDialog:CloseDialogsSignal;

    [Inject]
    public var model:PlayerModel;

    [Inject]
    public var account:Account;

    public function BuyCharacterSlotCommand() {
        super();
    }

    public function execute():void {
        if (this.isSlotUnaffordable()) {
            this.nonSufficientFunds();
        } else {
            this.purchaseSlot();
        }
    }

    private function isSlotUnaffordable():Boolean {
        return this.model.getHonor() < Parameters.CHARACTER_SLOT_PRICE;
    }

    private function nonSufficientFunds():void {
        this.openDialog.dispatch(
                new MessageCloseDialog("Not Enough Honor",
                        "Insufficient funds when trying to buy a slot.", "Close"));
    }

    private function purchaseSlot():void {
        this.openDialog.dispatch(new BuyingDialog());
        var sequence:TaskSequence = new TaskSequence();
        sequence.add(new BranchingTask(this.task, this.makeSuccessTask(), this.makeFailureTask()));
        sequence.add(new DispatchSignalTask(this.closeDialog));
        this.monitor.add(sequence);
        sequence.start();
    }

    private function makeSuccessTask():Task {
        var task:TaskSequence = new TaskSequence();
        task.add(new DispatchSignalTask(this.setScreen, new CharacterSelectionAndNewsScreen()));
        return task;
    }

    private function makeFailureTask():Task {
        return new DispatchSignalTask(this.openDialog, new ErrorDialog("Unable to complete character slot purchase"));
    }
}
}
