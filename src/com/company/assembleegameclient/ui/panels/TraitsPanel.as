package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;

import flash.events.MouseEvent;

import svera.untiered.traits.TraitsGUI;

public class TraitsPanel extends ButtonPanel {
    public function TraitsPanel(gs:GameSprite)
    {
        super(gs,"Traits","View");
    }

    override protected function onButtonClick(event:MouseEvent) : void
    {
        var p:Player = gs_.map.player_;
        if(p == null)
        {
            return;
        }
        gs_.addChild(new TraitsGUI());
    }
}
}
