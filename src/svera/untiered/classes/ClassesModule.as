package svera.untiered.classes {
import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;
import svera.lib.framework.IModule;
import svera.untiered.account.core.control.IsAccountRegisteredGuard;
import svera.untiered.account.core.signals.CharListDataSignal;
import svera.untiered.account.core.signals.LogoutSignal;
import svera.untiered.assets.EmbeddedData;
import svera.untiered.classes.control.*;
import svera.untiered.classes.model.ClassesModel;
import svera.untiered.classes.services.BuySkinTask;
import svera.untiered.classes.view.*;

/**
 * Classes Module - Replaces ClassesConfig
 * Configures character classes, skins, and related functionality
 */
public class ClassesModule implements IModule {

    public function configure(context:AppContext):void {
        var injector:Injector = context.injector;

        // Model
        injector.map(ClassesModel).asSingleton();

        // Signals
        injector.map(ParseClassesXMLSignal).asSingleton();
        injector.map(BuyCharacterSkinSignal).asSingleton();
        injector.map(FocusCharacterSkinSignal).asSingleton();

        // Services
        injector.map(BuySkinTask);
        injector.map(CharacterSkinListItemFactory).asSingleton();

        // Command mappings with guards
        context.commands.map(ParseClassesXMLSignal)
                .toCommand(ParseClassesXmlCommand);

        context.commands.map(CharListDataSignal)
                .toCommand(ParseCharListXmlCommand);

        context.commands.map(BuyCharacterSkinSignal)
                .toCommand(BuyCharacterSkinCommand)
                .withGuards(IsAccountRegisteredGuard);

        context.commands.map(LogoutSignal)
                .toCommand(ResetClassDataCommand);

        // Mediator mappings
        context.mediators.map(ClassDetailView, ClassDetailMediator);
        context.mediators.map(CharacterSkinView, CharacterSkinMediator);
        context.mediators.map(CharacterSkinListView, CharacterSkinListMediator);
        context.mediators.map(CharacterSkinListItem, CharacterSkinListItemMediator);

        // Parse initial data
        // EmbeddedData.Players is a Class, need to instantiate and convert to XML
        var parseSignal:ParseClassesXMLSignal = injector.getInstance(ParseClassesXMLSignal);
        var playersXML:XML = XML(new EmbeddedData.Players());
        parseSignal.dispatch(playersXML);

        // Note: ParseSkinsXmlCommand reads directly from EmbeddedData.skinsXML
        // so we don't need to dispatch for skins - it ignores the data parameter
    }
}
}