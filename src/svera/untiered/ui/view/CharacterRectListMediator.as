package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.NewCharacterScreen;
import com.company.assembleegameclient.screens.charrects.CharacterRectList;

import svera.lib.framework.Mediator;

import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.ui.signals.BuyCharacterSlotSignal;

public class CharacterRectListMediator extends Mediator {

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var buyCharacterSlotSignal:BuyCharacterSlotSignal;

    private function getCharacterRectList():CharacterRectList {
        return view as CharacterRectList;
    }

    override public function initialize():void {
        this.getCharacterRectList.newCharacter.add(this.onNewCharacter);
        this.getCharacterRectList.buyCharacterSlot.add(this.onBuyCharacterSlot);
    }

    override public function destroy():void {
        this.getCharacterRectList.newCharacter.remove(this.onNewCharacter);
        this.getCharacterRectList.buyCharacterSlot.remove(this.onBuyCharacterSlot);
    }

    private function onNewCharacter():void {
        this.setScreenWithValidData.dispatch(new NewCharacterScreen());
    }

    private function onBuyCharacterSlot(cost:int):void {
        this.buyCharacterSlotSignal.dispatch(cost);
    }
}
}
