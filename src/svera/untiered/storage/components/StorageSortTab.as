package svera.untiered.storage.components {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class StorageSortTab extends Sprite {

    public static const WEAPON:String = "WEAPON";
    public static const ABILITY:String = "ABILITY";
    public static const ARMOR:String = "ARMOR";
    public static const RING:String = "RING";
    public static const MISC:String = "MISC";
    public static const ALL:String = "ALL";

    private static const WEAPON_CATEGORY:Array =  [1, 2, 17, 8, 24, 3, 26, 27, 28, 29, 30]; //slot types
    private static const ABILITY_CATEGORY:Array = [13, 11, 4, 16, 15, 12, 18, 19, 5, 20, 21, 25, 22, 23];
    private static const ARMOR_CATEGORY:Array =   [6, 7, 14];
    private static const RING_CATEGORY:Array =    [9];
    private static const OTHER_CATEGORY:Array =   [10];

    public static const SIZE:int = 50;

    public static function getSortArray(sort:String) : Array {
        switch(sort) {
            case WEAPON:  return WEAPON_CATEGORY;
            case ABILITY: return ABILITY_CATEGORY;
            case ARMOR:   return ARMOR_CATEGORY;
            case RING:    return RING_CATEGORY;
            case MISC:    return OTHER_CATEGORY;
        }
        return [];
    }

    public var filter_:String;

    private var selected_:Boolean;

    private var toolTip_:TextToolTip;

    public function StorageSortTab(filter:String) {
        this.filter_ = filter;

        this.toolTip_ = new TextToolTip(0x363636, 0xFFFFFF, filter, "", 100);

        graphics.clear();
        graphics.beginFill(0x161616);
        graphics.drawRect(0, 0, SIZE, SIZE);
        graphics.endFill();

        this.addEventListener(MouseEvent.ROLL_OVER, this.rollOver);
        this.addEventListener(MouseEvent.ROLL_OUT, this.rollOut);
    }

    public function select() : void {
        this.selected_ = !this.selected_;
        if (this.selected_) {
            this.transform.colorTransform = MoreColorUtil.darkCT;
        } else {
            this.transform.colorTransform = MoreColorUtil.identity;
        }
    }

    public function unselect() : void {
        this.selected_ = false;
        this.transform.colorTransform = MoreColorUtil.identity;
    }

    public function isSelected() : Boolean {
        return this.selected_;
    }

    private function rollOver(e:MouseEvent):void {
        this.transform.colorTransform = MoreColorUtil.darkCT;

        this.toolTip_.attachToTarget(this);
        this.stage.addChild(this.toolTip_);
    }

    private function rollOut(e:MouseEvent):void {
        if (this.selected_) {
            return;
        }

        this.transform.colorTransform = MoreColorUtil.identity;

        this.toolTip_.attachToTarget(null);
        this.stage.removeChild(this.toolTip_);
    }
}
}
