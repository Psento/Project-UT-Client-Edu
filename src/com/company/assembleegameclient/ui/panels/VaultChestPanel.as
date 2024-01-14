package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.VaultChest;

import flash.events.MouseEvent;

import svera.untiered.vault.VaultWindow;

public class VaultChestPanel extends ButtonPanel {

    private var go_:VaultChest;

    public function VaultChestPanel(go:VaultChest, gs:GameSprite)
    {
        this.go_ = go;
        super(gs,"Vault","View");
    }

    override protected function onButtonClick(event:MouseEvent) : void {
        var p:Player = this.gs_.map.player_;
        if(p == null)
        {
            return;
        }

        this.gs_.addChild(new VaultWindow(this.go_, p));
    }
}
}
