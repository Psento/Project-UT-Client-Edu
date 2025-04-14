package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.GiftChestPanel;
import com.company.assembleegameclient.ui.panels.Panel;

import svera.untiered.itemdata.NewItemData;

import svera.untiered.messaging.impl.data.StorageSlotUpdateData;

public class GiftChest extends GameObject implements IInteractiveObject {

    public function GiftChest(objectXML:XML) {
        super(objectXML);
        isInteractive_ = true;
    }


    public function setContainer(size:int, slots:Vector.<StorageSlotUpdateData>):void {
        this.equipment_ = new Vector.<int>(size);
        this.itemDatas_ = new Vector.<NewItemData>(size);

        for (var i:int = 0; i < size; i++) {
            this.equipment_[i] = slots[i].itemType_;
            this.itemDatas_[i] = slots[i].itemData_;
        }
    }

    public function getPanel(gs:GameSprite):Panel {
        return new GiftChestPanel(this, gs);
    }
}
}
