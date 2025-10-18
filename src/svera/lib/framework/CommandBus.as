package svera.lib.framework {
import org.swiftsuspenders.Injector;
import org.osflash.signals.Signal;
import flash.utils.Dictionary;

/**
 * Command Bus - Signal-to-Command mapping
 * Replaces Robotlegs SignalCommandMap with minimal overhead
 */
public class CommandBus {
    private var _injector:Injector;
    private var _mappings:Dictionary; // signal -> CommandMapping[]

    public function CommandBus(injector:Injector) {
        _injector = injector;
        _mappings = new Dictionary();
    }

    /**
     * Map a signal to a command
     */
    public function map(signalClass:Class):CommandMapping {
        var signal:Signal = _injector.getInstance(signalClass) as Signal;
        if (!signal) {
            throw new Error("Signal must be mapped in injector first");
        }

        if (!_mappings[signal]) {
            _mappings[signal] = new Vector.<CommandMapping>();
        }

        var mapping:CommandMapping = new CommandMapping(signal, _injector);
        _mappings[signal].push(mapping);

        signal.add(mapping.execute);

        return mapping;
    }

    /**
     * Unmap a signal
     */
    public function unmap(signalClass:Class):void {
        var signal:Signal = _injector.getInstance(signalClass) as Signal;
        if (!signal || !_mappings[signal]) return;

        var mappings:Vector.<CommandMapping> = _mappings[signal];
        for each (var mapping:CommandMapping in mappings) {
            signal.remove(mapping.execute);
        }

        delete _mappings[signal];
    }

    public function destroy():void {
        for (var signal:* in _mappings) {
            var mappings:Vector.<CommandMapping> = _mappings[signal];
            for each (var mapping:CommandMapping in mappings) {
                (signal as Signal).remove(mapping.execute);
            }
        }
        _mappings = new Dictionary();
    }
}
}