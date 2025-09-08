package svera.untiered.legends.model {
import flash.display.BitmapData;

import svera.untiered.honor.model.HonorVO;
import svera.untiered.itemdata.NewItemData;

public class Legend implements HonorVO {


    public var isOwnLegend:Boolean;

    public var place:int;

    public var accountId:int;

    public var charId:int;

    public var name:String;

    public var totalHonor:int;

    public var equipmentSlots:Vector.<int>;

    public var equipment:Vector.<NewItemData>;

    public var character:BitmapData;

    public var isFocus:Boolean;

    public function Legend() {
        super();
    }

    public function getAccountId():int {
        return this.accountId;
    }

    public function getCharacterId():int {
        return this.charId;
    }
}
}
