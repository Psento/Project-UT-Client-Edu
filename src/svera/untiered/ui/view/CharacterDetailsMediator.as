package svera.untiered.ui.view {
import com.company.assembleegameclient.objects.Player;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.ui.model.HUDModel;
import svera.untiered.ui.signals.HUDModelInitialized;
import svera.untiered.ui.signals.NameChangedSignal;
import svera.untiered.ui.signals.UpdateHUDSignal;

public class CharacterDetailsMediator extends Mediator {


    [Inject]
    public var view:CharacterDetailsView;

    [Inject]
    public var hudModel:HUDModel;

    [Inject]
    public var initHUDModelSignal:HUDModelInitialized;

    [Inject]
    public var updateHUD:UpdateHUDSignal;

    [Inject]
    public var nameChanged:NameChangedSignal;

    public function CharacterDetailsMediator() {
        super();
    }

    override public function initialize():void {
        this.view.init();
        this.updateHUD.addOnce(this.onUpdateHUD);
        this.updateHUD.add(this.onDraw);
        this.nameChanged.add(this.onNameChange);
    }

    override public function destroy():void {
        this.updateHUD.remove(this.onDraw);
        this.nameChanged.remove(this.onNameChange);
    }

    private function onUpdateHUD(player:Player):void {
        this.view.update(player);
    }

    private function onDraw(player:Player):void {
        this.view.draw(player);
    }

    private function onNameChange(name:String):void {
        this.view.setName(name);
    }
}
}
