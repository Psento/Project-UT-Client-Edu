package svera.lib.framework {
import org.swiftsuspenders.Injector;
import org.osflash.signals.Signal;

/**
 * Command Mapping - holds command execution configuration
 * Provides fluent API for configuring command behavior (guards, once execution, etc.)
 */
public class CommandMapping {
    private var _signal:Signal;
    private var _injector:Injector;
    private var _commandClass:Class;
    private var _guards:Vector.<Class>;
    private var _once:Boolean = false;

    public function CommandMapping(signal:Signal, injector:Injector) {
        _signal = signal;
        _injector = injector;
        _guards = new Vector.<Class>();
    }

    /**
     * Set the command class to execute when signal is dispatched
     * @param commandClass The command class (must implement ICommand)
     * @return This mapping for chaining
     */
    public function toCommand(commandClass:Class):CommandMapping {
        _commandClass = commandClass;
        return this;
    }

    /**
     * Add guards to check before command execution
     * Guards are checked in order, and all must approve for command to execute
     * @param guards One or more guard classes (must implement IGuard)
     * @return This mapping for chaining
     */
    public function withGuards(...guards):CommandMapping {
        for each (var guard:Class in guards) {
            _guards.push(guard);
        }
        return this;
    }

    /**
     * Execute command only once, then automatically unmap
     * @return This mapping for chaining
     */
    public function once():CommandMapping {
        _once = true;
        return this;
    }

    /**
     * Get the command class for this mapping
     * @return The command class
     */
    public function get commandClass():Class {
        return _commandClass;
    }

    /**
     * Execute the command (called by signal dispatch)
     * Checks guards, creates command instance, injects dependencies, and executes
     * @param args Signal parameters passed to command
     */
    public function execute(...args):void {
        trace("[CommandMapping] execute() called for command:", _commandClass);
        // Check guards
        for each (var guardClass:Class in _guards) {
            var guard:IGuard = _injector.getInstance(guardClass) as IGuard;
            if (guard && !guard.approve()) {
                trace("[CommandMapping] Guard rejected:", guardClass);
                return; // Guard rejected, don't execute command
            }
        }

        // Create and execute command
        if (_commandClass) {

            var command:* = new _commandClass();

            var typedCommand:ICommand = command as ICommand;

            if (typedCommand) {
                _injector.injectInto(typedCommand);
                typedCommand.execute();
            }
        }

        // Remove mapping if once is set
        if (_once) {
            _signal.remove(execute);
        }
    }
}
}