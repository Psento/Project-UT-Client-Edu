package svera.untiered.classes.view {
import svera.lib.framework.Mediator;

import svera.untiered.classes.control.BuyCharacterSkinSignal;
import svera.untiered.classes.control.FocusCharacterSkinSignal;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.ClassesModel;

public class CharacterSkinListItemMediator extends Mediator {
    [Inject]
    public var view:CharacterSkinListItem;

    [Inject]
    public var model:ClassesModel;

    [Inject]
    public var buyCharacterSkin:BuyCharacterSkinSignal;

    [Inject]
    public var focusCharacterSkin:FocusCharacterSkinSignal;

    public function CharacterSkinListItemMediator() {
        super();
    }

    override public function initialize():void {
        view.selected.add(this.onSelected);
    }

    override public function destroy():void {
        this.view.selected.remove(this.onSelected);
        this.view.setModel(null);
    }

    private function onSelected(isSelected:Boolean):void {
        this.view.getModel().setIsSelected(isSelected);
    }
}
}
