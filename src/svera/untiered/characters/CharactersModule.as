package svera.untiered.characters {
import org.swiftsuspenders.Injector;

import svera.lib.framework.IModule;
import svera.lib.framework.AppContext;

import svera.untiered.characters.deletion.DeletionModule;
import svera.untiered.characters.model.CharacterModel;
import svera.untiered.characters.model.LegacyCharacterModel;
import svera.untiered.characters.reskin.ReskinModule;

public class CharactersModule implements IModule {

    public function CharactersModule() {
        super();
    }

    public function configure(context:AppContext):void {
        context.injector.map(CharacterModel).toSingleton(LegacyCharacterModel);
        context.install(new DeletionModule());
        context.install(new ReskinModule());
    }
}
}
