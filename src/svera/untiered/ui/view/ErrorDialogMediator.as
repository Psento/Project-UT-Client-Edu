package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import flash.events.Event;

import svera.lib.framework.Mediator;

import svera.untiered.core.signals.InvalidateDataSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.dialogs.control.CloseDialogsSignal;

public class ErrorDialogMediator extends Mediator {

    [Inject]
    public var invalidateData:InvalidateDataSignal;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var close:CloseDialogsSignal;
    // Type-safe view accessor
    private function get errorDialog():ErrorDialog {
        return view as ErrorDialog;
    }

    override protected function onInitialize():void {
        errorDialog.addEventListener(Event.COMPLETE, this.onComplete);
        errorDialog.ok.addOnce(this.onClose);
    }

    override public function destroy():void {
        errorDialog.removeEventListener(Event.COMPLETE, this.onComplete);
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
