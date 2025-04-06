/**
 * Created by club5_000 on 1/21/2016.
 */
package com.company.assembleegameclient.account.ui.unboxing {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
import com.company.ui.SimpleText;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.TextFormatAlign;

public class UnboxSquare extends Sprite {
    public function UnboxSquare(_item:int, _id:int=0) {
        this.itemType_ = _item;
        this.id_ = _id;
        addIcon();
    }

    public var itemType_:int;
    public var background:Sprite;
    public var itemBitmap_:Bitmap;
    public var itemName_:SimpleText;
    public var id_:int;

    private function addIcon() : void {
        var _local1:XML = ObjectLibrary.xmlLibrary_[this.itemType_];
        var _local2:Number = 5;
        if (_local1.hasOwnProperty("ScaleValue")) {
            _local2 = _local1.ScaleValue;
        }
        var _local5:uint = 0xA9A9A9;
        if(_local1.hasOwnProperty("TierType")) {
            if (String(_local1.TierType).match(/Exiled$/i)) {
                _local5 = TooltipHelper.EXILED_COLOR;
            }
            if (String(_local1.TierType).match(/Relic$/i)) {
                _local5 = TooltipHelper.RELIC_COLOR;
            }
            if (String(_local1.TierType).match(/Valiant$/i)) {
                _local5 = TooltipHelper.VALIANT_COLOR;
            }
            if (String(_local1.TierType).match(/Ancestral$/i)) {
                _local5 = TooltipHelper.ANCESTRAL_COLOR;
            }
            if (String(_local1.TierType).match(/Artifact$/i)) {
                _local5 = TooltipHelper.ARTIFACT_COLOR;
            }
            if (String(_local1.TierType).match(/Tarnished$/i)) {
                _local5 = TooltipHelper.TARNISHED_COLOR;
            }
            if (String(_local1.TierType).match(/Uncommon$/i)) {
                _local5 = TooltipHelper.UNCOMMON_COLOR;
            }
        }
        if (_local1.hasOwnProperty("Outfit")) {
            _local5 = 0xADD8E6;
        }
        if (_local1.hasOwnProperty("Fabled")) {
            _local5 = 0x880000;
        }
        if (!_local1.hasOwnProperty("Tier")) {
            _local5 = 0xc13ec1;
        }
        if (_local1.Tier >= 12) {
            _local5 = 0x78a065;
        }
        if (_local1.hasOwnProperty("Potion")) {
            _local5 = 0xaa9e63;
        }
        this.background = new Sprite();
        this.background.graphics.beginFill(_local5);
        this.background.graphics.drawRect(0, 0, 75, 75);
        this.background.graphics.endFill();
        this.background.addChild(new EmbedUnboxSquare());
        addChild(this.background);
        var _local3:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.itemType_, 60, true, true, _local2);
        _local3 = BitmapUtil.cropToBitmapData(_local3, 4, 4, (_local3.width - 8), (_local3.height - 8));
        this.itemBitmap_ = new Bitmap(_local3);
        this.itemBitmap_.x = (75 / 2) - (this.itemBitmap_.width / 2);
        this.itemBitmap_.y = (50 / 2) - (this.itemBitmap_.height / 2);
        addChild(this.itemBitmap_);
        this.itemName_ = new SimpleText(10, 0x000000, false, 77, 0);
        this.itemName_.setBold(true);
        this.itemName_.setAlignment(TextFormatAlign.CENTER);
        this.itemName_.text = ObjectLibrary.typeToDisplayId_[this.itemType_];
        this.itemName_.wordWrap = true;
        this.itemName_.updateMetrics();
        this.itemName_.y = (25 / 2 + 50) - (this.itemName_.textHeight / 2) - 3;
        this.itemName_.x = -1;
        addChild(this.itemName_);
    }
}
}
