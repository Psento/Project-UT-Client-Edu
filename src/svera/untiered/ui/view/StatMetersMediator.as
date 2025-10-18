package svera.untiered.ui.view {
import com.company.assembleegameclient.objects.Player;

import svera.lib.framework.Mediator;

import svera.untiered.ui.model.HUDModel;
import svera.untiered.ui.signals.UpdateHUDSignal;

public class StatMetersMediator extends Mediator {

    [Inject]
    public var hudModel:HUDModel;

    [Inject]
    public var updateHUD:UpdateHUDSignal;

    private function get getStatMetersView():StatMetersView {
        return view as StatMetersView;
    }

    override public function initialize():void {
        this.updateHUD.add(this.onUpdateHUD);
    }

    override public function destroy():void {
        this.updateHUD.add(this.onUpdateHUD);
    }

    private function onUpdateHUD(player:Player):void {
        this.getStatMetersView.update(player);
    }
}
}
