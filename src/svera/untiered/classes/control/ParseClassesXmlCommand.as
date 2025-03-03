package svera.untiered.classes.control {
import svera.untiered.assets.model.CharacterTemplate;
import svera.untiered.classes.model.CharacterClass;
import svera.untiered.classes.model.CharacterClassStat;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.classes.model.ClassesModel;

public class ParseClassesXmlCommand {
    public static const CLASSIC_NAME:String = "Classic";

    [Inject]
    public var data:XML;

    [Inject]
    public var classes:ClassesModel;

    public function ParseClassesXmlCommand() {
        super();
    }

    public function execute():void {
        var object:XML = null;
        var objects:XMLList = this.data.Object;
        for each(object in objects) {
            this.parseCharacterClass(object);
        }
    }

    private function parseCharacterClass(object:XML):void {
        var id:int = object.@type;
        var character:CharacterClass = this.classes.getCharacterClass(id);
        this.populateCharacter(character, object);
    }

    private function populateCharacter(character:CharacterClass, object:XML):void {
        var node:XML = null;
        character.id = object.@type;
        character.name = object.@id;
        character.description = object.Description;
        character.hitSound = object.HitSound;
        character.deathSound = object.DeathSound;
        character.bloodProb = object.BloodProb;
        character.slotTypes = this.parseIntList(object.SlotTypes);
        character.defaultEquipment = this.parseIntList(object.Equipment);
        character.hp = this.parseCharacterStat(object, "MaxHitPoints");
        character.sp = this.parseCharacterStat(object, "MaxShieldPoints");
        character.rp = this.parseCharacterStat(object, "MaxResourcePoints");
        character.attack = this.parseCharacterStat(object, "Attack");
        character.armor = this.parseCharacterStat(object, "Armor");
        character.speed = this.parseCharacterStat(object, "Speed");
        character.dexterity = this.parseCharacterStat(object, "Dexterity");
        character.hpRegeneration = this.parseCharacterStat(object, "HpRegen");
        character.mpRegeneration = this.parseCharacterStat(object, "MpRegen");
        character.skins.addSkin(this.makeDefaultSkin(object), true);
    }

    private function makeDefaultSkin(object:XML):CharacterSkin {
        var file:String = object.AnimatedTexture.File;
        var index:int = object.AnimatedTexture.Index;
        var skin:CharacterSkin = new CharacterSkin();
        skin.id = 0;
        skin.name = CLASSIC_NAME;
        skin.template = new CharacterTemplate(file, index);
        skin.setState(CharacterSkinState.OWNED);
        skin.setIsSelected(true);
        return skin;
    }

    private function parseCharacterStat(xml:XML, name:String):CharacterClassStat {
        var stat:CharacterClassStat = null;
        var main:XML = xml[name][0];
        stat = new CharacterClassStat();
        stat.initial = int(main.toString());
        stat.max = main.@max;
        return stat;
    }

    private function parseIntList(slotTypes:String):Vector.<int> {
        var source:Array = slotTypes.split(",");
        var count:int = source.length;
        var items:Vector.<int> = new Vector.<int>(count, true);
        for (var i:int = 0; i < count; i++) {
            items[i] = int(source[i]);
        }
        return items;
    }
}
}
