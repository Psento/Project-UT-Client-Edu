package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;

import svera.untiered.itemdata.NewItemData;

public class InventoryGrid extends ItemGrid {


    private const NUM_SLOTS:uint = 24;

    private var tiles:Vector.<InventoryTile>;

    public function InventoryGrid(gridOwner:GameObject, currentPlayer:Player, itemIndexOffset:int = 0) {
        var tile:InventoryTile = null;
        super(gridOwner, currentPlayer, itemIndexOffset);
        this.tiles = new Vector.<InventoryTile>(this.NUM_SLOTS);
        for (var i:int = 0; i < this.NUM_SLOTS; i++) {
            tile = new InventoryTile(i + indexOffset, this, interactive);
            tile.addTileNumber(i + 1);
            addToGrid(tile, 6, i);
            this.tiles[i] = tile;
        }
    }

    override public function setItems(items:Vector.<int>, datas:Vector.<NewItemData>, itemIndexOffset:int = 0):void {
        var numItems:int = 0;
        var i:int = 0;
        var refresh:Boolean = false;
        if (items) {
            numItems = items.length;
            for (i = 0; i < this.NUM_SLOTS; i++) {
                if (i + indexOffset < numItems) {
                    if (this.tiles[i].setItem(items[i + indexOffset], datas[i + indexOffset])) {
                        refresh = true;
                    }
                } else {
                    if (this.tiles[i].setItem(-1, null)) {
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
