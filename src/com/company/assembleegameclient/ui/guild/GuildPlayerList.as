package com.company.assembleegameclient.ui.guild {
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.util.GuildUtil;
import com.company.ui.SimpleText;
import com.company.util.MoreObjectUtil;

import flash.display.Bitmap;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import svera.untiered.account.core.Account;
import svera.untiered.appengine.api.AppEngineClient;
import svera.untiered.core.StaticInjectorContext;

public class GuildPlayerList extends Sprite {


    private var num_:int;

    private var offset_:int;

    private var myName_:String;

    private var myRank_:int;

    private var listClient_:AppEngineClient;

    private var loadingText_:SimpleText;

    private var titleText_:SimpleText;

    private var guildHonorText_:SimpleText;

    private var guildHonorIcon_:Bitmap;

    private var lines_:Shape;

    private var mainSprite_:Sprite;

    private var listSprite_:Sprite;

    private var openSlotsText_:SimpleText;

    private var scrollBar_:Scrollbar;

    public function GuildPlayerList(num:int, offset:int, myName:String = "", myRank:int = 0) {
        super();
        this.num_ = num;
        this.offset_ = offset;
        this.myName_ = myName;
        this.myRank_ = myRank;
        this.loadingText_ = new SimpleText(22, 11776947, false, 0, 0);
        this.loadingText_.setBold(true);
        this.loadingText_.text = "Loading...";
        this.loadingText_.useTextDimensions();
        this.loadingText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.loadingText_.x = GameClient.HalfStageWidth - this.loadingText_.width / 2;
        this.loadingText_.y = 600 / 2 - this.loadingText_.height / 2;
        addChild(this.loadingText_);
        var account:Account = StaticInjectorContext.getInjector().getInstance(Account);
        var params:Object = {
            "num": num,
            "offset": offset
        };
        MoreObjectUtil.addToObject(params, account.getCredentials());
        this.listClient_ = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
        this.listClient_.setMaxRetries(2);
        this.listClient_.complete.addOnce(this.onComplete);
        this.listClient_.sendRequest("/guild/listMembers", params);
    }

    private function onComplete(isOK:Boolean, data:*):void {
        if (isOK) {
            this.onGenericData(data);
        } else {
            this.onTextError(data);
        }
    }

    private function onGenericData(data:String):void {
        this.build(XML(data));
    }

    private function onTextError(error:String):void {
        trace("error event: " + error);
    }

    private function build(guildXML:XML):void {
        var g:Graphics = null;
        var id:int = 0;
        var memberXML:XML = null;
        var openSlots:int = 0;
        var isMe:Boolean = false;
        var rank:int = 0;
        var listLine:MemberListLine = null;
        trace("guildXML: " + guildXML);
        removeChild(this.loadingText_);
        this.titleText_ = new SimpleText(32, 11776947, false, 0, 0);
        this.titleText_.setBold(true);
        this.titleText_.text = guildXML.@name;
        this.titleText_.useTextDimensions();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.titleText_.y = 24;
        this.titleText_.x = stage.stageWidth / 2 - this.titleText_.width / 2;
        addChild(this.titleText_);
        this.guildHonorText_ = new SimpleText(22, 16777215, false, 0, 0);
        this.guildHonorText_.text = guildXML.CurrentHonor;
        this.guildHonorText_.useTextDimensions();
        this.guildHonorText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.guildHonorText_.x = 768 - this.guildHonorText_.width;
        this.guildHonorText_.y = 32 / 2 - this.guildHonorText_.height / 2;
        addChild(this.guildHonorText_);
        this.guildHonorIcon_ = new Bitmap(GuildUtil.guildHonorIcon(40));
        this.guildHonorIcon_.x = 760;
        this.guildHonorIcon_.y = 32 / 2 - this.guildHonorIcon_.height / 2;
        addChild(this.guildHonorIcon_);
        this.lines_ = new Shape();
        g = this.lines_.graphics;
        g.clear();
        g.lineStyle(2, 5526612);
        g.moveTo(0, 100);
        g.lineTo(stage.stageWidth, 100);
        g.lineStyle();
        addChild(this.lines_);
        this.mainSprite_ = new Sprite();
        this.mainSprite_.x = 10;
        this.mainSprite_.y = 110;
        var shape:Shape = new Shape();
        g = shape.graphics;
        g.beginFill(0);
        g.drawRect(0, 0, MemberListLine.WIDTH, 430);
        g.endFill();
        this.mainSprite_.addChild(shape);
        this.mainSprite_.mask = shape;
        addChild(this.mainSprite_);
        this.listSprite_ = new Sprite();
        id = 0;
        for each(memberXML in guildXML.Member) {
            isMe = this.myName_ == memberXML.Name;
            rank = memberXML.Rank;
            listLine = new MemberListLine(this.offset_ + id + 1, memberXML.Name, memberXML.Rank, memberXML.Honor, isMe, this.myRank_);
            listLine.y = id * MemberListLine.HEIGHT;
            this.listSprite_.addChild(listLine);
            id++;
        }
        openSlots = GuildUtil.MAX_MEMBERS - (this.offset_ + id);
        this.openSlotsText_ = new SimpleText(22, 11776947, false, 0, 0);
        this.openSlotsText_.text = openSlots + " open slots";
        this.openSlotsText_.useTextDimensions();
        this.openSlotsText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.openSlotsText_.x = MemberListLine.WIDTH / 2 - this.openSlotsText_.width / 2;
        this.openSlotsText_.y = id * MemberListLine.HEIGHT;
        this.listSprite_.addChild(this.openSlotsText_);
        this.mainSprite_.addChild(this.listSprite_);
        if (this.listSprite_.height > 400) {
            this.scrollBar_ = new Scrollbar(16, 400);
            this.scrollBar_.x = GameClient.StageWidth - this.scrollBar_.width - 4;
            this.scrollBar_.y = 104;
            this.scrollBar_.setIndicatorSize(400, this.listSprite_.height);
            this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
            addChild(this.scrollBar_);
        }
    }

    private function onScrollBarChange(event:Event):void {
        this.listSprite_.y = -this.scrollBar_.pos() * (this.listSprite_.height - 400);
    }
}
}
