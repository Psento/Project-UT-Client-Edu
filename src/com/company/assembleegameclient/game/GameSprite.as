package com.company.assembleegameclient.game {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.IInteractiveObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.TextBox;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.CachingColorTransformer;
import com.company.util.PointUtil;

import flash.display.Sprite;
import flash.events.Event;
import flash.external.ExternalInterface;
import flash.utils.getTimer;

import org.osflash.signals.Signal;

import svera.lib.loopedprocs.LoopedCallback;
import svera.lib.loopedprocs.LoopedProcess;
import svera.untiered.constants.GeneralConstants;
import svera.untiered.core.model.MapModel;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.game.view.CurrencyDisplay;
import svera.untiered.messaging.impl.GameServerConnection;
import svera.untiered.messaging.impl.incoming.MapInfo;
import svera.untiered.stage3D.Renderer;
import svera.untiered.ui.UIUtils;
import svera.untiered.ui.view.HUDView;

public class GameSprite extends Sprite {
    public const closed:Signal = new Signal();
    public const modelInitialized:Signal = new Signal();
    public const drawCharacterWindow:Signal = new Signal(Player);
    public var map:Map;
    public var camera_:Camera;
    public var gsc_:GameServerConnection;
    public var mui_:MapUserInput;
    public var textBox_:TextBox;
    public var isNexus_:Boolean = false;
    public var hudView:HUDView;
    public var rankText_:RankText;
    public var guildText_:GuildText;
    public var currencyDisplay_:CurrencyDisplay;
    public var isEditor:Boolean;
    public var lastUpdate_:int = 0;
    public var firstUpdate:Boolean = true;
    public var mapModel:MapModel;
    public var model:PlayerModel;
    private var focus:GameObject;
    private var isGameStarted:Boolean;
    private var displaysPosY:uint = 4;



    public function GameSprite(gameId:int, createCharacter:Boolean, charId:int, model:PlayerModel, mapJSON:String, traits:Array) {
        this.camera_ = new Camera();
        super();
        this.model = model;
        this.map = new Map(this);
        addChild(this.map);
        this.gsc_ = new GameServerConnection(this, gameId, createCharacter, charId, mapJSON, traits);
        this.mui_ = new MapUserInput(this);
        this.textBox_ = new TextBox(this, 600, 600);
        addChild(this.textBox_);
    }

    public function setFocus(focus:GameObject):void {
        this.focus = focus || this.map.player_;
    }

    public function applyMapInfo(mapInfo:MapInfo):void {
        this.map.setProps(mapInfo.width_, mapInfo.height_, mapInfo.name_, mapInfo.background_, mapInfo.allowPlayerTeleport_, mapInfo.showDisplays_);
    }

    public function hudModelInitialized():void {
        this.hudView = new HUDView();
        addChild(this.hudView);
    }

    public function initialize():void {
        this.map.initialize();
        this.currencyDisplay_ = new CurrencyDisplay(this);
        this.currencyDisplay_.x = 0;
        this.currencyDisplay_.y = 50;
        addChild(this.currencyDisplay_);
        this.modelInitialized.dispatch();

        if (this.map.showDisplays_) {
            this.showSafeAreaDisplays();
        }
        GameClient.STAGE.dispatchEvent(new Event(Event.RESIZE));
        if (this.map.name_ == "Nexus") {
            isNexus_ = true;
        }
    }

    public function onScreenResize(_arg_1:Event):void {
        var uiscale:Boolean = true;//Parameters.data_.uiscale;
        var sWidth:Number = 1;
        var sHeight:Number = 1;
        var result:Number = sWidth / sHeight;
        if (this.map != null && !Parameters.data_.GPURender) {
/*            this.map.scaleX = sWidth * Parameters.data_.mScale;
            this.map.scaleY = sHeight * Parameters.data_.mScale;*/
        }
        /*         if (this.scaledLayer != null) {
                    if (uiscale) {
                       this.scaledLayer.scaleX = result;
                       this.scaledLayer.scaleY = 1;
                    } else {
                       this.scaledLayer.scaleX = sWidth;
                       this.scaledLayer.scaleY = sHeight;
                    }
                    this.scaledLayer.x = 400 - ((800 * this.scaledLayer.scaleX) / 2);
                    this.scaledLayer.y = 300 - ((600 * this.scaledLayer.scaleY) / 2);
                 }
                 if (this.forceScaledLayer != null) {
                    this.forceScaledLayer.scaleX = result;
                    this.forceScaledLayer.scaleY = 1;
                 }
                 if (this.bossHealthBar != null)
                 {
                    if (uiscale)
                    {
                       this.bossHealthBar.scaleX = result;
                       this.bossHealthBar.scaleY = 1;
                    }
                    else
                    {
                       this.bossHealthBar.scaleX = sWidth;
                       this.bossHealthBar.scaleY = sHeight;
                    }
                 }*/
        if (this.hudView != null) {
            /*            if (!Parameters.data_.hudscale) {
                           this.hudView.scaleX = result;
                           this.hudView.scaleY = 1;
                           this.hudView.y = 0;
                        } else {*/
            this.hudView.scaleX = sWidth;
            this.hudView.scaleY = sHeight;
            //this.hudView.y = (300 * (1 - sHeight));
            //}
            //this.hudView.x = (800 - (200 * this.hudView.scaleX));
            if (this.currencyDisplay_ != null) {
                this.currencyDisplay_.x = currencyDisplay_.width + 8;
                currencyDisplay_.y = 25;
            }
        }
        if (this.textBox_ != null) {
            if (uiscale) {
                this.textBox_.scaleX = result;
                this.textBox_.scaleY = 1;
                this.textBox_.y = 0;
            } else {
                this.textBox_.scaleX = sWidth;
                this.textBox_.scaleY = sHeight;
                this.textBox_.y = 600 * (1 - sHeight);
            }
            //trace("resize",chatBox_.y,chatBox_.list.y)
        }
        if (this.rankText_ != null) {
            if (uiscale) {
                this.rankText_.scaleX = result;
                this.rankText_.scaleY = 1;
            } else {
                this.rankText_.scaleX = sWidth;
                this.rankText_.scaleY = sHeight;
            }
            this.rankText_.x = 8 * this.rankText_.scaleX;
            this.rankText_.y = 2 * this.rankText_.scaleY;
        }
        if (this.guildText_ != null) {
            if (uiscale) {
                this.guildText_.scaleX = result;
                this.guildText_.scaleY = 1;
            } else {
                this.guildText_.scaleX = sWidth;
                this.guildText_.scaleY = sHeight;
            }
            this.guildText_.x = 64 * this.guildText_.scaleX;
            this.guildText_.y = 2 * this.guildText_.scaleY;
        }
        if (this.currencyDisplay_ != null) {
            if (uiscale) {
                this.currencyDisplay_.scaleX = result;
                this.currencyDisplay_.scaleY = 1;
            } else {
                this.currencyDisplay_.scaleX = sWidth;
                this.currencyDisplay_.scaleY = sHeight;
            }
        }
    }

    private function showSafeAreaDisplays():void {
        this.showRankText();
        this.showGuildText();
    }

    private function showGuildText():void {
        this.guildText_ = new GuildText("", -1);
        this.guildText_.x = 64;
        this.guildText_.y = 6;
        addChild(this.guildText_);
    }

    private function showRankText():void {
        this.rankText_ = new RankText(-1, true, false);
        this.rankText_.x = 8;
        this.rankText_.y = this.displaysPosY;
        this.displaysPosY = this.displaysPosY + UIUtils.NOTIFICATION_SPACE;
        addChild(this.rankText_);
    }

    private function callTracking(functionName:String):void {
        if (ExternalInterface.available == false) {
            return;
        }
        try {
            ExternalInterface.call(functionName);
        } catch (err:Error) {
        }
    }

    private function updateNearestInteractive():void {
        var dist:Number = NaN;
        var go:GameObject = null;
        var iObj:IInteractiveObject = null;
        if (!this.map || !this.map.player_) {
            return;
        }
        var player:Player = this.map.player_;
        var minDist:Number = GeneralConstants.MAXIMUM_INTERACTION_DISTANCE;
        var closestInteractive:IInteractiveObject = null;
        var playerX:Number = player.x_;
        var playerY:Number = player.y_;
        for each(go in this.map.goDict_) {
            iObj = go as IInteractiveObject;
            if (iObj) {
                if (Math.abs(playerX - go.x_) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE || Math.abs(playerY - go.y_) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE) {
                    dist = PointUtil.distanceXY(go.x_, go.y_, playerX, playerY);
                    if (dist < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE && dist < minDist) {
                        minDist = dist;
                        closestInteractive = iObj;
                    }
                }
            }
        }
        this.mapModel.currentInteractiveTarget = closestInteractive;
    }

    public function connect():void {
        if (!this.isGameStarted) {
            this.isGameStarted = true;
            Renderer.inGame = true;
            this.gsc_.connect();
            this.lastUpdate_ = getTimer();
            stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            GameClient.STAGE.addEventListener(Event.RESIZE, onScreenResize);
            LoopedProcess.addProcess(new LoopedCallback(100, this.updateNearestInteractive));
        }
    }

    public function disconnect():void {
        if (this.isGameStarted) {
            this.isGameStarted = false;
            Renderer.inGame = false;
            this.gsc_.serverConnection.disconnect();
            stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            GameClient.STAGE.removeEventListener(Event.RESIZE, onScreenResize);
            LoopedProcess.destroyAll();
            contains(this.map) && removeChild(this.map);
            this.map.dispose();
            CachingColorTransformer.clear();
            TextureRedrawer.clearCache();
            this.gsc_.disconnect();
        }
    }

    private function onEnterFrame(event:Event):void {
        var time:int = getTimer();
        var player:Player = this.map.player_;
        if (player != null) {
            var dt:int = time - this.lastUpdate_;
            LoopedProcess.runProcesses(time);
            this.map.update(time, dt);
            this.camera_.update(dt);

            if (this.focus) {
                this.camera_.configureCamera(this.focus, player.isHallucinating());
                this.map.draw(this.camera_, time);
            }

            this.currencyDisplay_.draw(model.getTsavorite(), model.getMedallions(), model.getHonor(), model.getFame());
            this.drawCharacterWindow.dispatch(player);
            if (this.map.showDisplays_) {
                this.rankText_.draw(player.numStars_);
                this.guildText_.draw(player.guildName_, player.guildRank_);
            }
        }
        this.lastUpdate_ = time;
    }
}
}
