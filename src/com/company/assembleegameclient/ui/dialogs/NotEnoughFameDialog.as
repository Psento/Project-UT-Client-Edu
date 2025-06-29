package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

public class NotEnoughHonorDialog extends Dialog {


    public function NotEnoughHonorDialog() {
        super("You do not have enough Honor for this item.  " + "You gain Honor when your character dies after having " + "accomplished great things.", "Not Enough Honor", "Ok", null);
        addEventListener(LEFT_BUTTON, this.onOk);
    }

    public function onOk(event:Event):void {
        parent.removeChild(this);
    }
}
}
