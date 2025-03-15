package svera.untiered.constants {
public class ItemConstants {
    public static const NO_ITEM:int = -1;
    public static const ALL_TYPE:int = 0;
    public static const SWORD_AXE_TYPE:int = 1;
    public static const DAGGER_TYPE:int = 2;
    public static const BOW_CROSSBOW_TYPE:int = 3;
    public static const MACE_LANCE_TYPE:int = 4;
    public static const SHIELD_TYPE:int = 5;
    public static const LEATHER_TYPE:int = 6;
    public static const PLATE_TYPE:int = 7;
    public static const STAFF_WAND_TYPE:int = 8;
    public static const RING_TYPE:int = 9;
    public static const POTION_TYPE:int = 10;
    public static const SPELL_TYPE:int = 11;
    public static const SEAL_TYPE:int = 12;
    public static const CLOAK_TYPE:int = 13;
    public static const ROBE_TYPE:int = 14;
    public static const GUN_TYPE:int = 15;
    public static const HELM_TYPE:int = 16;
    public static const CLAWS_GAUNTLET_TYPE = 17;
    public static const POISON_TYPE:int = 18;
    public static const SKULL_TYPE:int = 19;
    public static const TRAP_TYPE:int = 20;
    public static const DUAL_WIELD_TYPE:int = 21;
    public static const PRISM_TYPE:int = 22;
    public static const SCEPTER_TYPE:int = 23;
    public static const KATANA_SCYTHE_TYPE:int = 24;
    public static const CHAKRAM_TYPE:int = 25;


    public function ItemConstants() {
        super();
    }

    public static function itemTypeToName(type:int):String {
        switch (type) {
            case ALL_TYPE:
                return "Any";
            case SWORD_AXE_TYPE:
                return "Sword, Axe";
            case DAGGER_TYPE:
                return "Dagger";
            case BOW_CROSSBOW_TYPE:
                return "Bow, crossbow";
            case MACE_LANCE_TYPE:
                return "Mace, lance";
            case SHIELD_TYPE:
                return "Shield";
            case LEATHER_TYPE:
                return "Leather Armor";
            case PLATE_TYPE:
                return "Armor";
            case STAFF_WAND_TYPE:
                return "Staff, Wand";
            case RING_TYPE:
                return "Accessory";
            case POTION_TYPE:
                return "Potion";
            case SPELL_TYPE:
                return "Spell";
            case SEAL_TYPE:
                return "Holy Seal";
            case CLOAK_TYPE:
                return "Cloak";
            case ROBE_TYPE:
                return "Robe";
            case GUN_TYPE:
                return "Gun";
            case HELM_TYPE:
                return "Helm";
            case CLAWS_GAUNTLET_TYPE:
                return "Claws, Gauntlet";
            case POISON_TYPE:
                return "Poison";
            case SKULL_TYPE:
                return "Skull";
            case TRAP_TYPE:
                return "Trap";
            case DUAL_WIELD_TYPE:
                return "Orb";
            case PRISM_TYPE:
                return "Prism";
            case SCEPTER_TYPE:
                return "Scepter";
            case KATANA_SCYTHE_TYPE:
                return "Katana, Scythe";
            case CHAKRAM_TYPE:
                return "Chakram";
            default:
                return "Invalid Type!";
        }
    }
}
}
