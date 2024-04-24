package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.VaultChest;

import svera.untiered.storage.VaultWindow;

public class VaultChestPanel extends Panel {

    private var window_:VaultWindow;

    public function VaultChestPanel(go:VaultChest, gs:GameSprite)
    {
        super(gs);
        this.window_ = new VaultWindow(go, gs.map.player_);
        this.gs_.addChild(this.window_);
    }

    override public function onRemoved() : void {
        this.window_.dispose();
        this.gs_.removeChild(this.window_);

        this.window_ = null;
    }
}
}
