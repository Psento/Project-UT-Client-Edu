package {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.StageProxy;

import flash.display.DisplayObjectContainer;
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import svera.lib.framework.AppContext;
import svera.lib.resizing.signals.Resize;
import svera.untiered.account.AccountModule;
import svera.untiered.appengine.AppEngineModule;
import svera.untiered.core.StaticInjectorContext;
import svera.untiered.assets.AssetsModule;
import svera.untiered.characters.CharactersModule;
import svera.untiered.classes.ClassesModule;
import svera.untiered.core.CoreModule;
import svera.untiered.death.DeathModule;
import svera.untiered.dialogs.DialogsModule;
import svera.untiered.game.GameModule;
import svera.untiered.honor.HonorModule;
import svera.untiered.hud.HUDModule;
import svera.untiered.legends.LegendsModule;
import svera.untiered.minimap.MiniMapModule;
import svera.lib.net.NetModule;
import svera.untiered.stage3D.Renderer;
import svera.untiered.stage3D.Stage3DModule;
import svera.untiered.startup.StartupModule;
import svera.untiered.startup.control.StartupSignal;
import svera.untiered.tooltips.TooltipsModule;
import svera.untiered.ui.UIModule;
import svera.untiered.ui.UIUtils;

[SWF(frameRate="60", backgroundColor="#0", width="800", height="600")]
public class GameClient extends Sprite {
    public static var STAGE:Stage;
    public static var StageWidth:int;
    public static var StageHeight:int;
    public static var HalfStageWidth:int;
    public static var HalfStageHeight:int;

    private var context:AppContext;
    private var resizeSignal:Resize;

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

        this.resizeSignal = this.context.injector.getInstance(Resize);

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
            scaleX = 1;
            scaleY = 1;
            // If you have these methods, uncomment:
            // Camera.adjustDimensions();
            // Stage3DModule.adjustDimensions();
        } else {
            scaleX = 1;
            scaleY = 1;
            x = 0;
            y = 0;
        }

        if (this.resizeSignal) {
            var rect:Rectangle = new Rectangle(0, 0, StageWidth, StageHeight);
            this.resizeSignal.dispatch(rect);
        }
    }

    private static function onRightClick(event:MouseEvent):void {
        // Suppress context menu
    }

    private function hackParameters():void {
        Parameters.root = stage.root;
    }

    private function createContext():void {
        var stageProxy:StageProxy = new StageProxy(this);

        // Create new lightweight context
        this.context = new AppContext();

        // Initialize StaticInjectorContext for legacy code
        StaticInjectorContext.injector = this.context.injector;

        this.context.injector.map(DisplayObjectContainer).toValue(this);

        // Map other core dependencies
        this.context.injector.map(LoaderInfo).toValue(root.stage.root.loaderInfo);
        this.context.injector.map(StageProxy).toValue(stageProxy);

        // Install all modules (order matters for dependencies)
        this.context
                .install(new StartupModule())
                .install(new NetModule())
                .install(new AssetsModule())
                .install(new DialogsModule())
                .install(new AppEngineModule())
                .install(new AccountModule())
                .install(new CoreModule())
                .install(new DeathModule())
                .install(new CharactersModule())
                .install(new GameModule())
                .install(new UIModule())
                .install(new MiniMapModule())
                .install(new LegendsModule())
                .install(new HonorModule())
                .install(new TooltipsModule())
                .install(new ClassesModule())
                .install(new Stage3DModule())
                .install(new HUDModule());

        // Initialize the context
        this.context.initialize();
    }
}
}