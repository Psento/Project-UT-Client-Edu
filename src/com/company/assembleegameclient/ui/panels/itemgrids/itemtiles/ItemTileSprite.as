package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
import com.company.ui.SimpleText;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;

import svera.untiered.constants.ItemConstants;
import svera.untiered.itemdata.NewItemData;
import svera.untiered.itemdata.TierHelper;

public class ItemTileSprite extends Sprite {

    protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 1, 0])];

    private static const DOSE_MATRIX:Matrix = new Matrix(1, 0, 0, 1, 10, 5);

    public var itemData:NewItemData;
    public var tierText:SimpleText;

    public var itemBitmap:Bitmap;

    public function ItemTileSprite() {
        super();
        this.itemBitmap = new Bitmap();
        tierText = new SimpleText(12, 0xFFFFFF);
        addChild(this.itemBitmap);
        addChild(tierText);
        this.itemData = null;
    }

    public function setDim(dim:Boolean):void {
        filters = dim ? DIM_FILTER : null;
    }

    public function setType(newItem:NewItemData):void {
        itemData = newItem;

        if (itemData == null) {
            visible = false;
            return;
        }

        var texture:BitmapData = ObjectLibrary.getRedrawnTextureFromType(itemData.ObjectType, 80, true);

        if (itemData.Doses > 0) {
            texture = texture.clone();
            var tempText:SimpleText = new SimpleText(12, 16777215, false, 0, 0);
            tempText.text = String(itemData.Doses);
            tempText.updateMetrics();
            texture.draw(tempText, DOSE_MATRIX);
        }

        if (tierText.visible = TierHelper.setTierText(tierText, itemData.TierType)) {
            tierText.x = 12;
            tierText.y = 12;
        }

        itemBitmap.bitmapData = texture;
        itemBitmap.x = -texture.width / 2;
        itemBitmap.y = -texture.height / 2;
        visible = true;
    }
}
}
