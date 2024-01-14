package svera.untiered.vault.mediator {
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.messaging.impl.data.VaultUpdateSlot;

import svera.untiered.vault.VaultWindow;
import svera.untiered.vault.signals.VaultSlotUpdateSignal;
import svera.untiered.vault.signals.VaultUpdateSignal;

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

    public override function initialize() : void {
        this.vaultUpdateSignal_.add(this.onVaultUpdate);
        this.vaultSlotUpdateSignal_.add(this.onVaultSlotUpdate);
    }

    public override function destroy() : void {
        this.vaultUpdateSignal_.remove(this.onVaultUpdate);
        this.vaultSlotUpdateSignal_.remove(this.onVaultSlotUpdate);
    }

    private function onVaultUpdate(size:int, slots:Vector.<VaultUpdateSlot>) : void {
        this.view_.getContent().initialize(size, slots);
    }

    private function onVaultSlotUpdate(slot:int, inventory:int, itemData:int) : void {
        this.view_.getContent().updateSlot(slot, inventory, itemData);
    }
}
}
