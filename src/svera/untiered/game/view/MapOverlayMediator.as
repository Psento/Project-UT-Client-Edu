package svera.untiered.game.view {
import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
import com.company.assembleegameclient.map.mapoverlay.SpeechBalloon;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.game.model.AddSpeechBalloonVO;
import svera.untiered.game.model.ChatFilter;
import svera.untiered.game.signals.AddSpeechBalloonSignal;

public class MapOverlayMediator extends Mediator {


    [Inject]
    public var view:MapOverlay;

    [Inject]
    public var addSpeechBalloon:AddSpeechBalloonSignal;

    [Inject]
    public var chatFilter:ChatFilter;

    [Inject]
    public var account:Account;

    public function MapOverlayMediator() {
        super();
    }

    override public function initialize():void {
        this.addSpeechBalloon.add(this.onAddSpeechBalloon);
    }

    override public function destroy():void {
        this.addSpeechBalloon.remove(this.onAddSpeechBalloon);
    }

    private function onAddSpeechBalloon(vo:AddSpeechBalloonVO):void {
        var text:String = this.account.isRegistered() || this.chatFilter.guestChatFilter(vo.go.name_) ? vo.text : ". . .";
        this.view.addSpeechBalloon(new SpeechBalloon(vo.go, text, vo.background, vo.backgroundAlpha, vo.outline, vo.outlineAlpha, vo.textColor, vo.lifetime, vo.bold, vo.hideable));
    }
}
}
