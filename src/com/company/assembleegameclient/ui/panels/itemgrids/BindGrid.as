package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.BindTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;

import flash.events.MouseEvent;

public class BindGrid extends ItemGrid {
    private var tiles:Vector.<BindTile>;

    private var numSlots_:int;
    private var noCuts_:Boolean;
    public var bindToGrid:InventoryGrid

    public function BindGrid(gridOwner:GameObject, currentPlayer:Player, grid:InventoryGrid, indexoffset:int = 5) {
        super(gridOwner, currentPlayer, 0, null, 2);

        bindToGrid = grid;
        numSlots_ = 8;
        this.noCuts_ = false;
        indexOffset = indexoffset;
        tiles = new Vector.<BindTile>(8, true);
        var tile:BindTile = null;
        for (var i:int = 0; i < numSlots_; i++) {
            tile = new BindTile(i, this);
            addToGrid(tile, 2, i);
            tile.addTileNumber(i + 1);
            this.tiles[i] = tile;
        }
    }

    public override function addToGrid(tile:ItemTile, numRows:uint, tileIndex:uint):void {
        tile.drawBackground(NO_CUT);
        tile.addEventListener(MouseEvent.ROLL_OVER, this.onTileHover);
        tile.y = int(tileIndex / 4) * (ItemTile.HEIGHT + 1);
        tile.x = int(tileIndex % 4) * (ItemTile.WIDTH + 1);
        addChild(tile);
    }

    override public function setItems(items:Vector.<int>, datas:Vector.<int>, itemIndexOffset:int = 0):void {
        var numItems:int = 0;
        var i:int = 0;
        var refresh:Boolean = false;
        //var inv:InventoryGrid = bindToGrid;
        if (items) {
            numItems = items.length;
            for (i = 0; i < this.numSlots_; i++) {
                if (i + indexOffset < numItems) {
                    if (this.tiles[i].setItem(items[i + indexOffset], datas[i + indexOffset])) {
                        refresh = true;
                    }
                } else {
                    if (this.tiles[i].setItem(0, 0)) {
                        refresh = true;
                    }
                }
            }
            if (refresh) {
                refreshTooltip();
            }
        }
    }

    public function setItem(slot:int, itemId:int, itemData:int):void {
        if (slot >= this.tiles.length || slot < 0) {
            return;
        }
        this.tiles[slot].setItem(itemId, itemData);
    }

    public function get items():Vector.<BindTile> {
        return this.tiles;
    }
}
}
