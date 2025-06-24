package svera.untiered.game.commands {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.InvalidateDataSignal;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.death.model.DeathModel;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.honor.control.ShowHonorViewSignal;
import svera.untiered.honor.model.HonorVO;
import svera.untiered.honor.model.SimpleHonorVO;
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
    public var showHonorView:ShowHonorViewSignal;

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
        var honorVO:HonorVO = new SimpleHonorVO(this.player.getAccountId(), death.charId_);
        this.showHonorView.dispatch(honorVO);
    }

    private function showCurrentCharacterScreen():void {
        this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
    }
}
}
