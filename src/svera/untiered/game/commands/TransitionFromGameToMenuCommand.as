package svera.untiered.game.commands {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.InvalidateDataSignal;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.death.model.DeathModel;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.fame.control.ShowFameViewSignal;
import svera.untiered.fame.model.FameVO;
import svera.untiered.fame.model.SimpleFameVO;
import svera.untiered.messaging.impl.incoming.Death;

public class TransitionFromGameToMenuCommand {


    [Inject]
    public var player:PlayerModel;

    [Inject]
    public var model:DeathModel;

    [Inject]
    public var invalidate:InvalidateDataSignal;

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var showFameView:ShowFameViewSignal;

    [Inject]
    public var closeDialogsSignal:CloseDialogsSignal;

    public function TransitionFromGameToMenuCommand() {
        super();
    }

    public function execute():void {
        this.invalidate.dispatch();
        closeDialogsSignal.dispatch();
        if (this.model.getIsDeathViewPending()) {
            this.showDeathView();
        } else {
            this.showCurrentCharacterScreen();
        }
    }

    private function showDeathView():void {
        var death:Death = this.model.getLastDeath();
        var fameVO:FameVO = new SimpleFameVO(this.player.getAccountId(), death.charId_);
        this.showFameView.dispatch(fameVO);
    }

    private function showCurrentCharacterScreen():void {
        this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
    }
}
}
