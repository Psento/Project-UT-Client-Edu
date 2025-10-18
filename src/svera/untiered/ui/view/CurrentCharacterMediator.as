package svera.untiered.ui.view {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;

import svera.lib.framework.Mediator;

import svera.untiered.classes.model.CharacterClass;
import svera.untiered.classes.model.ClassesModel;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.game.model.GameInitData;
import svera.untiered.game.signals.PlayGameSignal;
import svera.untiered.ui.signals.NameChangedSignal;

public class CurrentCharacterMediator extends Mediator {

    [Inject]
    public var playerModel:PlayerModel;

    [Inject]
    public var classesModel:ClassesModel;

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var playGame:PlayGameSignal;

    [Inject]
    public var nameChanged:NameChangedSignal;

    private function getCharacterSelectionAndNewsScreen():CharacterSelectionAndNewsScreen {
        return view as CharacterSelectionAndNewsScreen;
    }

    override public function initialize():void {
        this.getCharacterSelectionAndNewsScreen.close.add(this.onClose);
        this.getCharacterSelectionAndNewsScreen.newCharacter.add(this.onNewCharacter);
        this.getCharacterSelectionAndNewsScreen.showClasses.add(this.onNewCharacter);
        this.getCharacterSelectionAndNewsScreen.playGame.add(this.onPlayGame);
        this.getCharacterSelectionAndNewsScreen.initialize(this.playerModel);
        this.nameChanged.add(this.onNameChanged);
    }

    override public function destroy():void {
        this.nameChanged.remove(this.onNameChanged);
        this.getCharacterSelectionAndNewsScreen.close.remove(this.onClose);
        this.getCharacterSelectionAndNewsScreen.newCharacter.remove(this.onNewCharacter);
        this.getCharacterSelectionAndNewsScreen.showClasses.remove(this.onNewCharacter);
        this.getCharacterSelectionAndNewsScreen.playGame.remove(this.onPlayGame);
    }

    private function onNameChanged(name:String):void {
        this.getCharacterSelectionAndNewsScreen.setName(name);
    }

    private function onNewCharacter():void {
        this.setScreen.dispatch(new NewCharacterScreen());
    }

    private function onClose():void {
        this.setScreen.dispatch(new TitleView());
    }

    private function onPlayGame():void {
        var character:SavedCharacter = this.playerModel.getCharacterByIndex(0);
        this.playerModel.currentCharId = character.charId();
        var characterClass:CharacterClass = this.classesModel.getCharacterClass(character.objectType());
        characterClass.setIsSelected(true);
        characterClass.skins.getSkin(character.skinType()).setIsSelected(true);
        var game:GameInitData = new GameInitData();
        game.createCharacter = false;
        game.charId = character.charId();
        game.isNewGame = true;
        this.playGame.dispatch(game);
    }
}
}
