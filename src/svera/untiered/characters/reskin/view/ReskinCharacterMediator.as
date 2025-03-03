package svera.untiered.characters.reskin.view {
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.characters.reskin.control.ReskinCharacterSignal;
import svera.untiered.classes.model.CharacterSkins;
import svera.untiered.classes.model.ClassesModel;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class ReskinCharacterMediator extends Mediator {


    [Inject]
    public var view:ReskinCharacterView;

    [Inject]
    public var player:PlayerModel;

    [Inject]
    public var model:ClassesModel;

    [Inject]
    public var reskinCharacter:ReskinCharacterSignal;

    [Inject]
    public var closeDialogs:CloseDialogsSignal;

    private var skins:CharacterSkins;

    public function ReskinCharacterMediator() {
        super();
    }

    override public function initialize():void {
        this.skins = this.getCharacterSkins();
        this.view.selected.add(this.onSelected);
        this.view.cancelled.add(this.onCancelled);
    }

    private function getCharacterSkins():CharacterSkins {
        return this.model.getSelected().skins;
    }

    override public function destroy():void {
        this.view.selected.remove(this.onSelected);
        this.view.cancelled.remove(this.onCancelled);
    }

    private function onSelected():void {
        this.closeDialogs.dispatch();
        this.reskinCharacter.dispatch(this.skins.getSelectedSkin());
    }

    private function onCancelled():void {
        this.closeDialogs.dispatch();
    }
}
}
