package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.UIHandler;
import com.company.assembleegameclient.ui.tooltip.RankToolTip;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import svera.untiered.account.core.view.AccountInfoView;

public class AccountScreen extends Sprite {
    public var tooltip:Signal;

    private var rankLayer:Sprite;

    private var guildLayer:Sprite;

    private var accountInfoLayer:Sprite;

    private var guildName:String;

    private var guildRank:int;

    private var stars:int;

    private var rankText:RankText;

    private var guildText:GuildText;

    private var accountInfo:AccountInfoView;

    public function AccountScreen() {
        super();
        this.tooltip = new Signal();
        this.makeLayers();
    }

    private function makeLayers():void {
        addChild(this.rankLayer = new Sprite());
        addChild(this.guildLayer = new Sprite());
        addChild(this.accountInfoLayer = new Sprite());
    }

    public function setGuild(guildName:String, guildRank:int):void {
        this.guildName = guildName;
        this.guildRank = guildRank;
        this.makeGuildText();
    }

    private function makeGuildText():void {
        this.guildText = new GuildText(this.guildName, this.guildRank);
        UIHandler.getInstance().register(this.guildText, UIHandler.TOP_LEFT, 92, 6, true);
        this.guildLayer.addChild(this.guildText);
    }

    public function setRank(stars:int):void {
        this.stars = stars;
        this.makeRankText();
    }

    private function makeRankText():void {
        this.rankText = new RankText(this.stars, true, false);
        UIHandler.getInstance().register(this.rankText, UIHandler.TOP_LEFT, 36, 4, true);
        this.rankText.mouseEnabled = true;
        this.rankText.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        this.rankText.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        this.rankLayer.addChild(this.rankText);
    }

    public function setAccountInfo(accountInfo:AccountInfoView):void {
        this.accountInfo = accountInfo;
        // Cast AccountInfoView to DisplayObject for UIHandler registration
        var accountDisplay:DisplayObject = accountInfo as DisplayObject;
        if (accountDisplay) {
            UIHandler.getInstance().register(accountDisplay, UIHandler.TOP_RIGHT, -10, 10, true);
        }
        this.accountInfoLayer.addChild(accountDisplay);
    }

    // Clean up UIHandler registrations when AccountScreen is destroyed
    public function destroy():void {
        if (this.guildText) UIHandler.getInstance().unregister(this.guildText);
        if (this.rankText) UIHandler.getInstance().unregister(this.rankText);
        if (this.accountInfo) UIHandler.getInstance().unregister(this.accountInfo as DisplayObject);
    }

    protected function onMouseOver(event:MouseEvent):void {
        this.tooltip.dispatch(new RankToolTip(this.stars));
    }

    protected function onRollOut(event:MouseEvent):void {
        this.tooltip.dispatch(null);
    }
}
}
