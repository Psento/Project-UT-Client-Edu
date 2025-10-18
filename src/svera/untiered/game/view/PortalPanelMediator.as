package svera.untiered.game.view {
import com.company.assembleegameclient.ui.panels.PortalPanel;

import svera.lib.framework.Mediator;

import svera.untiered.game.signals.ExitGameSignal;

public class PortalPanelMediator extends Mediator {


    [Inject]
    public var view:PortalPanel;

    [Inject]
    public var exitGameSignal:ExitGameSignal;

    public function PortalPanelMediator() {
        super();
    }

    override public function initialize():void {
        this.view.exitGameSignal.add(this.onExitGame);
    }

    private function onExitGame():void {
        this.exitGameSignal.dispatch();
    }

    override public function destroy():void {
        this.view.exitGameSignal.remove(this.onExitGame);
    }
}
}
