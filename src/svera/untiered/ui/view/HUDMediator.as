package svera.untiered.ui.view {
import com.company.assembleegameclient.objects.Player;

import svera.lib.framework.Mediator;

import svera.untiered.ui.model.HUDModel;
import svera.untiered.ui.signals.UpdateHUDSignal;

public class HUDMediator extends Mediator {

    [Inject]
    public var hudModel:HUDModel;

    [Inject]
    public var updateHUD:UpdateHUDSignal;

    private function getHUDView():HUDView {
        return view as HUDView;
    }

    override public function initialize():void {
        this.updateHUD.addOnce(this.onInitializeHUD);
        this.updateHUD.add(this.onUpdateHUD);
    }

    override public function destroy():void {
        this.updateHUD.remove(this.onUpdateHUD);
    }

    private function onUpdateHUD(player:Player):void {
        this.getHUDView.draw();
    }

    private function onInitializeHUD(player:Player):void {
        this.getHUDView.setPlayerDependentAssets(this.hudModel.gameSprite);
    }
}
}
