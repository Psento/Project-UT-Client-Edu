package svera.untiered.game.focus {
import com.company.assembleegameclient.game.GameSprite;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

import svera.untiered.game.focus.control.SetGameFocusSignal;
import svera.untiered.game.focus.view.GameFocusMediator;

public class GameFocusConfig implements IConfig {


    [Inject]
    public var context:IContext;

    [Inject]
    public var injector:Injector;

    [Inject]
    public var commandMap:ISignalCommandMap;

    [Inject]
    public var mediatorMap:IMediatorMap;

    public function GameFocusConfig() {
        super();
    }

    public function configure():void {
        this.injector.map(SetGameFocusSignal).asSingleton();
        this.mediatorMap.map(GameSprite).toMediator(GameFocusMediator);
    }
}
}
