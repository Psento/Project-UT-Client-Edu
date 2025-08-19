package svera.untiered.ui.view {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getDefinitionByName;
import flash.utils.getTimer;

import org.osflash.signals.Signal;

import svera.untiered.assets.EmbeddedAssets;
import svera.untiered.ui.view.components.ScreenBase;

public class SplashView extends Sprite {
    private static const FADE_DURATION:Number = 2.0;
    private static const DISPLAY_DELAY:Number = 1.0;
    private static const BASE_LOGO_SCALE:Number = 1.0; // Base scale at 800x600

    public var fadeCompleted:Signal;

    private var logo:Bitmap;
    private var isDestroyed:Boolean = false;
    private var fadeHandler:Function;
    private var originalLogoWidth:Number;
    private var originalLogoHeight:Number;

    public function SplashView() {
        super();
        this.fadeCompleted = new Signal();
        this.setupResizeListener();
        this.createEmbeddedLogo();
    }

    private function setupResizeListener():void {
        // Listen for stage resize events, same as ScreenBase
        GameClient.STAGE.addEventListener(Event.RESIZE, this.onResize, false, 0, true);
    }

    private function createEmbeddedLogo():void {
        if (this.isDestroyed) return;

        try {
            // Create logo from embedded asset
            this.logo = new EmbeddedAssets.SplashLogo() as Bitmap;

            if (this.logo) {
                // Store original dimensions before any scaling
                this.originalLogoWidth = this.logo.width;
                this.originalLogoHeight = this.logo.height;
                // Enable bitmap caching for smooth fade performance
                this.logo.cacheAsBitmap = true;

                addChild(this.logo);

                // Position and scale the logo based on current stage size
                this.updateLogoPosition();
            }
        } catch (error:Error) {
            // If embedded asset fails, continue without logo
            trace("SplashView: Failed to load embedded logo:", error.message);
        }

        // Start fade sequence regardless of logo success
        this.startFadeSequence();
    }

    private function onResize(event:Event):void {
        if (this.isDestroyed || !this.logo) return;

        // Update logo position and scale when stage resizes
        this.updateLogoPosition();
    }

    private function updateLogoPosition():void {
        if (!this.logo) return;

        // Calculate scale based on stage size (similar to how other UI elements scale)
        var stageWidth:Number = GameClient.StageWidth || 800;
        var stageHeight:Number = GameClient.StageHeight || 600;

        // Scale logo proportionally based on stage size
        // Use the smaller ratio to maintain aspect ratio
        var scaleX:Number = stageWidth / 800;
        var scaleY:Number = stageHeight / 600;
        var scale:Number = Math.min(scaleX, scaleY) * BASE_LOGO_SCALE;

        // Apply the scale
        this.logo.scaleX = scale;
        this.logo.scaleY = scale;

        // Center the scaled logo on stage
        this.logo.x = (stageWidth / 2) - (this.originalLogoWidth * scale / 2);
        this.logo.y = (stageHeight / 2) - (this.originalLogoHeight * scale / 2);
    }

    private function startFadeSequence():void {
        if (this.isDestroyed) return;

        // Use TweenLite if available, otherwise use simple timer-based fade
        if (this.isTweenLiteAvailable()) {
            this.startTweenLiteFade();
        } else {
            this.startManualFade();
        }
    }

    private function isTweenLiteAvailable():Boolean {
        try {
            // Try to access TweenLite class
            var tweenLiteClass:Class = getDefinitionByName("com.greensock.TweenLite") as Class;
            return tweenLiteClass != null;
        } catch (error:Error) {
            return false;
        }
    }

    private function startTweenLiteFade():void {
        if (this.isDestroyed) return;

        // Use TweenLite for smooth fade
        var tweenLiteClass:Class = getDefinitionByName("com.greensock.TweenLite") as Class;
        tweenLiteClass.to(this.logo, FADE_DURATION, {
            alpha: 0,
            delay: DISPLAY_DELAY,
            onComplete: this.onFadeComplete
        });
    }

    private function startManualFade():void {
        if (this.isDestroyed) return;

        // Fallback: Manual fade using ENTER_FRAME
        var fadeStartTime:Number = -1;
        var displayStartTime:Number = getTimer();
        var self:SplashView = this;

        this.fadeHandler = function(event:Event):void {
            if (self.isDestroyed) {
                self.removeEventListener(Event.ENTER_FRAME, self.fadeHandler);
                return;
            }

            var currentTime:Number = getTimer();

            // Wait for display delay
            if (currentTime - displayStartTime < DISPLAY_DELAY * 1000) {
                return;
            }

            // Initialize fade start time
            if (fadeStartTime == -1) {
                fadeStartTime = currentTime;
            }

            // Calculate fade progress
            var fadeElapsed:Number = (currentTime - fadeStartTime) / 1000;
            var fadeProgress:Number = Math.min(fadeElapsed / FADE_DURATION, 1.0);

            // Apply alpha
            if (self.logo) {
                self.logo.alpha = 1.0 - fadeProgress;
            }

            // Check if fade is complete
            if (fadeProgress >= 1.0) {
                self.removeEventListener(Event.ENTER_FRAME, self.fadeHandler);
                self.onFadeComplete();
            }
        };

        addEventListener(Event.ENTER_FRAME, this.fadeHandler);
    }

    private function onFadeComplete():void {
        if (this.isDestroyed) return;

        // Dispatch signal first, then cleanup
        if (this.fadeCompleted) {
            this.fadeCompleted.dispatch();
        }

        this.cleanupAssets();
    }

    private function cleanupAssets():void {
        // Remove logo from stage
        if (this.logo && this.logo.parent) {
            this.logo.parent.removeChild(this.logo);
        }

        // Remove manual fade event listener if it exists
        if (this.fadeHandler) {
            removeEventListener(Event.ENTER_FRAME, this.fadeHandler);
            this.fadeHandler = null;
        }

        // Nullify references for garbage collection
        this.logo = null;
    }

    public function destroy():void {
        this.isDestroyed = true;

        this.cleanupAssets();

        if (this.fadeCompleted) {
            this.fadeCompleted.removeAll();
            this.fadeCompleted = null;
        }
    }
}
}