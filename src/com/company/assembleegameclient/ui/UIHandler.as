package com.company.assembleegameclient.ui {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Point;
import flash.utils.Dictionary;

/**
 * Simple UIHandler for consistent UI positioning and scaling
 * Models behavior after the working SplashView scaling logic
 */
public class UIHandler {
    private static var _instance:UIHandler;

    // Reference resolution - your game's base design size
    public static const BASE_WIDTH:Number = 800;
    public static const BASE_HEIGHT:Number = 600;

    // Anchor types
    public static const TOP_LEFT:String = "top-left";
    public static const TOP_CENTER:String = "top-center";
    public static const TOP_RIGHT:String = "top-right";
    public static const CENTER_LEFT:String = "center-left";
    public static const CENTER:String = "center";
    public static const CENTER_RIGHT:String = "center-right";
    public static const BOTTOM_LEFT:String = "bottom-left";
    public static const BOTTOM_CENTER:String = "bottom-center";
    public static const BOTTOM_RIGHT:String = "bottom-right";

    private var elements:Dictionary = new Dictionary(true);

    public function UIHandler() {
        if (_instance != null) {
            throw new Error("UIHandler is singleton");
        }
    }

    public static function getInstance():UIHandler {
        if (_instance == null) {
            _instance = new UIHandler();
        }
        return _instance;
    }

    /**
     * Register an element for automatic positioning
     * @param element The display object to manage
     * @param anchor Where to anchor it ("top-left", "center", etc.)
     * @param offsetX Pixel offset from anchor point
     * @param offsetY Pixel offset from anchor point
     * @param shouldScale Whether element should scale with resolution
     */
    public function register(element:DisplayObject, anchor:String = "top-left", offsetX:Number = 0, offsetY:Number = 0, shouldScale:Boolean = true):void {
        // Debug: Log registration attempts
        trace("UIHandler.register() called for element:", element, "anchor:", anchor);
        trace("UIHandler: Initial element size:", element.width + "x" + element.height);

        // If element is already registered, unregister it first to avoid conflicts
        if (elements[element]) {
            trace("UIHandler: Element was already registered, replacing registration");
            delete elements[element];
        }

        var config:Object = {
            anchor: anchor,
            offsetX: offsetX,
            offsetY: offsetY,
            shouldScale: shouldScale,
            originalWidth: element.width,
            originalHeight: element.height
        };

        elements[element] = config;

        // If element has no dimensions yet, wait for it to be sized
        if (element.width <= 0 || element.height <= 0) {
            trace("UIHandler: Element has no dimensions, waiting for sizing...");
            var frameCount:int = 0;
            element.addEventListener(Event.ENTER_FRAME, function checkSize(e:Event):void {
                frameCount++;
                trace("UIHandler: Frame", frameCount + ", element size:", element.width + "x" + element.height);
                if (element.width > 0 && element.height > 0) {
                    element.removeEventListener(Event.ENTER_FRAME, checkSize);
                    trace("UIHandler: Element sized after", frameCount, "frames, positioning now");
                    updateElement(element);
                } else if (frameCount > 10) {
                    // Give up after 10 frames
                    element.removeEventListener(Event.ENTER_FRAME, checkSize);
                    trace("UIHandler: Giving up on sizing after 10 frames, positioning anyway");
                    updateElement(element);
                }
            });
            return; // Exit early, positioning will happen in the event handler
        }

        trace("UIHandler: Element already has dimensions, positioning immediately");
        updateElement(element);
    }

    /**
     * Remove element from management
     */
    public function unregister(element:DisplayObject):void {
        delete elements[element];
    }

    /**
     * Update all registered elements - call this when stage resizes
     */
    public function updateAll():void {
        for (var element:Object in elements) {
            updateElement(element as DisplayObject);
        }
    }

    /**
     * Update single element position and scale
     */
    private function updateElement(element:DisplayObject):void {
        var config:Object = elements[element];
        if (!config) return;

        // Get current stage size from GameClient (authoritative source)
        var stageW:Number = GameClient.StageWidth;
        var stageH:Number = GameClient.StageHeight;

        // Calculate scale (same logic as working SplashView)
        var scaleX:Number = stageW / BASE_WIDTH;
        var scaleY:Number = stageH / BASE_HEIGHT;
        var scale:Number = Math.min(scaleX, scaleY);

        // Apply scaling if enabled BEFORE positioning calculations
        if (config.shouldScale) {
            element.scaleX = scale;
            element.scaleY = scale;
        }

        // Calculate anchor position
        var anchorX:Number = 0;
        var anchorY:Number = 0;

        // Horizontal anchor
        if (config.anchor.indexOf("right") != -1) {
            anchorX = stageW;
        } else if (config.anchor == "top-center" || config.anchor == "center" || config.anchor == "bottom-center") {
            anchorX = stageW / 2;
        } else {
            anchorX = 0; // left
        }

        // Vertical anchor
        if (config.anchor.indexOf("bottom") != -1) {
            anchorY = stageH;
        } else if (config.anchor == "center-left" || config.anchor == "center" || config.anchor == "center-right") {
            anchorY = stageH / 2;
        } else {
            anchorY = 0; // top
        }

        // Position element relative to anchor
        element.x = anchorX + config.offsetX;
        element.y = anchorY + config.offsetY;

        // Adjust for element registration point
        if (config.anchor == "top-center" || config.anchor == "center" || config.anchor == "bottom-center") {
            element.x -= element.width / 2;
        } else if (config.anchor.indexOf("right") != -1) {
            element.x -= element.width;
        }

        if (config.anchor == "center-left" || config.anchor == "center" || config.anchor == "center-right") {
            element.y -= element.height / 2;
        } else if (config.anchor.indexOf("bottom") != -1) {
            element.y -= element.height;
        }
    }

    /**
     * Get current scale factor
     */
    public function getCurrentScale():Number {
        var scaleX:Number = GameClient.StageWidth / BASE_WIDTH;
        var scaleY:Number = GameClient.StageHeight / BASE_HEIGHT;
        return Math.min(scaleX, scaleY);
    }
    /**
    * Convenience method for common top-left positioning pattern
    * Replaces: element.x = value; element.y = value;
    */
    public function registerTopLeft(element:DisplayObject, x:Number, y:Number, scale:Boolean = true):void {
        register(element, TOP_LEFT, x, y, scale);
    }

    /**
     * Convenience method for common center positioning pattern
     * Replaces: element.x = stageWidth/2 - element.width/2; element.y = value;
     */
    public function registerCentered(element:DisplayObject, yOffset:Number = 0, scale:Boolean = true):void {
        register(element, CENTER, 0, yOffset, scale);
    }

    /**
     * Convenience method for common top-right positioning pattern
     * Replaces: element.x = stageWidth - element.width - margin; element.y = value;
     */
    public function registerTopRight(element:DisplayObject, rightMargin:Number, topMargin:Number, scale:Boolean = true):void {
        register(element, TOP_RIGHT, -rightMargin, topMargin, scale);
    }

    /**
     * Batch register multiple elements with same anchor and scaling
     */
    public function registerBatch(elements:Array, anchor:String, offsetX:Number = 0, offsetY:Number = 0, scale:Boolean = true):void {
        for each(var element:DisplayObject in elements) {
            register(element, anchor, offsetX, offsetY, scale);
        }
    }

    /**
     * Migration helper - automatically detect and migrate common patterns
     * Call this on any DisplayObject that has manual x,y positioning
     */
    public function migrateElement(element:DisplayObject, autoDetectAnchor:Boolean = true):void {
        var stageW:Number = GameClient.StageWidth;
        var stageH:Number = GameClient.StageHeight;

        if (!autoDetectAnchor) {
            // Default to top-left with current position
            register(element, TOP_LEFT, element.x, element.y, true);
            return;
        }

        // Auto-detect anchor based on current position
        var centerX:Number = stageW / 2;
        var centerY:Number = stageH / 2;

        var isLeft:Boolean = element.x < centerX * 0.5;
        var isRight:Boolean = element.x > centerX * 1.5;
        var isTop:Boolean = element.y < centerY * 0.5;
        var isBottom:Boolean = element.y > centerY * 1.5;

        var anchor:String;
        var offsetX:Number;
        var offsetY:Number;

        // Determine anchor and calculate offsets
        if (isTop && isLeft) {
            anchor = TOP_LEFT;
            offsetX = element.x;
            offsetY = element.y;
        } else if (isTop && isRight) {
            anchor = TOP_RIGHT;
            offsetX = element.x - stageW;
            offsetY = element.y;
        } else if (isBottom && isLeft) {
            anchor = BOTTOM_LEFT;
            offsetX = element.x;
            offsetY = element.y - stageH;
        } else if (isBottom && isRight) {
            anchor = BOTTOM_RIGHT;
            offsetX = element.x - stageW;
            offsetY = element.y - stageH;
        } else if (isTop) {
            anchor = TOP_CENTER;
            offsetX = element.x - centerX;
            offsetY = element.y;
        } else if (isBottom) {
            anchor = BOTTOM_CENTER;
            offsetX = element.x - centerX;
            offsetY = element.y - stageH;
        } else {
            anchor = CENTER;
            offsetX = element.x - centerX;
            offsetY = element.y - centerY;
        }

        trace("UIHandler.migrateElement: Detected anchor", anchor, "for element at", element.x, element.y);
        register(element, anchor, offsetX, offsetY, true);
    }
}
}