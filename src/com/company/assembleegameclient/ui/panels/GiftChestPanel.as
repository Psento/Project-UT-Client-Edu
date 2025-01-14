package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GiftChest;

import svera.untiered.storage.GiftWindow;

public class GiftChestPanel extends Panel {

    private var window_:GiftWindow;

    public function GiftChestPanel(go:GiftChest, gs:GameSprite)
    {
        super(gs);

        this.window_ = new GiftWindow(go, gs.map.player_);
        gs.addChild(this.window_);
    }

    public override function onRemoved() : void {
        this.window_.dispose();
        this.gs_.removeChild(this.window_);

        this.window_ = null;
    }
}
}
