package svera.untiered.game
{
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

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

import svera.untiered.game.commands.PlayGameCommand;
import svera.untiered.game.commands.TransitionFromGameToMenuCommand;
import svera.untiered.game.commands.UsePotionCommand;
import svera.untiered.game.focus.GameFocusConfig;
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
import svera.untiered.game.view.MapOverlayMediator;
import svera.untiered.game.view.PortalPanelMediator;
import svera.untiered.game.view.SellableObjectPanel;
import svera.untiered.game.view.SellableObjectPanelMediator;
import svera.untiered.game.view.TextBoxMediator;
import svera.untiered.game.view.components.StatMediator;
import svera.untiered.game.view.components.StatView;
import svera.untiered.game.view.components.StatsMediator;
import svera.untiered.game.view.components.StatsView;

public class GameConfig implements IConfig
   {
       
      
      [Inject]
      public var context:IContext;
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      public function GameConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.context.configure(GameFocusConfig);
         this.injector.map(GameModel).asSingleton();
         this.generalGameConfiguration();
      }
      
      private function generalGameConfiguration() : void
      {
         this.injector.map(SetWorldInteractionSignal).asSingleton();
         this.injector.map(AddTextLineSignal).asSingleton();
         this.injector.map(SetTextBoxVisibilitySignal).asSingleton();
         this.injector.map(AddSpeechBalloonSignal).asSingleton();
         this.injector.map(ChatFilter).asSingleton();
         this.injector.map(DisconnectGameSignal).asSingleton();
         this.injector.map(ExitGameSignal).asSingleton();
         this.injector.map(ShowChatInputSignal).asSingleton();
         this.makeStatusDisplayMappings();
         this.mediatorMap.map(PortalPanel).toMediator(PortalPanelMediator);
         this.mediatorMap.map(InteractPanel).toMediator(InteractPanelMediator);
         this.mediatorMap.map(ItemGrid).toMediator(ItemGridMediator);
         this.mediatorMap.map(InventoryGrid).toMediator(InventoryGridMediator);
         this.mediatorMap.map(TextBox).toMediator(TextBoxMediator);
         this.mediatorMap.map(MapOverlay).toMediator(MapOverlayMediator);
         this.mediatorMap.map(Map).toMediator(MapMediator);
         this.mediatorMap.map(StatView).toMediator(StatMediator);
         this.mediatorMap.map(StatsView).toMediator(StatsMediator);
         this.commandMap.map(UsePotionSignal).toCommand(UsePotionCommand);
         this.commandMap.map(GameClosedSignal).toCommand(TransitionFromGameToMenuCommand);
         this.commandMap.map(PlayGameSignal).toCommand(PlayGameCommand);
      }

      private function makeStatusDisplayMappings() : void
      {
         this.mediatorMap.map(GameSprite).toMediator(GameSpriteMediator);
         this.mediatorMap.map(CurrencyDisplay).toMediator(CurrencyDisplayMediator);
         this.mediatorMap.map(SellableObjectPanel).toMediator(SellableObjectPanelMediator);
      }
   }
}
