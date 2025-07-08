package com.company.assembleegameclient.objects {

import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.VaultChestPanel;

import link.ItemData;

public class VaultChest extends GameObject implements IInteractiveObject {

    public function VaultChest(objectXML:XML) {
        super(objectXML);
        isInteractive_ = true;
    }

    public function setContainer(size:int, slots:Vector.<ItemData>):void {
        this.equipment_ = new Vector.<ItemData>(size);

        for (var i:int = 0; i < size; i++) {
            this.equipment_[i] = slots[i];
        }
    }

    public function getPanel(gs:GameSprite):Panel {
        return new VaultChestPanel(this, gs);
    }
}
}
