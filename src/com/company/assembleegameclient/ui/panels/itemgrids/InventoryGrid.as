package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;

import link.ItemData;

import svera.untiered.itemdata.NewItemData;

public class InventoryGrid extends ItemGrid {


    private const NUM_SLOTS:uint = 24;

    public var tiles:Vector.<InventoryTile>;

    public function InventoryGrid(gridOwner:GameObject, currentPlayer:Player, itemIndexOffset:int = 0) {
        var tile:InventoryTile = null;
        super(gridOwner, currentPlayer, itemIndexOffset);
        this.tiles = new Vector.<InventoryTile>(this.NUM_SLOTS);
        padding = 1;
        for (var i:int = 0; i < this.NUM_SLOTS; i++) {
            tile = new InventoryTile(i + indexOffset, this, interactive);
            addToGrid(tile, 6, i);
            this.tiles[i] = tile;
            if (i < 8)
                tile.addTileNumber(i + 1);
        }
    }

    override public function setItems(items:Vector.<NewItemData>, itemIndexOffset:int = 0):void {
        var numItems:int = 0;
        var i:int = 0;
        var refresh:Boolean = false;
        if (items) {
            numItems = items.length;
            for (i = 0; i < this.NUM_SLOTS; i++) {
                if (i + indexOffset < numItems) {
                    if (this.tiles[i].setItem(items[i + indexOffset])) {
                        refresh = true;
                    }
                } else {
                    if (this.tiles[i].setItem(null)) {
                        refresh = true;
                    }
                }
            }
            if (refresh) {
                refreshTooltip();
            }
        }
    }
}
}
