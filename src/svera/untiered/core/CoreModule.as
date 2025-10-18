package svera.untiered.core {
import org.swiftsuspenders.Injector;
import flash.display.DisplayObjectContainer;

import svera.lib.framework.AppContext;
import svera.lib.framework.IModule;
import svera.lib.json.JsonParser;
import svera.lib.json.SoftwareJsonParser;
import svera.lib.tasks.TaskMonitor;
import svera.untiered.account.core.signals.CharListDataSignal;
import svera.untiered.core.commands.InvalidateDataCommand;
import svera.untiered.core.commands.SetScreenWithValidDataCommand;
import svera.untiered.core.commands.UpdatePlayerModelCommand;
import svera.untiered.core.model.MapModel;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.model.ScreenModel;
import svera.untiered.core.signals.*;
import svera.untiered.core.view.Layers;
import svera.untiered.core.view.ScreensMediator;
import svera.untiered.core.view.ScreensView;
import svera.untiered.startup.control.StartupSequence;

/**
 * Core Module - Replaces CoreConfig
 * Configures the core application models, commands, and views
 */
public class CoreModule implements IModule {

    public function configure(context:AppContext):void {
        var injector:Injector = context.injector;

        // Models - singleton pattern
        injector.map(PlayerModel).asSingleton();
        injector.map(MapModel).asSingleton();
        injector.map(ScreenModel).asSingleton();

        // Services
        injector.map(JsonParser).toSingleton(SoftwareJsonParser);
        injector.map(TaskMonitor).asSingleton();

        // Signals
        injector.map(SetScreenSignal).asSingleton();
        injector.map(GotoPreviousScreenSignal).asSingleton();
        injector.map(LaunchGameSignal).asSingleton();
        injector.map(ShowTooltipSignal).asSingleton();
        injector.map(HideTooltipsSignal).asSingleton();
        injector.map(SetLoadingMessageSignal).asSingleton();
        injector.map(UpdateNewCharacterScreenSignal).asSingleton();
        injector.map(SetScreenWithValidDataSignal).asSingleton();
        injector.map(InvalidateDataSignal).asSingleton();
        injector.map(CharListDataSignal).asSingleton();

        // Command mappings
        context.commands.map(InvalidateDataSignal).toCommand(InvalidateDataCommand);
        context.commands.map(SetScreenWithValidDataSignal).toCommand(SetScreenWithValidDataCommand);
        context.commands.map(CharListDataSignal).toCommand(UpdatePlayerModelCommand);

        // Mediator mappings
        context.mediators.map(ScreensView, ScreensMediator);

        // Map Layers as a singleton so it can be created later
        injector.map(Layers).asSingleton();
    }
}
}