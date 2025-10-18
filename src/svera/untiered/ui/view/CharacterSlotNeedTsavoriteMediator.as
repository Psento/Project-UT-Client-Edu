package svera.untiered.ui.view {
import com.company.assembleegameclient.parameters.Parameters;

import svera.lib.framework.Mediator;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class CharacterSlotNeedTsavoriteMediator extends Mediator {

    [Inject]
    public var closeDialog:CloseDialogsSignal;

    [Inject]
    public var model:PlayerModel;

    private function getCharacterSlotNeedTsavoriteDialog():CharacterSlotNeedTsavoriteDialog {
        return view as CharacterSlotNeedTsavoriteDialog;
    }

    override public function initialize():void {
        this.getCharacterSlotNeedTsavoriteDialog.cancel.add(this.onCancel);
        this.getCharacterSlotNeedTsavoriteDialog.setPrice(Parameters.CHARACTER_SLOT_PRICE);
    }

    override public function destroy():void {
        this.getCharacterSlotNeedTsavoriteDialog.cancel.remove(this.onCancel);
    }

    public function onCancel():void {
        this.closeDialog.dispatch();
    }
}
}
