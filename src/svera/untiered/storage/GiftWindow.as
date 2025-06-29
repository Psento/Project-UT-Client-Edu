package svera.untiered.storage {
import com.company.assembleegameclient.objects.GiftChest;
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;
import flash.events.MouseEvent;

import link.ItemData;

import svera.untiered.messaging.impl.data.StorageSlotUpdateData;
import svera.untiered.storage.components.StorageSortTab;

public class GiftWindow extends Sprite {

    private var owner_:GiftChest;

    private var contentView_:GiftContent;
    private var sortCategories_:Vector.<StorageSortTab>;

    public function GiftWindow(owner:GiftChest, player:Player) {
        this.owner_ = owner;

        this.sortCategories_ = StorageUtil.makeStorageSortCategories();

        for (var i:int = 0; i < this.sortCategories_.length; i++) {
            var sorter:StorageSortTab = this.sortCategories_[i];

            sorter.x = 5;
            sorter.y = StorageUtil.TOP_PAD + (StorageSortTab.SIZE + 5) * i;
            sorter.addEventListener(MouseEvent.CLICK, this.onSort);

            this.addChild(sorter);
        }

        this.contentView_ = new GiftContent(this.owner_, player);
        this.contentView_.x = StorageUtil.LEFT_PAD;
        this.contentView_.y = StorageUtil.TOP_PAD;
        this.addChild(this.contentView_);

        graphics.clear();
        graphics.beginFill(0x262626);
        graphics.drawRect(0, 0, StorageUtil.WINDOW_SIZE, StorageUtil.WINDOW_SIZE);
        graphics.endFill();
    }

    public function setContent(size:int, slots:Vector.<StorageSlotUpdateData>):void {
        this.owner_.setContainer(size, slots);
        this.contentView_.initialize(size, slots);
    }

    public function updateSlot(slot:int, inventory:ItemData):void {
        this.owner_.equipment_[slot] = inventory;
        this.contentView_.updateSlot(slot, inventory);
    }

    private function onSort(e:MouseEvent):void {
        var caller:StorageSortTab = e.currentTarget as StorageSortTab;
        if (caller == null) {
            return;
        }

        caller.select();
        if (caller.isSelected()) {
            this.contentView_.sortBy(caller.filter_);
        }

        for each(var sorter:StorageSortTab in this.sortCategories_) {
            if (sorter.filter_ == caller.filter_) {
                continue;
            }
            sorter.unselect();
        }
    }

    public function dispose():void {

    }
}
}
