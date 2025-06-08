package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;

public class BindGrid extends ItemGrid {
    private var tiles:Vector.<ItemTile>;

    private var numSlots_:int;
    private var noCuts_:Boolean;

    public function BindGrid(gridOwner:GameObject, currentPlayer:Player, numSlots:int = 8, rowLength:int = 2, noCuts:Boolean = false) {
        super(gridOwner, currentPlayer, 0, ItemGrid.NO_CUT, rowLength);

        this.noCuts_ = noCuts;

        this.resizeContainer(numSlots);
    }

    public function resizeContainer(numSlots:int):void {
        var curSize:int = this.numSlots_;
        this.numSlots_ = numSlots;

        var newTiles:Vector.<InteractiveItemTile> = new Vector.<InteractiveItemTile>(this.numSlots_);

        var tile:InteractiveItemTile = null;

        for (var i:int = 0; i < this.numSlots_; i++) {

            if (i < curSize) {
                this.removeFromGrid(this.tiles[i]);
                tile = this.tiles[i];
            } else {
                tile = new InteractiveItemTile(i + this.indexOffset, this, this.interactive);
            }

            addToGrid(tile, 2, i);
            newTiles[i] = tile;
        }

        this.tiles = newTiles;
    }

    override public function setItems(items:Vector.<int>, datas:Vector.<int>, itemIndexOffset:int = 0):void {
        var numItems:int = 0;
        var i:int = 0;
        var refresh:Boolean = false;
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

    public function get items():Vector.<InteractiveItemTile> {
        return this.tiles;
    }
}
}
