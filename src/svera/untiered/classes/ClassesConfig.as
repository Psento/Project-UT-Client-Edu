package svera.untiered.classes {
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

import svera.untiered.account.core.control.IsAccountRegisteredGuard;
import svera.untiered.account.core.signals.CharListDataSignal;
import svera.untiered.account.core.signals.LogoutSignal;
import svera.untiered.assets.EmbeddedData;
import svera.untiered.classes.control.BuyCharacterSkinCommand;
import svera.untiered.classes.control.BuyCharacterSkinSignal;
import svera.untiered.classes.control.FocusCharacterSkinSignal;
import svera.untiered.classes.control.ParseCharListXmlCommand;
import svera.untiered.classes.control.ParseClassesXMLSignal;
import svera.untiered.classes.control.ParseClassesXmlCommand;
import svera.untiered.classes.control.ParseSkinsXmlCommand;
import svera.untiered.classes.control.ResetClassDataCommand;
import svera.untiered.classes.model.ClassesModel;
import svera.untiered.classes.services.BuySkinTask;
import svera.untiered.classes.view.CharacterSkinListItem;
import svera.untiered.classes.view.CharacterSkinListItemFactory;
import svera.untiered.classes.view.CharacterSkinListItemMediator;
import svera.untiered.classes.view.CharacterSkinListMediator;
import svera.untiered.classes.view.CharacterSkinListView;
import svera.untiered.classes.view.CharacterSkinMediator;
import svera.untiered.classes.view.CharacterSkinView;
import svera.untiered.classes.view.ClassDetailMediator;
import svera.untiered.classes.view.ClassDetailView;

public class ClassesConfig implements IConfig {
    [Inject]
    public var context:IContext;

    [Inject]
    public var injector:Injector;

    [Inject]
    public var mediatorMap:IMediatorMap;

    [Inject]
    public var commandMap:ISignalCommandMap;

    public function ClassesConfig() {
        super();
    }

    public function configure():void {
        this.injector.map(ClassesModel).asSingleton();
        this.injector.map(CharacterSkinListItemFactory).asSingleton();
        this.injector.map(FocusCharacterSkinSignal).asSingleton();
        this.injector.map(BuySkinTask);
        this.mediatorMap.map(CharacterSkinListItem).toMediator(CharacterSkinListItemMediator);
        this.mediatorMap.map(CharacterSkinListView).toMediator(CharacterSkinListMediator);
        this.mediatorMap.map(CharacterSkinView).toMediator(CharacterSkinMediator);
        this.mediatorMap.map(ClassDetailView).toMediator(ClassDetailMediator);
        this.commandMap.map(LogoutSignal).toCommand(ResetClassDataCommand);
        this.commandMap.map(CharListDataSignal).toCommand(ParseCharListXmlCommand);
        this.commandMap.map(ParseClassesXMLSignal).toCommand(ParseClassesXmlCommand);
        this.commandMap.map(ParseClassesXMLSignal).toCommand(ParseSkinsXmlCommand);
        this.commandMap.map(BuyCharacterSkinSignal).toCommand(BuyCharacterSkinCommand).withGuards(IsAccountRegisteredGuard);
        this.context.lifecycle.afterInitializing(this.init);
    }

    private function init():void {
        var xml:XML = XML(new EmbeddedData.PlayersCXML());
        var parseClasses:ParseClassesXMLSignal = this.injector.getInstance(ParseClassesXMLSignal);
        parseClasses.dispatch(xml);
    }
}
}
