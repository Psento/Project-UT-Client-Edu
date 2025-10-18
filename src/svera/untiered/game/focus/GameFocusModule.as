package svera.untiered.game.focus {
import com.company.assembleegameclient.game.GameSprite;

import org.swiftsuspenders.Injector;

import svera.lib.framework.IModule;
import svera.lib.framework.AppContext;

import svera.untiered.game.focus.control.SetGameFocusSignal;
import svera.untiered.game.focus.view.GameFocusMediator;

public class GameFocusModule implements IModule {

    [Inject]
    public var injector:Injector;

    public function GameFocusModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(SetGameFocusSignal).asSingleton();
        context.mediators.map(GameSprite, GameFocusMediator);
    }
}
}
