package svera.untiered.storage.mediator {
import link.ItemData;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.storage.VaultWindow;
import svera.untiered.storage.signals.VaultSlotUpdateSignal;
import svera.untiered.storage.signals.VaultUpdateSignal;

public class VaultWindowMediator extends Mediator {
    public function VaultWindowMediator() {
        super();
    }

    [Inject]
    public var view_:VaultWindow;
    [Inject]
    public var vaultUpdateSignal_:VaultUpdateSignal;
    [Inject]
    public var vaultSlotUpdateSignal_:VaultSlotUpdateSignal;

    public override function initialize():void {
        this.vaultUpdateSignal_.add(this.onVaultUpdate);
        this.vaultSlotUpdateSignal_.add(this.onVaultSlotUpdate);
    }

    public override function destroy():void {
        this.vaultUpdateSignal_.remove(this.onVaultUpdate);
        this.vaultSlotUpdateSignal_.remove(this.onVaultSlotUpdate);
    }

    private function onVaultUpdate(size:int, slots:Vector.<ItemData>):void {
        this.view_.setContent(size, slots);
    }

    private function onVaultSlotUpdate(slot:int, inventory:ItemData):void {
        this.view_.updateSlot(slot, inventory);
    }
}
}
