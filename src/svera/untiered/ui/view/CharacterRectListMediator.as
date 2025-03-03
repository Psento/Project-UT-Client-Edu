package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.NewCharacterScreen;
import com.company.assembleegameclient.screens.charrects.CharacterRectList;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.ui.signals.BuyCharacterSlotSignal;

public class CharacterRectListMediator extends Mediator {


    [Inject]
    public var view:CharacterRectList;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var buyCharacterSlotSignal:BuyCharacterSlotSignal;

    public function CharacterRectListMediator() {
        super();
    }

    override public function initialize():void {
        this.view.newCharacter.add(this.onNewCharacter);
        this.view.buyCharacterSlot.add(this.onBuyCharacterSlot);
    }

    override public function destroy():void {
        this.view.newCharacter.remove(this.onNewCharacter);
        this.view.buyCharacterSlot.remove(this.onBuyCharacterSlot);
    }

    private function onNewCharacter():void {
        this.setScreenWithValidData.dispatch(new NewCharacterScreen());
    }

    private function onBuyCharacterSlot(cost:int):void {
        this.buyCharacterSlotSignal.dispatch(cost);
    }
}
}
