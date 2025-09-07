package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.ui.SimpleText;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.DropShadowFilter;

import svera.untiered.itemdata.NewItemData;

public class InventoryTile extends InteractiveItemTile {


    public var hotKey:String;

    private var hotKeyBMP:Bitmap;

    public function InventoryTile(id:int, parentGrid:ItemGrid, isInteractive:Boolean) {
        super(id, parentGrid, isInteractive);
    }

    public function addTileNumber(tileNumber:int):void {
        this.hotKey = String.fromCharCode(Parameters.data_["useEquipInvSlot" + String(tileNumber)]);
        this.buildHotKeyBMP();
    }

    public function buildHotKeyBMP():void {
        var tempText:SimpleText = new SimpleText(12, 0x5b4c96, false, 0, 0);
        tempText.text = hotKey;
        tempText.setBold(true);
        tempText.updateMetrics();
        var bmpData:BitmapData = new BitmapData(20, 20, true, 0);
        bmpData.draw(tempText);
        this.hotKeyBMP = new Bitmap(bmpData);
        this.hotKeyBMP.x = 0 - 2;
        this.hotKeyBMP.y = 0 - 3;
        hotKeyBMP.filters = [new DropShadowFilter(0, 0, 0, 1.0, 1.5, 1.5, 255)];
        addChild(hotKeyBMP);
    }

    override public function setItemSprite(newItemSprite:ItemTileSprite):void {
        super.setItemSprite(newItemSprite);
        newItemSprite.setDim(false);
    }

    override public function setItem(itemData:NewItemData):Boolean {
        return super.setItem(itemData);
    }

    override protected function beginDragCallback():void {
    }

    override protected function endDragCallback():void {
    }
}
}
