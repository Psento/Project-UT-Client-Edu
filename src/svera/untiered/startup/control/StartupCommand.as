package svera.untiered.startup.control {
import flash.display.DisplayObjectContainer;

import svera.lib.framework.AppContext;
import svera.lib.framework.ICommand;
import svera.untiered.core.view.Layers;
import svera.untiered.core.view.ScreensView;
import svera.untiered.ui.signals.ShowSplashUISignal;

public class StartupCommand implements ICommand {
    [Inject]
    public var startup:StartupSequence;

    [Inject]
    public var showSplash:ShowSplashUISignal;

    [Inject]
    public var context:AppContext;

    public function StartupCommand() {
        super();
    }

    public function execute():void {
        trace("[StartupCommand] Executing startup sequence...");

        // Initialize the view hierarchy now that all modules are configured
        this.initializeViewHierarchy();

        // Show splash screen
        showSplash.dispatch();
    }

    private function initializeViewHierarchy():void {
        trace("[StartupCommand] Initializing view hierarchy...");

        try {
            // Get the display container that was mapped in GameClient
            var contextView:DisplayObjectContainer = context.injector.getInstance(DisplayObjectContainer);

            if (contextView) {
                // Get or create the Layers instance
                var layers:Layers = context.injector.getInstance(Layers);

                // Add layers to the stage
                contextView.addChild(layers);

                // The views inside Layers are created in its constructor
                // Now we need to create mediators for them
                if (layers.numChildren > 0) {
                    // Get the ScreensView (first child of Layers)
                    var screensView:ScreensView = layers.getChildAt(0) as ScreensView;
                    if (screensView) {
                        // Create the mediator for ScreensView
                        context.mediators.create(screensView);
                        trace("[StartupCommand] ScreensView mediator created");
                    }
                }

                trace("[StartupCommand] View hierarchy initialized successfully");
            } else {
                trace("[StartupCommand] Warning: No DisplayObjectContainer found");
            }
        } catch (error:Error) {
            trace("[StartupCommand] Error initializing view hierarchy: " + error.message);
            trace("[StartupCommand] Continuing without view initialization...");
        }
    }
}
}