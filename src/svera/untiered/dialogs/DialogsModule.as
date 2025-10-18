package svera.untiered.dialogs {
import svera.lib.framework.AppContext;
import svera.lib.framework.IModule;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.dialogs.view.DialogsMediator;
import svera.untiered.dialogs.view.DialogsView;

public class DialogsModule implements IModule {

    public function configure(context:AppContext):void {

        // Map signals
        context.injector.map(OpenDialogSignal).asSingleton();

        // Map mediator (simplified!)
        context.mediators.map(DialogsView, DialogsMediator);
    }
}
}