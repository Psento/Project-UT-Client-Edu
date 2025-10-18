package svera.untiered.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.events.ReconnectEvent;
import com.company.assembleegameclient.objects.Player;

import svera.lib.framework.Mediator;

import svera.untiered.core.model.MapModel;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.InvalidateDataSignal;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.game.model.GameInitData;
import svera.untiered.game.signals.DisconnectGameSignal;
import svera.untiered.game.signals.GameClosedSignal;
import svera.untiered.game.signals.PlayGameSignal;
import svera.untiered.game.signals.SetWorldInteractionSignal;
import svera.untiered.ui.signals.HUDModelInitialized;
import svera.untiered.ui.signals.HUDSetupStarted;
import svera.untiered.ui.signals.UpdateHUDSignal;

public class GameSpriteMediator extends Mediator {

    [Inject]
    public var setWorldInteraction:SetWorldInteractionSignal;

    [Inject]
    public var invalidate:InvalidateDataSignal;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var playGame:PlayGameSignal;

    [Inject]
    public var playerModel:PlayerModel;

    [Inject]
    public var gameClosed:GameClosedSignal;

    [Inject]
    public var mapModel:MapModel;

    [Inject]
    public var closeDialogs:CloseDialogsSignal;

    [Inject]
    public var disconnect:DisconnectGameSignal;

    [Inject]
    public var hudSetupStarted:HUDSetupStarted;

    [Inject]
    public var updateHUDSignal:UpdateHUDSignal;

    [Inject]
    public var hudModelInitialized:HUDModelInitialized;

    // Type-safe view accessor
    private function get gameSprite():GameSprite {
        return view as GameSprite;
    }

    override protected function onInitialize():void {
        this.setWorldInteraction.add(this.onSetWorldInteraction);

        // Replace addViewListener with direct addEventListener
        gameSprite.addEventListener(ReconnectEvent.RECONNECT, this.onReconnect);

        gameSprite.modelInitialized.add(this.onGameSpriteModelInitialized);
        gameSprite.drawCharacterWindow.add(this.onStatusPanelDraw);
        this.hudModelInitialized.add(this.onHUDModelInitialized);
        this.disconnect.add(this.onDisconnect);
        gameSprite.closed.add(this.onClosed);
        gameSprite.mapModel = this.mapModel;
        gameSprite.connect();
    }

    override protected function onDestroy():void {
        this.setWorldInteraction.remove(this.onSetWorldInteraction);

        // Replace removeViewListener with direct removeEventListener
        gameSprite.removeEventListener(ReconnectEvent.RECONNECT, this.onReconnect);

        gameSprite.modelInitialized.remove(this.onGameSpriteModelInitialized);
        gameSprite.drawCharacterWindow.remove(this.onStatusPanelDraw);
        this.hudModelInitialized.remove(this.onHUDModelInitialized);
        this.disconnect.remove(this.onDisconnect);
        gameSprite.closed.remove(this.onClosed);
        gameSprite.disconnect();
    }

    private function onDisconnect():void {
        gameSprite.disconnect();
    }

    public function onSetWorldInteraction(value:Boolean):void {
        gameSprite.mui_.setEnablePlayerInput(value);
    }

    private function onClosed():void {
        this.closeDialogs.dispatch();
        this.gameClosed.dispatch();
    }

    private function onReconnect(event:ReconnectEvent):void {
        if (gameSprite.isEditor) {
            return;
        }
        var data:GameInitData = new GameInitData();
        data.gameId = event.gameId_;
        data.createCharacter = event.createCharacter_;
        data.charId = event.charId_;
        this.playGame.dispatch(data);
    }

    private function onGameSpriteModelInitialized():void {
        this.hudSetupStarted.dispatch(gameSprite);
    }

    private function onStatusPanelDraw(player:Player):void {
        this.updateHUDSignal.dispatch(player);
    }

    private function onHUDModelInitialized():void {
        gameSprite.hudModelInitialized();
    }
}
}