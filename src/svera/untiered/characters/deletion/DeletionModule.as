package svera.untiered.characters.deletion {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.untiered.characters.deletion.control.DeleteCharacterCommand;
import svera.untiered.characters.deletion.control.DeleteCharacterSignal;
import svera.untiered.characters.deletion.service.DeleteCharacterTask;
import svera.untiered.characters.deletion.view.ConfirmDeleteCharacterDialog;
import svera.untiered.characters.deletion.view.ConfirmDeleteCharacterMediator;

public class DeletionModule implements IModule {

    public function DeletionModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(DeleteCharacterTask);
        context.mediators.map(ConfirmDeleteCharacterDialog, ConfirmDeleteCharacterMediator);
        context.commands.map(DeleteCharacterSignal).toCommand(DeleteCharacterCommand);
    }
}
}
