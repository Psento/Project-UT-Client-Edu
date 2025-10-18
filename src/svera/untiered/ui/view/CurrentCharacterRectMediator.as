package svera.untiered.ui.view {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.screens.charrects.CurrentCharacterRect;

import svera.lib.framework.Mediator;

import svera.untiered.characters.deletion.view.ConfirmDeleteCharacterDialog;
import svera.untiered.characters.model.CharacterModel;
import svera.untiered.classes.model.CharacterClass;
import svera.untiered.classes.model.ClassesModel;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.game.model.GameInitData;
import svera.untiered.game.signals.PlayGameSignal;

public class CurrentCharacterRectMediator extends Mediator {

    [Inject]
    public var playGame:PlayGameSignal;

    [Inject]
    public var model:CharacterModel;

    [Inject]
    public var classesModel:ClassesModel;

    [Inject]
    public var openDialog:OpenDialogSignal;

    private function getCurrentCharacterRect():CurrentCharacterRect {
        return view as CurrentCharacterRect;
    }

    override public function initialize():void {
        this.getCurrentCharacterRect.selected.add(this.onSelected);
        this.getCurrentCharacterRect.deleteCharacter.add(this.onDeleteCharacter);
    }

    override public function destroy():void {
        this.getCurrentCharacterRect.selected.remove(this.onSelected);
        this.getCurrentCharacterRect.deleteCharacter.remove(this.onDeleteCharacter);
    }

    private function onSelected(character:SavedCharacter):void {
        var characterClass:CharacterClass = this.classesModel.getCharacterClass(character.objectType());
        characterClass.setIsSelected(true);
        characterClass.skins.getSkin(character.skinType()).setIsSelected(true);
        this.launchGame(character);
    }

    private function launchGame(character:SavedCharacter):void {
        var data:GameInitData = new GameInitData();
        data.createCharacter = false;
        data.charId = character.charId();
        data.isNewGame = true;
        this.playGame.dispatch(data);
    }

    private function onDeleteCharacter(character:SavedCharacter):void {
        this.model.select(character);
        this.openDialog.dispatch(new ConfirmDeleteCharacterDialog());
    }
}
}
