package {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.StageProxy;

import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.LogLevel;

import svera.lib.net.NetConfig;
import svera.untiered.account.AccountConfig;
import svera.untiered.appengine.AppEngineConfig;
import svera.untiered.assets.AssetsConfig;
import svera.untiered.characters.CharactersConfig;
import svera.untiered.classes.ClassesConfig;
import svera.untiered.core.CoreConfig;
import svera.untiered.core.StaticInjectorContext;
import svera.untiered.death.DeathConfig;
import svera.untiered.dialogs.DialogsConfig;
import svera.untiered.honor.HonorConfig;
import svera.untiered.game.GameConfig;
import svera.untiered.hud.HUDConfig;
import svera.untiered.legends.LegendsConfig;
import svera.untiered.minimap.MiniMapConfig;
import svera.untiered.stage3D.Renderer;
import svera.untiered.stage3D.Stage3DConfig;
import svera.untiered.startup.StartupConfig;
import svera.untiered.startup.control.StartupSignal;
import svera.untiered.tooltips.TooltipsConfig;
import svera.untiered.ui.UIConfig;
import svera.untiered.ui.UIUtils;

[SWF(frameRate="60", backgroundColor="#0", width="800", height="600")]
public class GameClient extends Sprite {
    public static var STAGE:Stage;

    protected var context:IContext;
    public static var StageWidth:int;
    public static var StageHeight:int;
    public static var HalfStageWidth:int;
    public static var HalfStageHeight:int;

    public function GameClient() {
        super();
        if (stage) {
            this.setup();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }
    }

    private function onAddedToStage(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        this.setup();
    }


    private function setup():void {
        STAGE = stage;
        STAGE.scaleMode = StageScaleMode.NO_SCALE;
        STAGE.align = StageAlign.TOP_LEFT;
        onResize(null);
        STAGE.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
        STAGE.addEventListener(Event.RESIZE, onResize);
        STAGE.addEventListener(Event.ENTER_FRAME, onEnterFrame);

        new AssetLoader().load();

        this.hackParameters();
        this.createContext();

        var startup:StartupSignal = this.context.injector.getInstance(StartupSignal);
        startup.dispatch();

        UIUtils.toggleQuality(Parameters.data_.quality);
    }

    private function onEnterFrame(event:Event):void {
        SoundEffectLibrary.clear();
    }

    private function onResize(event:Event):void {
        StageWidth = stage.stageWidth;
        StageHeight = stage.stageHeight;
        HalfStageWidth = StageWidth * 0.5;
        HalfStageHeight = StageHeight * 0.5;

        if (Renderer.inGame) {
            /*            scaleX = StageWidth / 800.0;
                        scaleY = StageHeight / 600.0;*/
            scaleX = 1
            scaleY = 1
            Camera.adjustDimensions();
            Stage3DConfig.Dimensions();
            /*            x = (800 - stage.stageWidth) / 2.0;
                        y = (600 - stage.stageHeight) / 2.0;*/
        } else {
            //ScreenBase.OnResize(null);
            //AccountScreen.resize(null);
            scaleX = 1;
            scaleY = 1;
            x = 0;
            y = 0;
        }
    }

    private static function onRightClick(event:MouseEvent):void {
        //suppress context menu
    }

    private static function onEnterFrame(event:Event):void {
        SoundEffectLibrary.clear();
    }

    private function hackParameters():void {
        Parameters.root = stage.root;
    }

    private function createContext():void {
        var stageProxy:StageProxy = new StageProxy(this);
        this.context = new StaticInjectorContext();
        this.context.injector.map(LoaderInfo).toValue(root.stage.root.loaderInfo);
        this.context.injector.map(StageProxy).toValue(stageProxy);
        this.context
                .extend(MVCSBundle)
                .extend(SignalCommandMapExtension)
                .configure(StartupConfig)
                .configure(NetConfig)
                .configure(AssetsConfig)
                .configure(DialogsConfig)
                .configure(AppEngineConfig)
                .configure(AccountConfig)
                .configure(CoreConfig)
                .configure(DeathConfig)
                .configure(CharactersConfig)
                .configure(GameConfig)
                .configure(UIConfig)
                .configure(MiniMapConfig)
                .configure(LegendsConfig)
                .configure(HonorConfig)
                .configure(TooltipsConfig)
                .configure(ClassesConfig)
                .configure(Stage3DConfig)
                .configure(HUDConfig)
                .configure(this);
        this.context.logLevel = LogLevel.DEBUG;
    }
}
}
