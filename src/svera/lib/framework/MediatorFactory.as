package svera.lib.framework {
import org.swiftsuspenders.Injector;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

/**
 * Lightweight Mediator Factory
 * Manages view-mediator lifecycle without reflection overhead
 * Automatically creates mediators when views are added to stage and destroys them when removed
 */
public class MediatorFactory {
    private var _injector:Injector;
    private var _mappings:Dictionary; // viewClass -> mediatorClass
    private var _mediators:Dictionary; // view -> mediator
    private var _autoDestroy:Boolean = true;

    public function MediatorFactory(injector:Injector) {
        _injector = injector;
        _mappings = new Dictionary();
        _mediators = new Dictionary(true); // weak keys for automatic GC
    }

    /**
     * Map a view class to a mediator class
     * @param viewClass The view class to map
     * @param mediatorClass The mediator class that will manage the view
     */
    public function map(viewClass:Class, mediatorClass:Class):void {
        var key:String = getQualifiedClassName(viewClass);
        _mappings[key] = mediatorClass;
    }

    /**
     * Unmap a view class
     * @param viewClass The view class to unmap
     */
    public function unmap(viewClass:Class):void {
        var key:String = getQualifiedClassName(viewClass);
        delete _mappings[key];
    }

    /**
     * Create and initialize a mediator for a view
     * @param view The view instance to mediate
     * @return The created mediator or null if no mapping exists
     */
    public function create(view:DisplayObject):IMediator {
        if (_mediators[view]) {
            return _mediators[view];
        }

        var viewKey:String = getQualifiedClassName(view);
        var mediatorClass:Class = _mappings[viewKey];

        if (!mediatorClass) {
            return null;
        }

        // Create new instance of mediator using 'new'
        var mediator:IMediator = new mediatorClass() as IMediator;
        if (!mediator) {
            throw new Error("Mediator must implement IMediator interface");
        }

        mediator.setView(view);
        _injector.injectInto(mediator);
        _mediators[view] = mediator;

        mediator.initialize();

        // Auto-destroy on removed from stage
        if (_autoDestroy) {
            view.addEventListener(Event.REMOVED_FROM_STAGE, onViewRemoved, false, 0, true);
        }

        return mediator;
    }

    /**
     * Destroy a mediator for a view
     * @param view The view whose mediator should be destroyed
     */
    public function destroy(view:DisplayObject):void {
        var mediator:IMediator = _mediators[view];
        if (mediator) {
            view.removeEventListener(Event.REMOVED_FROM_STAGE, onViewRemoved);
            mediator.destroy();
            delete _mediators[view];
        }
    }

    /**
     * Destroy all active mediators
     */
    public function destroyAll():void {
        for (var view:* in _mediators) {
            destroy(view as DisplayObject);
        }
    }

    /**
     * Get the mediator for a view if it exists
     * @param view The view to get the mediator for
     * @return The mediator or null if none exists
     */
    public function getMediator(view:DisplayObject):IMediator {
        return _mediators[view];
    }

    private function onViewRemoved(e:Event):void {
        destroy(e.currentTarget as DisplayObject);
    }

    /**
     * Enable or disable automatic destruction of mediators when views are removed from stage
     */
    public function set autoDestroy(value:Boolean):void {
        _autoDestroy = value;
    }

    public function get autoDestroy():Boolean {
        return _autoDestroy;
    }
}
}