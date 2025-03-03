package svera.untiered.ui.commands {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import svera.untiered.account.core.Account;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.game.model.GameInitData;
import svera.untiered.game.signals.PlayGameSignal;

public class EnterGameCommand {
    [Inject]
    public var account:Account;

    [Inject]
    public var model:PlayerModel;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var playGame:PlayGameSignal;

    [Inject]
    public var openDialog:OpenDialogSignal;

    private const DEFAULT_CHARACTER:int = 782;

    public function EnterGameCommand() {
        super();
    }

    public function execute():void {
        this.showCurrentCharacterScreen();
    }

    private function showCurrentCharacterScreen():void {
        this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
    }

    private function launchGame():void {
        this.playGame.dispatch(this.makeGameInitData());
    }

    private function makeGameInitData():GameInitData {
        var data:GameInitData = new GameInitData();
        data.createCharacter = true;
        data.charId = this.model.getNextCharId();
        data.isNewGame = true;
        return data;
    }
}
}
