package svera.untiered.storage {

import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;

import flash.display.Sprite;
import flash.events.MouseEvent;

import svera.untiered.messaging.impl.GameServerConnection;
import svera.untiered.messaging.impl.data.StorageSlotUpdateData;
import svera.untiered.storage.components.StorageSortTab;
import svera.untiered.storage.components.VaultUpgradeButton;

public class VaultWindow extends Sprite {
    private var contentView_:VaultContent;

    private var upgradeButton_:VaultUpgradeButton;

    private var sortCategories_:Vector.<StorageSortTab>;

    private var owner_:VaultChest;

    public function VaultWindow(owner:VaultChest, player:Player) {

        this.owner_ = owner;

        this.sortCategories_ = StorageUtil.makeStorageSortCategories();

        for (var i:int = 0; i < this.sortCategories_.length; i++) {
            var sorter:StorageSortTab = this.sortCategories_[i];

            sorter.x = 5;
            sorter.y = StorageUtil.TOP_PAD + (StorageSortTab.SIZE + 5) * i;
            sorter.addEventListener(MouseEvent.CLICK, this.onSort);

            this.addChild(sorter);
        }

        this.contentView_ = new VaultContent(this.owner_, player);
        this.contentView_.x = StorageUtil.LEFT_PAD;
        this.contentView_.y = StorageUtil.TOP_PAD;
        addChild(this.contentView_);

        this.upgradeButton_ = new VaultUpgradeButton();
        this.upgradeButton_.x = StorageUtil.LEFT_PAD + (StorageUtil.CONTENT_WIDTH - this.upgradeButton_.width) / 2;
        this.upgradeButton_.y = StorageUtil.CONTENT_HEIGHT + StorageUtil.TOP_PAD + 10;
        addChild(this.upgradeButton_);

        this.upgradeButton_.addEventListener(MouseEvent.CLICK, this.onUpgradeClick);

        graphics.clear();
        graphics.beginFill(0x262626);
        graphics.drawRect(0, 0, StorageUtil.WINDOW_SIZE, StorageUtil.WINDOW_SIZE);
        graphics.endFill();
    }

    private function onUpgradeClick(e:MouseEvent) : void {
        // do some verification
        GameServerConnection.instance.vaultUpgrade(this.owner_.objectId_);
    }

    public function setContent(size:int, slots:Vector.<StorageSlotUpdateData>) : void {
        this.owner_.setContainer(size, slots);
        this.contentView_.initialize(size, slots);
        this.upgradeButton_.setPurchaseInfo(size);
    }

    public function updateSlot(slot:int, inventory:int, itemData:int) : void {
        this.owner_.equipment_[slot] = inventory;
        this.owner_.itemDatas_[slot] = itemData;
        this.contentView_.updateSlot(slot, inventory, itemData);
    }


    private function onSort(e:MouseEvent) : void {
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

    public function dispose() : void {
        this.sortCategories_.length = 0;
        this.sortCategories_ = null;
        this.contentView_.dispose();
    }
}
}
