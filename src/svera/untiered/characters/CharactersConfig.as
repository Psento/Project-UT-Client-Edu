package svera.untiered.characters {
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

import svera.untiered.characters.deletion.DeletionConfig;
import svera.untiered.characters.model.CharacterModel;
import svera.untiered.characters.model.LegacyCharacterModel;
import svera.untiered.characters.reskin.ReskinConfig;

public class CharactersConfig implements IConfig {


    [Inject]
    public var context:IContext;

    [Inject]
    public var injector:Injector;

    [Inject]
    public var commandMap:ISignalCommandMap;

    public function CharactersConfig() {
        super();
    }

    public function configure():void {
        this.injector.map(CharacterModel).toSingleton(LegacyCharacterModel);
        this.context.configure(DeletionConfig);
        this.context.configure(ReskinConfig);
    }
}
}
