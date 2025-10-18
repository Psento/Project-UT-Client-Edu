package svera.untiered.game {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.MapMediator;
import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
import com.company.assembleegameclient.ui.TextBox;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.PortalPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.ui.panels.mediators.InteractPanelMediator;
import com.company.assembleegameclient.ui.panels.mediators.InventoryGridMediator;
import com.company.assembleegameclient.ui.panels.mediators.ItemGridMediator;

import org.swiftsuspenders.Injector;

import svera.lib.framework.IModule;
import svera.lib.framework.AppContext;

import svera.untiered.game.commands.PlayGameCommand;
import svera.untiered.game.commands.TransitionFromGameToMenuCommand;
import svera.untiered.game.commands.UsePotionCommand;
import svera.untiered.game.focus.GameFocusModule;
import svera.untiered.game.model.ChatFilter;
import svera.untiered.game.model.GameModel;
import svera.untiered.game.signals.AddSpeechBalloonSignal;
import svera.untiered.game.signals.AddTextLineSignal;
import svera.untiered.game.signals.DisconnectGameSignal;
import svera.untiered.game.signals.ExitGameSignal;
import svera.untiered.game.signals.GameClosedSignal;
import svera.untiered.game.signals.PlayGameSignal;
import svera.untiered.game.signals.SetTextBoxVisibilitySignal;
import svera.untiered.game.signals.SetWorldInteractionSignal;
import svera.untiered.game.signals.ShowChatInputSignal;
import svera.untiered.game.signals.UsePotionSignal;
import svera.untiered.game.view.CurrencyDisplay;
import svera.untiered.game.view.CurrencyDisplayMediator;
import svera.untiered.game.view.GameSpriteMediator;
import svera.untiered.game.view.LootboxMediator;
import svera.untiered.game.view.LootboxModalButton;
import svera.untiered.game.view.MapOverlayMediator;
import svera.untiered.game.view.PortalPanelMediator;
import svera.untiered.game.view.SellableObjectPanel;
import svera.untiered.game.view.SellableObjectPanelMediator;
import svera.untiered.game.view.TextBoxMediator;
import svera.untiered.game.view.components.StatMediator;
import svera.untiered.game.view.components.StatView;
import svera.untiered.game.view.components.StatsMediator;
import svera.untiered.game.view.components.StatsView;
import svera.untiered.lootBoxes.LootboxModal;
import svera.untiered.lootBoxes.LootboxModalMediator;

public class GameModule implements IModule {

    public function GameModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.install(new GameFocusModule());
        context.injector.map(GameModel).asSingleton();
        context.injector.map(SetWorldInteractionSignal).asSingleton();
        context.injector.map(AddTextLineSignal).asSingleton();
        context.injector.map(SetTextBoxVisibilitySignal).asSingleton();
        context.injector.map(AddSpeechBalloonSignal).asSingleton();
        context.injector.map(ChatFilter).asSingleton();
        context.injector.map(DisconnectGameSignal).asSingleton();
        context.injector.map(ExitGameSignal).asSingleton();
        context.injector.map(ShowChatInputSignal).asSingleton();
        context.mediators.map(GameSprite, GameSpriteMediator);
        context.mediators.map(CurrencyDisplay, CurrencyDisplayMediator);
        context.mediators.map(SellableObjectPanel, SellableObjectPanelMediator);
        context.mediators.map(LootboxModalButton, LootboxMediator);
        context.mediators.map(PortalPanel, PortalPanelMediator);
        context.mediators.map(InteractPanel, InteractPanelMediator);
        context.mediators.map(ItemGrid, ItemGridMediator);
        context.mediators.map(InventoryGrid, InventoryGridMediator);
        context.mediators.map(TextBox, TextBoxMediator);
        context.mediators.map(MapOverlay, MapOverlayMediator);
        context.mediators.map(Map, MapMediator);
        context.mediators.map(LootboxModal, LootboxModalMediator);
        context.mediators.map(StatView, StatMediator);
        context.mediators.map(StatsView, StatsMediator);
        context.commands.map(UsePotionSignal).toCommand(UsePotionCommand);
        context.commands.map(GameClosedSignal).toCommand(TransitionFromGameToMenuCommand);
        context.commands.map(PlayGameSignal).toCommand(PlayGameCommand);
    }
}
}
