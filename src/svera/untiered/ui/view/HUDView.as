package svera.untiered.ui.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.TradePanel;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.BindGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.util.SpriteUtil;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import svera.untiered.game.view.LootboxModalButton;
import svera.untiered.game.view.RaidLauncherButton;
import svera.untiered.game.view.components.StatsView;
import svera.untiered.hud.HUD_Overlay;
import svera.untiered.messaging.impl.incoming.TradeAccepted;
import svera.untiered.messaging.impl.incoming.TradeChanged;
import svera.untiered.messaging.impl.incoming.TradeStart;
import svera.untiered.minimap.view.MiniMap;
import svera.untiered.ui.UIUtils;

public class HUDView extends Sprite {
    private const MAP_POSITION:Point = new Point(204, 4);

    private const INTERACT_PANEL_POSITION:Point = new Point(0, 500);

    private var hudOverlay:HUD_Overlay;

    private var miniMap:MiniMap;

    public var bindGrid:BindGrid;

    public var equippedGrid:EquippedGrid;

    public var inventoryGrid:InventoryGrid;

    private var statMeters:StatMetersView;

    public var statsView:StatsView;

    private var characterDetails:CharacterDetailsView;

    public var interactPanel:InteractPanel;

    public var tradePanel:TradePanel;

    public static var instance:HUDView;
    public var raidLauncherButton:RaidLauncherButton;
    private var displaysPosY:uint = 4;

    public var lootBoxButton:LootboxModalButton;

    public function HUDView() {
        super();
        instance = this;
        this.createAssets();
        this.addAssets();
        GameClient.STAGE.addEventListener(Event.RESIZE, positionAssets);
        this.positionAssets();
    }

    private function createAssets():void {
        this.hudOverlay = new HUD_Overlay();
        this.miniMap = new MiniMap(192, 192);
        this.characterDetails = new CharacterDetailsView();
        this.statMeters = new StatMetersView();
    }

    private function addAssets():void {
        addChild(this.hudOverlay);
        addChild(this.miniMap);
        addChild(this.characterDetails);
        addChild(this.statMeters);
    }

    private function positionAssets(e:Event = null):void {
        hudOverlay.parent.mouseEnabled = false;
        this.hudOverlay.x = GameClient.HalfStageWidth - this.hudOverlay.width * 0.5;
        this.hudOverlay.y = GameClient.StageHeight - hudOverlay.height;
        this.miniMap.x = GameClient.StageWidth - miniMap._width - 2;
        this.miniMap.y = this.MAP_POSITION.y;
        this.characterDetails.x = hudOverlay.x + 26;
        this.characterDetails.y = hudOverlay.y;
        this.statMeters.x = hudOverlay.x + 100;
        this.statMeters.y = hudOverlay.y + 45;

        if (inventoryGrid && equippedGrid && statsView && interactPanel) {
            equippedGrid.x = hudOverlay.x + 131;
            equippedGrid.y = hudOverlay.y + 2;

            bindGrid.x = hudOverlay.x + 347;
            bindGrid.y = hudOverlay.y + 3;

            inventoryGrid.x = bindGrid.x;
            inventoryGrid.y = GameClient.StageHeight - inventoryGrid.height;

            statsView.x = inventoryGrid.x - this.statsView.width * 2;
            statsView.y = inventoryGrid.y;

            interactPanel.x = GameClient.HalfStageWidth - interactPanel.width * 0.5;
            interactPanel.y = hudOverlay.y - interactPanel.height - 30;
        }
    }

    public function setPlayerDependentAssets(gs:GameSprite):void {
        var player:Player = gs.map.player_;
        this.inventoryGrid = new InventoryGrid(player, player, 5);
        this.equippedGrid = new EquippedGrid(player, player.slotTypes_, player);
        bindGrid = new BindGrid(player, player, inventoryGrid);
        this.statsView = new StatsView(50, 200);
        this.interactPanel = new InteractPanel(gs, player, 200, 100);

        this.inventoryGrid.x = GameClient.HalfStageWidth + 70;
        this.inventoryGrid.y = GameClient.StageHeight - inventoryGrid.height;

        equippedGrid.x = hudOverlay.x + 131;
        equippedGrid.y = hudOverlay.y + 2;
        bindGrid.x = hudOverlay.x + 347;
        bindGrid.y = hudOverlay.y + 3;

        this.statsView.x = inventoryGrid.x - this.statsView.width;
        this.statsView.y = inventoryGrid.y;

        this.interactPanel.x = 0;
        this.interactPanel.y = GameClient.StageHeight - interactPanel.height;

        this.inventoryGrid.visible = false;
        this.statsView.visible = false;

        showRaidLauncher();
        showLootboxButton();

        addChild(this.inventoryGrid);
        addChild(this.equippedGrid);
        addChild(this.bindGrid);
        addChild(this.statsView);
        addChild(this.interactPanel);
    }

    public function draw():void {
        positionAssets();
        if(bindGrid){
            bindGrid.draw();
        }
        if (this.equippedGrid) {
            this.equippedGrid.draw();
        }
        if (this.interactPanel) {
            this.interactPanel.draw();
        }
    }

    public function startTrade(gs:GameSprite, tradeStart:TradeStart):void {
        if (this.tradePanel != null) {
            return;
        }
        this.tradePanel = new TradePanel(gs, tradeStart);
        this.tradePanel.y = GameClient.StageHeight - (600 - 200);
        this.tradePanel.addEventListener(Event.CANCEL, this.onTradeCancel);
        addChild(this.tradePanel);
        this.characterDetails.visible = false;
        this.statMeters.visible = false;
        this.interactPanel.visible = false;
    }

    public function tradeChanged(tradeChanged:TradeChanged):void {
        if (this.tradePanel == null) {
            return;
        }
        this.tradePanel.setYourOffer(tradeChanged.offer_);
    }

    public function tradeAccepted(tradeAccepted:TradeAccepted):void {
        if (this.tradePanel == null) {
            return;
        }
        this.tradePanel.youAccepted(tradeAccepted.myOffer_, tradeAccepted.yourOffer_);
    }

    private function onTradeCancel(event:Event):void {
        this.removeTradePanel();
    }

    public function tradeDone():void {
        this.removeTradePanel();
    }

    private function removeTradePanel():void {
        if (this.tradePanel != null) {
            this.tradePanel.removeEventListener(Event.CANCEL, this.onTradeCancel);
            SpriteUtil.safeRemoveChild(this, this.tradePanel);
            this.tradePanel = null;
            this.characterDetails.visible = true;
            this.statMeters.visible = true;
            this.interactPanel.visible = true;
        }
    }

    private function OpenInventory():void {
        this.statsView.visible = true;
        this.inventoryGrid.visible = true;
    }

    private function CloseInventory():void {
        this.statsView.visible = false;
        this.inventoryGrid.visible = false;
    }

    public function ToggleInventory():void {
        if (this.inventoryGrid.visible) {
            this.CloseInventory();
        } else this.OpenInventory();
    }
    private function showRaidLauncher():void {
        this.raidLauncherButton = new RaidLauncherButton();
        this.raidLauncherButton.x = 50;
        this.raidLauncherButton.y = this.displaysPosY;
        this.displaysPosY = this.displaysPosY + UIUtils.NOTIFICATION_SPACE;
        addChild(this.raidLauncherButton);
    }


    private function showLootboxButton():void {
        this.lootBoxButton = new LootboxModalButton();
        this.lootBoxButton.x = this.raidLauncherButton.x + 32;
        this.lootBoxButton.y = this.raidLauncherButton.y;
        addChild(this.lootBoxButton);
    }
    public function setMiniMapFocus(object:GameObject) : void {
        this.miniMap.setFocus(object);
    }
}
}
