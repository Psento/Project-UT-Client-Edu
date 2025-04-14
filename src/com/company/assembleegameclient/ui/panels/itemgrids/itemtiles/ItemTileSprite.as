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

public class ItemTileSprite extends Sprite {

    protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 1, 0])];

    private static const DOSE_MATRIX:Matrix = function ():Matrix {
        var m:* = new Matrix();
        m.translate(10, 5);
        return m;
    }();


    public var itemId:int;
    public var itemData:NewItemData;
    public var tierText:SimpleText;

    public var itemBitmap:Bitmap;

    public function ItemTileSprite() {
        super();
        this.itemBitmap = new Bitmap();
        tierText = new SimpleText(12, 0xFFFFFF);
        addChild(this.itemBitmap);
        addChild(tierText);
        this.itemId = -1;
    }

    public function setDim(dim:Boolean):void {
        filters = dim ? DIM_FILTER : null;
    }

    public function setType(displayedItemType:int, displayedItemData:NewItemData):void {
        var texture:BitmapData = null;
        var eqXML:XML = null;
        var tempText:SimpleText = null;
        this.itemId = displayedItemType;
        this.itemData = displayedItemData;
        if (this.itemId != ItemConstants.NO_ITEM) {
            texture = ObjectLibrary.getRedrawnTextureFromType(this.itemId, 80, true);
            eqXML = ObjectLibrary.xmlLibrary_[this.itemId];
            if (eqXML) {
                if (eqXML.hasOwnProperty("Doses")) {
                    texture = texture.clone();
                    tempText = new SimpleText(12, 16777215, false, 0, 0);
                    tempText.text = String(eqXML.Doses);
                    tempText.updateMetrics();
                    texture.draw(tempText, DOSE_MATRIX);
                }
                if (eqXML.hasOwnProperty("TierType")) {
                    switch (eqXML.TierType) {
                        case "Celestial":
                            tierText.setColor(TooltipHelper.CELESTIAL_COLOR);
                            tierText.text = "CL";
                            break;
                        case "Exiled":
                            tierText.setColor(TooltipHelper.EXILED_COLOR);
                            tierText.text = "EX";
                            break;
                        case "Relic":
                            tierText.setColor(TooltipHelper.RELIC_COLOR);
                            tierText.text = "R";
                            break;
                        case "Valiant":
                            tierText.setColor(TooltipHelper.VALIANT_COLOR);
                            tierText.text = "VL";
                            break;
                        case "Ancestral":
                            tierText.setColor(TooltipHelper.ANCESTRAL_COLOR);
                            tierText.text = "AN";
                            break;
                        case "Artifact":
                            tierText.setColor(TooltipHelper.ARTIFACT_COLOR);
                            tierText.text = "A";
                            break;
                        case "Tarnished":
                            tierText.setColor(TooltipHelper.TARNISHED_COLOR);
                            tierText.text = "T";
                            break;
                        case "Uncommon":
                            tierText.setColor(TooltipHelper.UNCOMMON_COLOR);
                            tierText.text = "UC";
                            break;
                        case "Stat":
                            tierText.setColor(16777215);
                            tierText.text = "S";
                            break;
                        case "Common":
                            tierText.setColor(TooltipHelper.COMMON_COLOR);
                            tierText.text = "C";
                            break;
                    }
                    tierText.visible = true;
                    tierText.x = 12;
                    tierText.y = 12;
                }
                else{
                    tierText.visible = false;
                }
            }
            this.itemBitmap.bitmapData = texture;
            this.itemBitmap.x = -texture.width / 2;
            this.itemBitmap.y = -texture.height / 2;
            visible = true;
        } else {
            visible = false;
        }
    }
}
}
