package svera.untiered.classes.view {
import com.company.assembleegameclient.screens.NewCharacterScreen;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.traits.TraitsGUI;

public class CharacterSkinMediator extends Mediator {
    [Inject]
    public var view:CharacterSkinView;

    [Inject]
    public var model:PlayerModel;

    [Inject]
    public var setScreen:SetScreenSignal;

    public function CharacterSkinMediator() {
        super();
    }

    override public function initialize():void {
        var hasSlot:Boolean = this.model.hasAvailableCharSlot();
        this.view.setPlayButtonEnabled(hasSlot);
        if (hasSlot) {
            this.view.play.addOnce(this.onPlay);
        }
        this.view.back.addOnce(this.onBack);
    }

    override public function destroy():void {
        this.view.back.remove(this.onBack);
        this.view.play.remove(this.onPlay);
    }

    private function onBack():void {
        this.setScreen.dispatch(new NewCharacterScreen());
    }

    private function onPlay():void {
        this.setScreen.dispatch(new TraitsGUI());
    }
}
}
