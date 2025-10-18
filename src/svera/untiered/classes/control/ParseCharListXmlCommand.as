package svera.untiered.classes.control {

import svera.lib.framework.ICommand;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.classes.model.ClassesModel;

public class ParseCharListXmlCommand implements ICommand {
    [Inject]
    public var data:XML;

    [Inject]
    public var model:ClassesModel;

    public function ParseCharListXmlCommand() {
        super();
    }

    public function execute():void {
        this.parseOwnership();
    }

    private function parseOwnership():void {
        var owned:int = 0;
        var skin:CharacterSkin = null;
        var ownership:Array = Boolean(this.data.OwnedSkins.length()) ? this.data.OwnedSkins.split(",") : [];
        for each(owned in ownership) {
            skin = this.model.getCharacterSkin(owned);
            if (skin) {
                skin.setState(CharacterSkinState.OWNED);
            }
        }
    }
}
}
