package svera.untiered.core.view {
import flash.display.Sprite;

import svera.lib.framework.Mediator;

import svera.untiered.core.model.ScreenModel;
import svera.untiered.core.signals.GotoPreviousScreenSignal;
import svera.untiered.core.signals.SetScreenSignal;

public class ScreensMediator extends Mediator {

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var model:ScreenModel;

    [Inject]
    public var gotoPrevious:GotoPreviousScreenSignal;

    private function get getScreensView():ScreensView {
        return view as ScreensView;
    }

    override public function initialize():void {
        this.setScreen.add(this.onSetScreen);
        this.gotoPrevious.add(this.onGotoPrevious);
    }

    override public function destroy():void {
        this.setScreen.remove(this.onSetScreen);
        this.gotoPrevious.add(this.onGotoPrevious);
    }

    private function onSetScreen(screen:Sprite):void {
        this.model.currentType = Object(screen).constructor as Class;
        this.getScreensView.setScreen(screen);
    }

    private function onGotoPrevious():void {
        this.getScreensView.setScreen(this.getScreensView.getPrevious());
    }
}
}
