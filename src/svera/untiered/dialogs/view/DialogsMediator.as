package svera.untiered.dialogs.view {
import flash.display.Sprite;

import svera.lib.framework.Mediator;
import svera.untiered.dialogs.control.OpenDialogSignal;

public class DialogsMediator extends Mediator {
    // Remove [Inject] for view - it's automatic now
    [Inject]
    public var openDialog:OpenDialogSignal;

    // Type-safe view accessor
    private function get dialogsView():DialogsView {
        return view as DialogsView;
    }

    // Use onInitialize instead of initialize
    override protected function onInitialize():void {
        openDialog.add(onOpenDialog);
    }

    // Use onDestroy instead of destroy
    override protected function onDestroy():void {
        openDialog.remove(onOpenDialog);
    }

    private function onOpenDialog(dialog:Sprite):void {
        dialogsView.show(dialog);
    }
}
}