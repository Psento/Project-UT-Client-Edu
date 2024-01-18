package svera.untiered.vault {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
import com.company.util.SpriteUtil;

import flash.display.Sprite;

import svera.untiered.constants.ItemConstants;

import svera.untiered.messaging.impl.GameServerConnection;

import svera.untiered.messaging.impl.data.VaultUpdateSlot;
import svera.untiered.vault.components.VaultSortTab;

public class VaultContent extends Sprite {

    public static const WIDTH:int = 380;
    public static const HEIGHT:int = 400;

    private var vaultGrid_:ContainerGrid;

    private var scrollBar_:Scrollbar;

    private var owner_:VaultChest;
    private var player_:Player;

    private var curSort_:String;

    public function VaultContent(owner:VaultChest, player:Player) {
        this.owner_ = owner;
        this.player_ = player;

        GameServerConnection.instance.vaultRequest(owner.objectId_);

        this.scrollBar_ = new Scrollbar(15, HEIGHT);

        graphics.beginFill(0);
        graphics.drawRect(0, 0, WIDTH, HEIGHT);
        graphics.endFill();
    }

    private var content_:Vector.<VaultUpdateSlot>;
    public function initialize(size:int, content:Vector.<VaultUpdateSlot>) : void {
        if (this.vaultGrid_ != null) {
            SpriteUtil.safeRemoveChild(this, this.vaultGrid_);
        }

        this.content_ = content;
        this.vaultGrid_ = new ContainerGrid(this.owner_, this.player_, size, 8, true);

        var inventory:Vector.<int> = new Vector.<int>();
        var itemDatas:Vector.<int> = new Vector.<int>();

        for (var i:int = 0; i < size; i++) {
            inventory[i] = this.content_[i].itemType_;
            itemDatas[i] = this.content_[i].itemData_;
        }

        this.vaultGrid_.setItems(inventory, itemDatas);
        this.vaultGrid_.x = 10;
        this.vaultGrid_.y = 10;
        // add scroll wheel here

        SpriteUtil.safeAddChild(this, this.vaultGrid_);
    }

    public function updateSlot(slot:int, inventory:int, itemData:int) : void {
        this.vaultGrid_.setItem(slot, inventory, itemData);
    }

    public function sortBy(sort:String) : void {
        if (this.curSort_ == sort) {
            return;
        }

        this.curSort_ = sort;
        this.filterSlotsBySlotType(VaultSortTab.getSortArray(this.curSort_));
    }

    public function filterSlotsBySlotType(types:Array):void {
        while(this.vaultGrid_.numChildren > 0) {
            this.vaultGrid_.removeChildAt(0);
        }

        var slotCount:int = 0;
        for each(var tile:InteractiveItemTile in this.vaultGrid_.items) {
            if (tile.getItemId() == ItemConstants.NO_ITEM) {
                continue;
            }

            var slotType:int = ObjectLibrary.getSlotTypeFromType(tile.getItemId());

            if (types.indexOf(slotType) > -1 || types.length == 0) {
                this.vaultGrid_.addToGrid(tile, 8, slotCount);
                slotCount++;
            }
        }
    }


}
}
