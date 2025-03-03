package svera.untiered.classes.control {
import svera.untiered.classes.model.CharacterClass;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.classes.model.ClassesModel;

public class ResetClassDataCommand {


    [Inject]
    public var classes:ClassesModel;

    public function ResetClassDataCommand() {
        super();
    }

    public function execute():void {
        var count:int = this.classes.getCount();
        for (var i:int = 0; i < count; i++) {
            this.resetClass(this.classes.getClassAtIndex(i));
        }
    }

    private function resetClass(charClass:CharacterClass):void {
        charClass.setIsSelected(charClass.id == ClassesModel.WIZARD_ID);
        this.resetClassSkins(charClass);
    }

    private function resetClassSkins(charClass:CharacterClass):void {
        var skin:CharacterSkin = null;
        var defaultSkin:CharacterSkin = charClass.skins.getDefaultSkin();
        var count:int = charClass.skins.getCount();
        for (var i:int = 0; i < count; i++) {
            skin = charClass.skins.getSkinAt(i);
            if (skin != defaultSkin) {
                this.resetSkin(charClass.skins.getSkinAt(i));
            }
        }
    }

    private function resetSkin(charSkin:CharacterSkin):void {
        charSkin.setState(CharacterSkinState.NULL);
    }
}
}
