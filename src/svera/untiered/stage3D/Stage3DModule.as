// FILE: src/svera/untiered/stage3D/Stage3DModule.as
package svera.untiered.stage3D {
import com.company.assembleegameclient.engine3d.Model3D;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.Stage3DProxy;
import com.company.assembleegameclient.util.StageProxy;

import flash.display3D.Context3DBlendFactor;
import flash.display3D.Context3DCompareMode;
import flash.events.ErrorEvent;
import flash.events.Event;

import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;
import svera.lib.framework.IModule;
import svera.untiered.stage3D.graphic3D.Graphic3D;
import svera.untiered.stage3D.graphic3D.Graphic3DHelper;
import svera.untiered.stage3D.graphic3D.IndexBufferFactory;
import svera.untiered.stage3D.graphic3D.TextureFactory;
import svera.untiered.stage3D.graphic3D.VertexBufferFactory;
import svera.untiered.stage3D.proxies.Context3DProxy;

public class Stage3DModule implements IModule {

    public static var WIDTH:int = 600;
    public static var HALF_WIDTH:int = WIDTH / 2;
    public static var HEIGHT:int = 600;
    public static var HALF_HEIGHT:int = HEIGHT / 2;

    private var stageProxy:StageProxy;
    private var renderer:Renderer;
    private var stage3D:Stage3DProxy;

    // ⭐ Store injector reference instead of using StaticInjectorContext
    private var injector:Injector;

    public static function Dimensions():void {
        var mscale:Number = Parameters.data_.mScale;
        var WidthScaled:Number = GameClient.StageWidth / mscale;
        var HeightScaled:Number = GameClient.StageHeight / mscale;
        WIDTH = WidthScaled;
        HALF_WIDTH = WidthScaled / 2;
        HEIGHT = HeightScaled;
        HALF_HEIGHT = HeightScaled / 2;
    }

    public function configure(context:AppContext):void {
        // ⭐ Store the injector for later use
        this.injector = context.injector;

        // Get stage proxy from injector
        this.stageProxy = context.injector.getInstance(StageProxy);

        // Map singletons
        this.mapSingletons(context);

        // Initialize Stage3D
        this.stage3D = this.stageProxy.getStage3Ds(0);
        this.stage3D.addEventListener(ErrorEvent.ERROR, Parameters.clearGpuRenderEvent);
        this.stage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreate);
        this.stage3D.requestContext3D();
    }

    private function mapSingletons(context:AppContext):void {
        context.injector.map(Renderer).asSingleton();
        context.injector.map(Graphic3D).asSingleton();
        context.injector.map(Render3D).asSingleton();
        context.injector.map(TextureFactory).asSingleton();
        context.injector.map(IndexBufferFactory).asSingleton();
        context.injector.map(VertexBufferFactory).asSingleton();
    }

    private function onContextCreate(e:Event):void {
        this.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreate);
        var context3D:Context3DProxy = this.stage3D.getContext3D();

        if (context3D.GetContext3D().driverInfo.toLowerCase().indexOf("software") != -1) {
            Parameters.clearGpuRender();
        }

        context3D.configureBackBuffer(WIDTH, HEIGHT, 2);
        context3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
        context3D.setDepthTest(false, Context3DCompareMode.LESS_EQUAL);

        // Use stored injector instead of StaticInjectorContext
        this.injector.map(Context3DProxy).toValue(context3D);

        // Map Graphic3D helper BEFORE creating Renderer
        // This sets up IndexBuffer3DProxy and VertexBuffer3DProxy providers
        Graphic3DHelper.map(this.injector);

        // Get the renderer and initialize with unwrapped Context3D
        this.renderer = this.injector.getInstance(Renderer);
        this.renderer.init(context3D.GetContext3D());

        // Initialize Model3D buffers
        Model3D.Create3dBuffer(context3D.GetContext3D());
    }
}
}