package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import flash.events.Event;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.core.signals.InvalidateDataSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class ErrorDialogMediator extends Mediator {


    [Inject]
    public var view:ErrorDialog;

    [Inject]
    public var invalidateData:InvalidateDataSignal;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var close:CloseDialogsSignal;

    public function ErrorDialogMediator() {
        super();
    }

    override public function initialize():void {
        addViewListener(Event.COMPLETE, this.onComplete);
        this.view.ok.addOnce(this.onClose);
    }

    override public function destroy():void {
        removeViewListener(Event.COMPLETE, this.onComplete);
    }

    public function onClose():void {
        this.close.dispatch();
    }

    private function onComplete(event:Event):void {
        this.invalidateData.dispatch();
        this.setScreenWithValidData.dispatch(new CharacterSelectionAndNewsScreen());
    }
}
}
