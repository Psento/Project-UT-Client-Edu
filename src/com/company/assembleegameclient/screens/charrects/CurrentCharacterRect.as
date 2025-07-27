package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.screens.events.DeleteCharacterEvent;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.SimpleText;
import com.company.untiered.graphics.DeleteXGraphic;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

import svera.untiered.classes.model.CharacterClass;

public class CurrentCharacterRect extends CharacterRect {
    private static var toolTip_:ToolTip = null;

    public var charName:String;
    private var charType:CharacterClass;
    public var char:SavedCharacter;
    public var charStats:CharacterStats;
    private var classNameText:SimpleText;
    private var taglineIcon:Sprite;
    private var taglineText:SimpleText;
    private var deleteButton:Sprite;
    public var selected:Signal;
    public var deleteCharacter:Signal;
    private var icon:DisplayObject;

    public function CurrentCharacterRect(charName:String, charType:CharacterClass, char:SavedCharacter, charStats:CharacterStats) {
        super(6052956, 8355711);
        this.charName = charName;
        this.charType = charType;
        this.char = char;
        this.charStats = charStats;
        makeContainer();
        this.makeClassNameText();
        this.makeDeleteButton();
        this.selected = new NativeMappedSignal(selectContainer, MouseEvent.CLICK).mapTo(char);
        this.deleteCharacter = new NativeMappedSignal(this.deleteButton, MouseEvent.CLICK).mapTo(char);
    }

    public function setIcon(value:DisplayObject):void {
        this.icon && selectContainer.removeChild(this.icon);
        this.icon = value;
        this.icon.x = this.width / 2 - this.icon.width / 2;
        this.icon.y = this.height / 2 - this.icon.height / 2 - 6;
        this.icon && selectContainer.addChild(this.icon);
    }

    private function makeClassNameText():void {
        this.classNameText = new SimpleText(12, 16777215, false, 0, 0);
        this.classNameText.setBold(true);
        this.classNameText.text = this.charType.name + " " + this.char.level();
        this.classNameText.updateMetrics();
        this.classNameText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.classNameText.x = this.width / 2 - this.classNameText.width / 2;
        this.classNameText.y = this.y + this.height - this.classNameText.height;
        selectContainer.addChild(this.classNameText);
    }

    private function makeDeleteButton():void {
        this.deleteButton = new DeleteXGraphic();
        this.deleteButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onDeleteDown);
        this.deleteButton.x = (this.x + this.deleteButton.width) * 0.2;
        this.deleteButton.y = (this.y + this.deleteButton.height) * 0.2;
        addChild(this.deleteButton);
    }

    override protected function onMouseOver(event:MouseEvent):void {
        super.onMouseOver(event);
    }

    override protected function onRollOut(event:MouseEvent):void {
        super.onRollOut(event);
    }

    private function onDeleteDown(event:MouseEvent):void {
        event.stopImmediatePropagation();
        dispatchEvent(new DeleteCharacterEvent(this.char));
    }
}
}
