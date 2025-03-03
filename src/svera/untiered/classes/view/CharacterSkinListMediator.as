package svera.untiered.classes.view {
import flash.display.DisplayObject;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.classes.model.CharacterClass;
import svera.untiered.classes.model.ClassesModel;

public class CharacterSkinListMediator extends Mediator {
    [Inject]
    public var view:CharacterSkinListView;

    [Inject]
    public var model:ClassesModel;

    [Inject]
    public var factory:CharacterSkinListItemFactory;

    public function CharacterSkinListMediator() {
        super();
    }

    override public function initialize():void {
        this.model.selected.add(this.setSkins);
        this.setSkins(this.model.getSelected());
    }

    override public function destroy():void {
        this.model.selected.remove(this.setSkins);
    }

    private function setSkins(charClass:CharacterClass):void {
        var items:Vector.<DisplayObject> = this.factory.make(charClass.skins);
        this.view.setItems(items);
    }
}
}
