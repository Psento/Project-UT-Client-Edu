package svera.untiered.storage {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
import com.company.util.SpriteUtil;

import flash.display.Sprite;

import link.ItemData;

import svera.untiered.messaging.impl.GameServerConnection;

import svera.untiered.storage.components.StorageSortTab;

public class VaultContent extends Sprite {
    private var vaultGrid_:ContainerGrid;

    private var scrollBar_:Scrollbar;

    private var owner_:VaultChest;
    private var player_:Player;

    private var curSort_:String;

    public function VaultContent(owner:VaultChest, player:Player) {
        this.owner_ = owner;
        this.player_ = player;

        GameServerConnection.instance.storageRequest(owner.objectId_);

        this.scrollBar_ = new Scrollbar(15, StorageUtil.CONTENT_HEIGHT);

        graphics.beginFill(0);
        graphics.drawRect(0, 0, StorageUtil.CONTENT_WIDTH, StorageUtil.CONTENT_HEIGHT);
        graphics.endFill();
    }

    private var content_:Vector.<ItemData>;

    public function initialize(size:int, content:Vector.<ItemData>):void {
        if (this.vaultGrid_ != null) {
            SpriteUtil.safeRemoveChild(this, this.vaultGrid_);
        }

        this.content_ = content;
        this.vaultGrid_ = new ContainerGrid(this.owner_, this.player_, size, 8, true);

        this.vaultGrid_.setItems(content);
        this.vaultGrid_.x = 10;
        this.vaultGrid_.y = 10;
        // add scroll wheel here

        SpriteUtil.safeAddChild(this, this.vaultGrid_);
    }

    public function updateSlot(slot:int, inventory:ItemData):void {
        this.vaultGrid_.setItem(slot, inventory);
    }

    public function sortBy(sort:String):void {
        if (this.curSort_ == sort) {
            return;
        }

        this.curSort_ = sort;
        this.filterSlotsBySlotType(StorageSortTab.getSortArray(this.curSort_));
    }

    public function filterSlotsBySlotType(types:Array):void {
        while (this.vaultGrid_.numChildren > 0) {
            this.vaultGrid_.removeChildAt(0);
        }

        var slotCount:int = 0;
        for each(var tile:InteractiveItemTile in this.vaultGrid_.items) {
            var slotType:int = ObjectLibrary.getSlotTypeFromType(tile.getItemId().ObjectType);

            if (types.indexOf(slotType) > -1 || types.length == 0) {
                this.vaultGrid_.addToGrid(tile, 8, slotCount);
                slotCount++;
            }
        }
    }

    public function dispose():void {
        removeChild(this.vaultGrid_);
        this.vaultGrid_ = null;
    }
}
}
