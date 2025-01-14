package svera.untiered.ui.view
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.TradePanel;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.util.SpriteUtil;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import svera.untiered.game.view.components.StatsView;
import svera.untiered.hud.HUD_Overlay;
import svera.untiered.messaging.impl.incoming.TradeAccepted;
import svera.untiered.messaging.impl.incoming.TradeChanged;
import svera.untiered.messaging.impl.incoming.TradeStart;
import svera.untiered.minimap.view.MiniMap;

public class HUDView extends Sprite
{

   private const MAP_POSITION:Point = new Point(204,4);

   private const INTERACT_PANEL_POSITION:Point = new Point(0,500);

   private var hudOverlay:HUD_Overlay;

   private var miniMap:MiniMap;

   public var equippedGrid:EquippedGrid;

   public var inventoryGrid:InventoryGrid;

   private var statMeters:StatMetersView;

   public var statsView:StatsView;

   private var characterDetails:CharacterDetailsView;

   public var interactPanel:InteractPanel;

   public var tradePanel:TradePanel;

   public static var instance:HUDView;


   public function HUDView()
   {
      super();
      instance = this;
      this.createAssets();
      this.addAssets();
      this.positionAssets();
   }

   private function createAssets() : void
   {
      this.hudOverlay = new HUD_Overlay();
      this.miniMap = new MiniMap(192,192);
      this.characterDetails = new CharacterDetailsView();
      this.statMeters = new StatMetersView();
   }

   private function addAssets() : void
   {
      addChild(this.hudOverlay);
      addChild(this.miniMap);
      addChild(this.characterDetails);
      addChild(this.statMeters);
   }

   private function positionAssets() : void
   {
      hudOverlay.parent.mouseEnabled = false;
      this.hudOverlay.x = 0 - (this.hudOverlay.width / 2);
      this.hudOverlay.y = 0;
      this.miniMap.x = this.MAP_POSITION.x;
      this.miniMap.y = this.MAP_POSITION.y;
      this.characterDetails.x -= 211;
      this.characterDetails.y = 504;
      this.statMeters.x -= 176 / 2;
      this.statMeters.y = 593 - this.statMeters.height;
   }

   public function setPlayerDependentAssets(gs:GameSprite) : void
   {
      var player:Player = gs.map.player_;
      this.inventoryGrid = new InventoryGrid(player,player,4);
      this.equippedGrid = new EquippedGrid(player,player.slotTypes_,player);
      this.statsView = new StatsView(191,45);
      this.interactPanel = new InteractPanel(gs,player,200,100);

      this.inventoryGrid.x = 0 + this.equippedGrid.width * 3;
      this.inventoryGrid.y = stage.stageHeight / 2 - this.inventoryGrid.height / 2;
      this.inventoryGrid.visible = false;

      this.equippedGrid.x = 0 - this.equippedGrid.width * 4;
      this.equippedGrid.y = this.inventoryGrid.y;
      this.equippedGrid.visible = false;

      this.statsView.x = this.equippedGrid.x - this.equippedGrid.width - (this.statsView.width);
      this.statsView.y = this.inventoryGrid.y;
      this.statsView.visible = false;

      this.interactPanel.x = this.INTERACT_PANEL_POSITION.x;
      this.interactPanel.y = this.INTERACT_PANEL_POSITION.y;

      addChild(this.inventoryGrid);
      addChild(this.equippedGrid);
      addChild(this.statsView);
      addChild(this.interactPanel);
   }

   public function draw() : void
   {
      if(this.equippedGrid)
      {
         this.equippedGrid.draw();
      }
      if(this.interactPanel)
      {
         this.interactPanel.draw();
      }
   }

   public function startTrade(gs:GameSprite, tradeStart:TradeStart) : void
   {
      if(this.tradePanel != null)
      {
         return;
      }
      this.tradePanel = new TradePanel(gs,tradeStart);
      this.tradePanel.y = 200;
      this.tradePanel.addEventListener(Event.CANCEL,this.onTradeCancel);
      addChild(this.tradePanel);
      this.characterDetails.visible = false;
      this.statMeters.visible = false;
      this.interactPanel.visible = false;
   }

   public function tradeChanged(tradeChanged:TradeChanged) : void
   {
      if(this.tradePanel == null)
      {
         return;
      }
      this.tradePanel.setYourOffer(tradeChanged.offer_);
   }

   public function tradeAccepted(tradeAccepted:TradeAccepted) : void
   {
      if(this.tradePanel == null)
      {
         return;
      }
      this.tradePanel.youAccepted(tradeAccepted.myOffer_,tradeAccepted.yourOffer_);
   }

   private function onTradeCancel(event:Event) : void
   {
      this.removeTradePanel();
   }

   public function tradeDone() : void
   {
      this.removeTradePanel();
   }

   private function removeTradePanel() : void
   {
      if(this.tradePanel != null)
      {
         this.tradePanel.removeEventListener(Event.CANCEL,this.onTradeCancel);
         SpriteUtil.safeRemoveChild(this,this.tradePanel);
         this.tradePanel = null;
         this.characterDetails.visible = true;
         this.statMeters.visible = true;
         this.interactPanel.visible = true;
      }
   }

   private function OpenInventory():void
   {
      this.statsView.visible = true;
      this.inventoryGrid.visible = true;
      this.equippedGrid.visible = true;
   }
   private function CloseInventory():void
   {
      this.statsView.visible = false;
      this.inventoryGrid.visible = false;
      this.equippedGrid.visible = false;
   }
   public function ToggleInventory():void
   {
      if(this.inventoryGrid.visible)
      {
         this.CloseInventory();
      } else this.OpenInventory();
   }
}
}
