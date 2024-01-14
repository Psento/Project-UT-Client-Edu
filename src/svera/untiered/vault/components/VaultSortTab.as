package svera.untiered.vault.components {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class VaultSortTab extends Sprite {

    public static const A_TO_Z:String = "ATOZ";
    public static const RARITY:String = "RARITY";
    public static const TYPE:String = "TYPE";
    public static const NONE:String = "NONE";

    public var filter_:String;

    private var selected_:Boolean;

    private var toolTip_:TextToolTip;

    public function VaultSortTab(filter:String) {
        this.filter_ = filter;

        this.toolTip_ = new TextToolTip(0x363636, 0xFFFFFF, filter, "", 100);

        graphics.clear();
        graphics.beginFill(0x161616);
        graphics.drawRect(0, 0, 50, 50);
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
