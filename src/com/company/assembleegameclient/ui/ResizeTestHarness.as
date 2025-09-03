package com.company.assembleegameclient.ui {
import com.company.ui.SimpleText;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

/**
 * Simple test for UIHandler positioning
 */
public class ResizeTestHarness extends Sprite {

    private var uiHandler:UIHandler;
    private var testElements:Vector.<Sprite> = new Vector.<Sprite>();
    private var infoText:SimpleText;

    public function ResizeTestHarness() {
        super();
        if (stage) {
            init();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }

    private function init(event:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        uiHandler = UIHandler.getInstance();
        createTestElements();

        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

        trace("=== UIHandler Fresh Test ===");
        trace("Press R to update positions");
        trace("Current stage:", GameClient.StageWidth + "x" + GameClient.StageHeight);
    }

    private function createTestElements():void {
        // Create simple test elements for each anchor
        var anchors:Array = [
            {anchor: UIHandler.TOP_LEFT, color: 0xFF0000, label: "TL", x: 10, y: 10},
            {anchor: UIHandler.TOP_CENTER, color: 0x00FF00, label: "TC", x: 0, y: 10},
            {anchor: UIHandler.TOP_RIGHT, color: 0x0000FF, label: "TR", x: -10, y: 10},
            {anchor: UIHandler.CENTER_LEFT, color: 0xFFFF00, label: "CL", x: 10, y: 0},
            {anchor: UIHandler.CENTER, color: 0xFF00FF, label: "C", x: 0, y: 0},
            {anchor: UIHandler.CENTER_RIGHT, color: 0x00FFFF, label: "CR", x: -10, y: 0},
            {anchor: UIHandler.BOTTOM_LEFT, color: 0x800000, label: "BL", x: 10, y: -10},
            {anchor: UIHandler.BOTTOM_CENTER, color: 0x008000, label: "BC", x: 0, y: -10},
            {anchor: UIHandler.BOTTOM_RIGHT, color: 0x000080, label: "BR", x: -10, y: -10}
        ];

        for each(var anchor:Object in anchors) {
            var element:Sprite = createColoredSquare(anchor.color, anchor.label);
            addChild(element);
            testElements.push(element);

            // Register with simple offsets
            uiHandler.register(element, anchor.anchor, anchor.x, anchor.y, true);
        }

        // Info text
        infoText = new SimpleText(14, 0xFFFFFF, false, 0, 0);
        infoText.text = "UIHandler Test\nPress R to refresh";
        infoText.updateMetrics();
        addChild(infoText);

        uiHandler.register(infoText, UIHandler.TOP_LEFT, 120, 10, false);
    }

    private function createColoredSquare(color:uint, label:String):Sprite {
        var square:Sprite = new Sprite();

        // Draw square
        square.graphics.beginFill(color);
        square.graphics.drawRect(0, 0, 60, 40);
        square.graphics.endFill();

        // Add label
        var text:SimpleText = new SimpleText(12, 0x000000, false, 0, 0);
        text.text = label;
        text.updateMetrics();
        text.x = (60 - text.textWidth) / 2;
        text.y = (40 - text.textHeight) / 2;
        square.addChild(text);

        return square;
    }

    private function onKeyDown(event:KeyboardEvent):void {
        if (event.keyCode == Keyboard.R) {
            trace("\n=== Manual Refresh ===");
            trace("GameClient stage:", GameClient.StageWidth + "x" + GameClient.StageHeight);
            trace("Scale:", uiHandler.getCurrentScale().toFixed(3));

            uiHandler.updateAll();

            // Log all element positions
            for (var i:int = 0; i < testElements.length; i++) {
                var element:Sprite = testElements[i];
                trace("Element " + i + ": x=" + element.x.toFixed(1) + " y=" + element.y.toFixed(1) + " scale=" + element.scaleX.toFixed(3));
            }
        }
    }

    public function destroy():void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

        for each(var element:Sprite in testElements) {
            uiHandler.unregister(element);
        }
        uiHandler.unregister(infoText);
    }
}
}