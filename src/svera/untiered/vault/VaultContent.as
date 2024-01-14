package svera.untiered.vault {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.util.SpriteUtil;

import flash.display.Sprite;

import svera.untiered.messaging.impl.GameServerConnection;

import svera.untiered.messaging.impl.data.VaultUpdateSlot;

public class VaultContent extends Sprite {

    public static const WIDTH:int = 380;
    public static const HEIGHT:int = 480;

    private var vaultGrid_:ContainerGrid;

    private var scrollBar_:Scrollbar;

    private var owner_:VaultChest;
    private var player_:Player;

    public function VaultContent(owner:VaultChest, player:Player) {
        this.owner_ = owner;
        this.player_ = player;

        GameServerConnection.instance.vaultRequest(owner.objectId_);

        this.scrollBar_ = new Scrollbar(15, HEIGHT);

        graphics.beginFill(0);
        graphics.drawRect(0, 0, WIDTH, HEIGHT);
        graphics.endFill();
    }

    public function initialize(size:int, content:Vector.<VaultUpdateSlot>) : void {
        if (this.vaultGrid_ != null) {
            SpriteUtil.safeRemoveChild(this, this.vaultGrid_);
        }

        this.vaultGrid_ = new ContainerGrid(this.owner_, this.player_, size, 8, true);

        var inventory:Vector.<int> = new Vector.<int>();
        var itemDatas:Vector.<int> = new Vector.<int>();

        for (var i:int = 0; i < size; i++) {
            inventory[i] = content[i].itemData_;
            itemDatas[i] = content[i].itemType_;
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

    public function sortTypes() : void {

    }


}
}
