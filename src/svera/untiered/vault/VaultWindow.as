package svera.untiered.vault {

import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;

import flash.display.Sprite;
import flash.events.MouseEvent;

import svera.untiered.messaging.impl.GameServerConnection;

import svera.untiered.messaging.impl.data.VaultUpdateSlot;

import svera.untiered.vault.components.VaultSortTab;
import svera.untiered.vault.components.VaultUpgradeButton;

public class VaultWindow extends Sprite {

    public static const WINDOW_SIZE:int = 450;

    private static const LEFT_PAD:int = 60;
    private static const TOP_PAD:int = 10;

    private var contentView_:VaultContent;

    private var upgradeButton_:VaultUpgradeButton;

    private var sortCategories_:Vector.<VaultSortTab>;

    public function VaultWindow(owner:VaultChest, player:Player) {

        this.sortCategories_ = new Vector.<VaultSortTab>();
        this.sortCategories_[0] = new VaultSortTab(VaultSortTab.ALL);
        this.sortCategories_[1] = new VaultSortTab(VaultSortTab.WEAPON);
        this.sortCategories_[2] = new VaultSortTab(VaultSortTab.ABILITY);
        this.sortCategories_[3] = new VaultSortTab(VaultSortTab.ARMOR);
        this.sortCategories_[4] = new VaultSortTab(VaultSortTab.MISC);

        for (var i:int = 0; i < this.sortCategories_.length; i++) {
            var sorter:VaultSortTab = this.sortCategories_[i];

            sorter.x = 5;
            sorter.y = TOP_PAD + 55 * i;
            sorter.addEventListener(MouseEvent.CLICK, this.onSort);

            this.addChild(sorter);
        }

        this.contentView_ = new VaultContent(owner, player);
        this.contentView_.x = LEFT_PAD;
        this.contentView_.y = TOP_PAD;
        addChild(this.contentView_);

        this.upgradeButton_ = new VaultUpgradeButton();
        this.upgradeButton_.x = LEFT_PAD + (VaultContent.WIDTH - this.upgradeButton_.width) / 2;
        this.upgradeButton_.y = VaultContent.HEIGHT + TOP_PAD + 10;
        addChild(this.upgradeButton_);

        this.upgradeButton_.addEventListener(MouseEvent.CLICK, this.onUpgradeClick);

        graphics.clear();
        graphics.beginFill(0x262626);
        graphics.drawRect(0, 0, WINDOW_SIZE, 500);
        graphics.endFill();
    }

    private function onUpgradeClick(e:MouseEvent) : void {
        // do some verification
        GameServerConnection.instance.vaultUpgrade(0xfff);
    }

    public function setContent(size:int, slots:Vector.<VaultUpdateSlot>) : void {
        this.contentView_.initialize(size, slots);
        this.upgradeButton_.setPurchaseInfo(size);
    }

    public function get content() : VaultContent {
        return this.contentView_;
    }

    private function onSort(e:MouseEvent) : void {
        var caller:VaultSortTab = e.currentTarget as VaultSortTab;
        if (caller == null) {
            return;
        }

        caller.select();
        if (caller.isSelected()) {
            this.contentView_.sortBy(caller.filter_);
        }

        for each(var sorter:VaultSortTab in this.sortCategories_) {
            if (sorter.filter_ == caller.filter_) {
                continue;
            }
            sorter.unselect();
        }
     }
}
}
