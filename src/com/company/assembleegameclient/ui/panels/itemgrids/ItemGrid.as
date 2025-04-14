package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.Container;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.util.SpriteUtil;

import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import svera.untiered.constants.ItemConstants;
import svera.untiered.itemdata.NewItemData;

public class ItemGrid extends Panel {

    public static const NO_CUT:Array = [0, 0, 0, 0];

    public static const CutsByNum:Object = {
        1: [[1, 1, 0, 0], NO_CUT, NO_CUT, NO_CUT, [0, 0, 1, 1]],
        2: [[1, 0, 0, 1], NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]],
        3: [[1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]],
        6: [[1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, NO_CUT, [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]]
    };


    private const padding:uint = 4;
    public const addToolTip:Signal = new Signal(ToolTip);

    public var owner:GameObject;

    private var tooltip:ToolTip;
    private var tooltipFocusTile:ItemTile;

    public var curPlayer:Player;

    protected var indexOffset:int;

    public var interactive:Boolean;

    private var overrideCut_:Array;
    private var rowLength:uint;

    public function ItemGrid(gridOwner:GameObject, currentPlayer:Player, itemIndexOffset:int, overrideCut:Array = null, rowLength:int = 4) {
        super(null);
        this.overrideCut_ = overrideCut;
        this.rowLength = rowLength;
        this.owner = gridOwner;
        this.curPlayer = currentPlayer;
        this.indexOffset = itemIndexOffset;
        var isContainer:Boolean = gridOwner is Container || gridOwner is VaultChest;
        if (gridOwner == currentPlayer || isContainer) {
            this.interactive = true;
        }
    }

    public function hideTooltip():void {
        if (this.tooltip) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.tooltipFocusTile = null;
        }
    }

    public function refreshTooltip():void {
        if (!stage || !this.tooltip || !this.tooltip.stage) {
            return;
        }
        if (this.tooltipFocusTile) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.addToolTipToTile(this.tooltipFocusTile);
        }
    }

    public function onTileHover(e:MouseEvent):void {
        if (!stage) {
            return;
        }
        var tile:ItemTile = e.currentTarget as ItemTile;
        this.addToolTipToTile(tile);
        this.tooltipFocusTile = tile;
    }

    private function addToolTipToTile(tile:ItemTile):void {
        var itemName:String = null;
        if (tile.itemSprite.itemId > 0) {
            this.tooltip = new EquipmentToolTip(tile.itemSprite.itemId, tile.itemSprite.itemData, this.curPlayer, Boolean(this.owner) ? int(this.owner.objectType_) : int(-1), this.getCharacterType(), tile.tileId);
        } else {
            if (tile is EquipmentTile) {
                itemName = ItemConstants.itemTypeToName((tile as EquipmentTile).itemType);
            } else {
                itemName = "item";
            }
            this.tooltip = new TextToolTip(3552822, 10197915, null, "Empty " + itemName + " Slot", 200);
        }
        this.tooltip.attachToTarget(tile);
        this.addToolTip.dispatch(this.tooltip);
    }

    private function getCharacterType():String {
        if (this.owner == this.curPlayer) {
            return InventoryOwnerTypes.CURRENT_PLAYER;
        }
        if (this.owner is Player) {
            return InventoryOwnerTypes.OTHER_PLAYER;
        }
        return InventoryOwnerTypes.NPC;
    }

    public function addToGrid(tile:ItemTile, numRows:uint, tileIndex:uint):void {
        tile.drawBackground(this.overrideCut_ == null ? CutsByNum[numRows][tileIndex] : this.overrideCut_);
        tile.addEventListener(MouseEvent.ROLL_OVER, this.onTileHover);
        tile.x = int(tileIndex % this.rowLength) * (ItemTile.WIDTH + this.padding);
        tile.y = int(tileIndex / this.rowLength) * (ItemTile.HEIGHT + this.padding);
        addChild(tile);
    }

    public function removeFromGrid(tile:ItemTile):void {
        SpriteUtil.safeRemoveChild(this, tile);
    }

    public function setItems(items:Vector.<int>, datas:Vector.<NewItemData>, itemIndexOffset:int = 0):void {

    }

    public function enableInteraction(enabled:Boolean):void {
        mouseEnabled = enabled;
    }

    override public function draw():void {
        this.setItems(this.owner.equipment_, this.owner.itemDatas_, this.indexOffset);
    }
}
}
