package svera.lib.framework {
import org.swiftsuspenders.Injector;
import flash.display.DisplayObject;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

/**
 * Lightweight Application Context
 * Replaces Robotlegs with minimal overhead while maintaining DI and modularity
 */
public class AppContext {
    private var _injector:Injector;
    private var _mediatorFactory:MediatorFactory;
    private var _commandBus:CommandBus;
    private var _modules:Vector.<IModule>;
    private var _initialized:Boolean = false;

    public function AppContext() {
        _injector = new Injector();
        _mediatorFactory = new MediatorFactory(_injector);
        _commandBus = new CommandBus(_injector);
        _modules = new Vector.<IModule>();

        // Map core services
        _injector.map(Injector).toValue(_injector);
        _injector.map(AppContext).toValue(this);
        _injector.map(MediatorFactory).toValue(_mediatorFactory);
        _injector.map(CommandBus).toValue(_commandBus);
    }

    public function get injector():Injector {
        return _injector;
    }

    public function get mediators():MediatorFactory {
        return _mediatorFactory;
    }

    public function get commands():CommandBus {
        return _commandBus;
    }

    /**
     * Register a module for configuration
     */
    public function install(module:IModule):AppContext {
        if (_initialized) {
            throw new Error("Cannot install modules after initialization");
        }
        _modules.push(module);
        return this;
    }

    /**
     * Initialize the application context
     */
    public function initialize():void {
        if (_initialized) return;

        // Configure all modules
        for each (var module:IModule in _modules) {
            module.configure(this);
        }

        _initialized = true;
    }

    /**
     * Clean shutdown
     */
    public function destroy():void {
        _mediatorFactory.destroyAll();
        _commandBus.destroy();
        _modules.length = 0;
        _initialized = false;
    }
}
}