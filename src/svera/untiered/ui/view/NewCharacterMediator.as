package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;

import flash.display.Sprite;

import svera.lib.framework.Mediator;

import svera.untiered.classes.model.ClassesModel;
import svera.untiered.classes.view.CharacterSkinView;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.HideTooltipsSignal;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.core.signals.ShowTooltipSignal;
import svera.untiered.core.signals.UpdateNewCharacterScreenSignal;
import svera.untiered.game.signals.PlayGameSignal;

public class NewCharacterMediator extends Mediator {

    [Inject]
    public var playerModel:PlayerModel;

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var playGame:PlayGameSignal;

    [Inject]
    public var showTooltip:ShowTooltipSignal;

    [Inject]
    public var hideTooltips:HideTooltipsSignal;

    [Inject]
    public var updateNewCharacterScreen:UpdateNewCharacterScreenSignal;

    [Inject]
    public var classesModel:ClassesModel;

    private function getNewCharacterScreen():NewCharacterScreen {
        return view as NewCharacterScreen;
    }

    override public function initialize():void {
        this.getNewCharacterScreen.selected.add(this.onSelected);
        this.getNewCharacterScreen.close.add(this.onClose);
        this.getNewCharacterScreen.tooltip.add(this.onTooltip);
        this.updateNewCharacterScreen.add(this.onUpdate);
        this.getNewCharacterScreen.initialize(this.playerModel);
    }

    private function onBuyCharacterPending(objectType:int):void {
        this.getNewCharacterScreen.updateCurrencies(this.playerModel.getTsavorite(), this.playerModel.getMedallions(), this.playerModel.getHonor());
    }

    override public function destroy():void {
        this.getNewCharacterScreen.selected.remove(this.onSelected);
        this.getNewCharacterScreen.close.remove(this.onClose);
        this.getNewCharacterScreen.tooltip.remove(this.onTooltip);
        this.updateNewCharacterScreen.remove(this.onUpdate);
    }

    private function onClose():void {
        this.setScreen.dispatch(new CharacterSelectionAndNewsScreen());
    }

    private function onSelected(objectType:int):void {
        this.classesModel.getCharacterClass(objectType).setIsSelected(true);
        this.setScreen.dispatch(new CharacterSkinView());
    }

    private function onTooltip(sprite:Sprite):void {
        if (sprite) {
            this.showTooltip.dispatch(sprite);
        } else {
            this.hideTooltips.dispatch();
        }
    }

    private function onUpdate():void {
    }
}
}
