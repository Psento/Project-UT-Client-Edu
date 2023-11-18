package svera.untiered.ui.view
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.TradePanel;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.util.GraphicsUtil;
import com.company.util.SpriteUtil;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import svera.untiered.game.view.components.TabStripView;
import svera.untiered.hud.HUD_Overlay;
import svera.untiered.messaging.impl.incoming.TradeAccepted;
import svera.untiered.messaging.impl.incoming.TradeChanged;
import svera.untiered.messaging.impl.incoming.TradeStart;
import svera.untiered.minimap.view.MiniMap;

public class HUDView extends Sprite
{

   private const MAP_POSITION:Point = new Point(204,4);

   private const CHARACTER_DETAIL_PANEL_POSITION:Point = new Point(200,198);

   //private const EQUIPMENT_INVENTORY_POSITION:Point = new Point(0,154);

   //private const STAT_METERS_POSITION:Point = new Point(-88,548);

   private const TAB_STRIP_POSITION:Point = new Point(7,154);

   private const INTERACT_PANEL_POSITION:Point = new Point(0,500);

   private var hudOverlay:HUD_Overlay;

   private var miniMap:MiniMap;

   private var equippedGrid:EquippedGrid;

   private var tabStrip:TabStripView;

   private var statMeters:StatMetersView;

   private var characterDetails:CharacterDetailsView;

   public var interactPanel:InteractPanel;

   public var tradePanel:TradePanel;

   private var equippedGridBG:Sprite;

   public function HUDView()
   {
      super();
      this.createAssets();
      this.addAssets();
      this.positionAssets();
   }

   private function createAssets() : void
   {
      this.hudOverlay = new HUD_Overlay();
      this.miniMap = new MiniMap(192,192);
      this.tabStrip = new TabStripView(186,153);
      this.characterDetails = new CharacterDetailsView();
      this.statMeters = new StatMetersView();
   }

   private function addAssets() : void
   {
      addChild(this.hudOverlay);
      addChild(this.miniMap);
      addChild(this.tabStrip);
      addChild(this.characterDetails);
      addChild(this.statMeters);
   }

   private function positionAssets() : void
   {
      hudOverlay.parent.mouseEnabled = false;
      this.hudOverlay.x -= 400;
      this.miniMap.x = this.MAP_POSITION.x;
      this.miniMap.y = this.MAP_POSITION.y;
      this.tabStrip.y = 154;
      this.characterDetails.x -= 211;
      this.characterDetails.y = 504;
      this.statMeters.x -= 176 / 2;
      this.statMeters.y = 593 - this.statMeters.height;
   }

   public function setPlayerDependentAssets(gs:GameSprite) : void
   {
      var player:Player = gs.map.player_;
      this.equippedGrid = new EquippedGrid(player,player.slotTypes_,player);
      this.equippedGrid.x -= this.equippedGrid.width + 3;
      this.equippedGrid.y = 154;
      this.equippedGridBG = new Sprite();
      this.equippedGridBG.x = this.equippedGrid.x - 3;
      this.equippedGridBG.y = this.equippedGrid.y - 3;
      var fill_:GraphicsSolidFill = new GraphicsSolidFill(6776679,1);
      var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
      var graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[fill_,path_,GraphicsUtil.END_FILL];
      GraphicsUtil.drawCutEdgeRect(0,0,178,46,6,[1,1,1,1],path_);
      this.equippedGridBG.graphics.drawGraphicsData(graphicsData_);
      addChild(this.equippedGridBG);
      addChild(this.equippedGrid);
      this.interactPanel = new InteractPanel(gs,player,200,100);
      this.interactPanel.x = this.INTERACT_PANEL_POSITION.x;
      this.interactPanel.y = this.INTERACT_PANEL_POSITION.y;
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
      this.tabStrip.visible = false;
      this.equippedGrid.visible = false;
      this.equippedGridBG.visible = false;
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
         this.tabStrip.visible = true;
         this.equippedGrid.visible = true;
         this.equippedGridBG.visible = true;
         this.interactPanel.visible = true;
      }
   }
}
}
