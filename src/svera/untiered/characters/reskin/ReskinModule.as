package svera.untiered.characters.reskin {
import org.swiftsuspenders.Injector;

import svera.lib.framework.IModule;
import svera.lib.framework.AppContext;

import svera.lib.net.api.MessageMap;
import svera.untiered.characters.reskin.control.OpenReskinDialogCommand;
import svera.untiered.characters.reskin.control.OpenReskinDialogSignal;
import svera.untiered.characters.reskin.control.ReskinCharacterCommand;
import svera.untiered.characters.reskin.control.ReskinCharacterSignal;
import svera.untiered.characters.reskin.control.ReskinHandler;
import svera.untiered.characters.reskin.view.ReskinCharacterMediator;
import svera.untiered.characters.reskin.view.ReskinCharacterView;
import svera.untiered.characters.reskin.view.ReskinPanel;
import svera.untiered.characters.reskin.view.ReskinPanelMediator;
import svera.untiered.messaging.impl.GameServerConnection;
import svera.untiered.messaging.impl.outgoing.Reskin;

public class ReskinModule implements IModule {

    [Inject]
    public var messageMap:MessageMap;

    public function ReskinModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.mediators.map(ReskinCharacterView, ReskinCharacterMediator);
        context.mediators.map(ReskinPanel, ReskinPanelMediator);
        context.commands.map(OpenReskinDialogSignal).toCommand(OpenReskinDialogCommand);
        context.commands.map(ReskinCharacterSignal).toCommand(ReskinCharacterCommand);
    }
}
}
