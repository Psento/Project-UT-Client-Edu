package svera.untiered.storage.mediator {
import svera.lib.framework.Mediator;


import svera.untiered.storage.GiftWindow;
import svera.untiered.storage.signals.GiftSlotUpdateSignal;
import svera.untiered.storage.signals.GiftUpdateSignal;

public class GiftWindowMediator extends Mediator {
    public function GiftWindowMediator() {
        super();
    }

    [Inject]
    public var view_:GiftWindow;
    [Inject]
    public var giftUpdate_:GiftUpdateSignal;
    [Inject]
    public var giftSlotUpdate_:GiftSlotUpdateSignal;

    public override function initialize():void {
        this.giftUpdate_.add(this.onVaultUpdate);
        this.giftSlotUpdate_.add(this.onVaultSlotUpdate);
    }

    public override function destroy():void {
        this.giftUpdate_.remove(this.onVaultUpdate);
        this.giftSlotUpdate_.remove(this.onVaultSlotUpdate);
    }

    private function onVaultUpdate(size:int, slots:Vector.<StorageSlotUpdateData>):void {
        this.view_.setContent(size, slots);
    }

    private function onVaultSlotUpdate(slot:int, inventory:int, itemData:int):void {
        this.view_.updateSlot(slot, inventory, itemData);
    }
}
}
