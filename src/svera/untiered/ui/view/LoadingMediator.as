package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.LoadingScreen;

import svera.lib.framework.Mediator;

import svera.untiered.core.signals.SetLoadingMessageSignal;

public class LoadingMediator extends Mediator {

    [Inject]
    public var setMessage:SetLoadingMessageSignal;

    private function get getLoadingScreen():LoadingScreen {
        return view as LoadingScreen;
    }

    override public function initialize():void {
        this.setMessage.add(this.onSetMessage);
        this.getLoadingScreen.setText("<p align=\"center\">Loading...</p>");
    }

    override public function destroy():void {
        this.setMessage.remove(this.onSetMessage);
    }

    private function onSetMessage(message:String):void {
        this.getLoadingScreen.setText(message);
    }
}
}
