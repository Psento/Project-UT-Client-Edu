package svera.untiered.vault {

import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;

import flash.display.Sprite;
import flash.events.MouseEvent;

import svera.untiered.vault.components.VaultSortTab;

public class VaultWindow extends Sprite {

    public static const WINDOW_SIZE:int = 450;

    private static const LEFT_PAD:int = 60;
    private static const TOP_PAD:int = 10;

    private var contentView_:VaultContent;

    private var sortCategories_:Vector.<VaultSortTab>;

    public function VaultWindow(owner:VaultChest, player:Player) {

        this.sortCategories_ = new Vector.<VaultSortTab>();
        this.sortCategories_[0] = new VaultSortTab(VaultSortTab.NONE);
        this.sortCategories_[1] = new VaultSortTab(VaultSortTab.A_TO_Z);
        this.sortCategories_[2] = new VaultSortTab(VaultSortTab.TYPE);
        this.sortCategories_[3] = new VaultSortTab(VaultSortTab.RARITY);

        for (var i:int = 0; i < 4; i++) {
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

        graphics.clear();
        graphics.beginFill(0x262626);
        graphics.drawRect(0, 0, WINDOW_SIZE, 500);
        graphics.endFill();
    }

    public function getContent() : VaultContent {
        return this.contentView_;
    }

    private function onSort(e:MouseEvent) : void {

    }
}
}
