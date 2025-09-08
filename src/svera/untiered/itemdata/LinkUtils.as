package svera.untiered.itemdata {
import svera.untiered.messaging.impl.data.StatData;

public class LinkUtils {

    public static function parseElementInt(xml:XML, name:String, def:int = 0, base:int = 10): int {
        if (xml.hasOwnProperty(name))
            return parseInt(xml.child(name), base);
        return def;
    }

    public static function parseElementFloat(xml:XML, name:String, def:Number = 0): Number {
        if (xml.hasOwnProperty(name))
            return parseFloat(xml.child(name));
        return def;
    }

    public static function parseElementString(xml:XML, name:String, def:String = ""): String {
        if (xml.hasOwnProperty(name))
            return String(xml.child(name));
        return def;
    }

    public static function parseElementBool(xml:XML, name:String): Boolean {
        return xml.hasOwnProperty(name);
    }

    public static function parseAttributeInt(xml:XML, name:String, def:int = 0, base:int = 10): int {
        if (xml.hasOwnProperty(name))
            return parseInt(xml.attribute(name.slice(1)), base);
        return def;
    }

    public static function parseAttributeFloat(xml:XML, name:String, def:Number = 0): Number {
        if (xml.hasOwnProperty(name))
            return parseFloat(xml.attribute(name.slice(1)));
        return def;
    }

    public static function parseAttributeString(xml:XML, name:String, def:String = ""): String {
        if (xml.hasOwnProperty(name))
            return String(xml.attribute(name.slice(1)));
        return def;
    }

    public static function parseAttributeBool(xml:XML, name:String, def:Boolean = false): Boolean {
        if (xml.hasOwnProperty(name))
                return xml.attribute(name.slice(1)) == "true";
        return def;
    }

    public static function parseAttributeFromElementString(xml:XML, name:String, att:String, def:String = ""): String {
        if (xml.hasOwnProperty(name))
                return String(xml.elements(name)[0].attribute(att.slice(1)));
        return def;
    }

    public static function parseAttributeFromElementInt(xml:XML, name:String, att:String, def:int = -1, base:int = 10): int {
        if (xml.hasOwnProperty(name))
            return parseInt(xml.elements(name)[0].attribute(att.slice(1)), base);
        return def;
    }

    public static function getStatIndex(stat:int): int {
        switch (stat) {
            case StatData.MAXHP:
                return 0;
            case StatData.MAXRP:
                return 1;
            case StatData.ATTACK:
                return 2;
            case StatData.ARMOR:
                return 3;
            case StatData.SPEED:
                return 4;
            case StatData.DEXTERITY:
                return 5;
            case StatData.VIGOR: //TODO: It was vitality
                return 6;
            case StatData.INTELLECT:
                return 7;
            case StatData.MIGHT:
                return 8;
            case StatData.LUCK:
                return 9;
            case StatData.RESTORATION:
                return 10;
            case StatData.PROTECTION:
                return 11;
            case StatData.FORTUNE:
                return 14;
            case StatData.EVASION:
                return 15;
            default:
                return -1;
        }
    }

    public static function statIndexToName(statId:int):String {
        switch (statId) {
            case 0:
                return "Maximum HP";
            case 1:
                return "Maximum MP";
            case 2:
                return "Attack";
            case 3:
                return "Damage Resistance";
            case 4:
                return "Speed"
            case 5:
                return "Dexterity";
            case 6:
                return "Vigor";
            case 7:
                return "Intellect";
            case 8:
                return "Critical Damage";
            case 9:
                return "Critical Chance";
            case 10:
                return "Restoration";
            case 11:
                return "Overshield";
            case 14:
                return "Fortune";
            case 15:
                return "Evasion";
        }
        return "Unknown Stat";
    }

    public static function getTierType(id:int): String {
        switch (id) {
            case 0: return "";
            case 1: return "Common";
            case 2: return "Uncommon";
            case 3: return "Tarnished";
            case 4: return "Artifact";
            case 5: return "Ancestral";
            case 6: return "Valiant";
            case 7: return "Relic";
            case 8: return "Exiled";
            case 9: return "Celestial";
            default: return "UnknownTierType";
        }
    }

    public static function getContainerType(id:int): String {
        switch (id) {
            case 0: return "PlayerDropped";
            case 1: return "Soulbound";
            case 2: return "Common";
            case 3: return "Stat";
            case 4: return "Uncommon";
            case 5: return "Tarnished";
            case 6: return "Artifact";
            case 7: return "Ancestral";
            case 8: return "Valiant";
            case 9: return "Relic";
            case 10: return "Exiled";
            default: return "UnknowContainerType";
        }
    }

    public static function getTargetingType(id:int): String {
        switch (id) {
            case 0: return "enemy";
            case 1: return "player";
            case 2: return "mouse";
            default: return "UnknowTargetingType";
        }
    }

    public static function getSlotType(slot:int): String {
        switch (slot) {
            case 1: return "Sword";
            case 2: return "Dagger";
            case 3: return "Bow";
            case 4: return "Tome";
            case 5: return "Shield";
            case 6: return "Medium Armor";
            case 7: return "Heavy Armor";
            case 8: return "Wand";
            case 9: return "Ring";
            case 10: return "Non Equipment";
            case 11: return "Spell";
            case 12: return "Seal";
            case 13: return "Cloak";
            case 14: return "Light Armor";
            case 15: return "Quiver";
            case 16: return "Helmet";
            case 17: return "Staff";
            case 18: return "Poison";
            case 19: return "Skull";
            case 20: return "Trap";
            case 21: return "Orb";
            case 22: return "Prism";
            case 23: return "Scepter";
            case 24: return "Katana";
            case 25: return "Shuriken";
            case 26: return "Eggs";
            case 27: return "Sheath";
            case 28: return "Banner";
            case 29: return "Lance";
            case 30: return "Siphon";
            case 31: return "Turret";
            case 32: return "Charm";
            case 33: return "Dice";
            case 34: return "Dual Blades";
            case 35: return "Jacket";
            case 36: return "Talisman";
            case 37: return "Crafting Ingredient";
            case 38: return "Consumable";
            case 39: return "Capsule";
            case 40: return "";
            case 41: return "";
            default: return "UnknownSlotType";
        }
    }
}
}
