package svera.untiered.constants {
public class ItemConstants {
    public static const NO_ITEM:int = 0;
    public static const ALL_TYPE:int = 0;
    public static const SWORD_AXE_TYPE:int = 1;
    public static const DAGGER_TYPE:int = 2;
    public static const BOW_CROSSBOW_TYPE:int = 3;
    public static const MACE_LANCE_TYPE:int = 4;
    public static const SHIELD_OLD_TYPE:int = 5;
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
    public static const CLAWS_GAUNTLET_TYPE:int = 17;
    public static const POISON_TYPE:int = 18;
    public static const SKULL_TYPE:int = 19;
    public static const TRAP_OLD_TYPE:int = 20;
    public static const DUAL_WIELD_TYPE:int = 21;
    public static const PRISM_TYPE:int = 22;
    public static const SCEPTER_TYPE:int = 23;
    public static const KATANA_SCYTHE_TYPE:int = 24;
    public static const CHAKRAM_TYPE:int = 25;
    public static const MASK_TYPE:int = 26
    public static const BALLOON_FRIEND_TYPE:int = 27
    public static const COUNTER_TYPE:int = 28
    public static const SACRIFICIAL_SPIRIT_TYPE:int = 29
    public static const PLANT_SHACKLE_TYPE:int = 30
    public static const FOCUS_MANA_TYPE:int = 31
    public static const LEECHING_VIGOR_TYPE:int = 32
    public static const CURSE_TYPE:int = 33
    public static const Z_DASH_TYPE:int = 34
    public static const MORALE_RAISE_TYPE:int = 35
    public static const SWEEP_TYPE:int = 36
    public static const LAST_STAND_TYPE:int = 37
    public static const REWARDING_BLOW_TYPE:int = 38
    public static const BOUNCE_TYPE:int = 39
    public static const DISTRACT_TYPE:int = 40
    public static const EMPOWER_ARROW_TYPE:int = 41
    public static const ARROW_SPLIT_TYPE:int = 42
    public static const TORCH_TYPE:int = 43
    public static const SPEED_TRIGGER_TYPE:int = 44
    public static const TROPHIE_RECOGNITION_TYPE:int = 45
    public static const TRAP_TYPE:int = 46
    public static const FEAR_MONGER_TYPE:int = 47
    public static const SERRATION_TYPE:int = 48
    public static const RALLY_TYPE:int = 49
    public static const ENHANCE_RANGE_TYPE:int = 50
    public static const ATTENTION_SEEK_TYPE:int = 51
    public static const SHIELD_TYPE:int = 52
    public static const INFLATE_POWER_TYPE:int = 53
    public static const AIRSTRIKE_TYPE:int = 54
    public static const EARTH_SHATTER_TYPE:int = 55


    public function ItemConstants() {
        super();
    }

    public static function itemTypeToName(itemType:int):String {
        switch (itemType) {
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
            case SHIELD_OLD_TYPE:
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
            case TRAP_OLD_TYPE:
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
            case MASK_TYPE:
                return "Mask";
            case BALLOON_FRIEND_TYPE:
                return "Balloon-Friend";
            case COUNTER_TYPE:
                return "Counter";
            case SACRIFICIAL_SPIRIT_TYPE:
                return "Sacrificial-Spirit";
            case PLANT_SHACKLE_TYPE:
                return "Plant-Shackle";
            case FOCUS_MANA_TYPE:
                return "Focus-Mana";
            case LEECHING_VIGOR_TYPE:
                return "Leeching-Vigor";
            case CURSE_TYPE:
                return "Curse";
            case Z_DASH_TYPE:
                return "Z-Dash";
            case MORALE_RAISE_TYPE:
                return "Morale-Raise";
            case SWEEP_TYPE:
                return "Sweep";
            case LAST_STAND_TYPE:
                return "Last-Stand";
            case REWARDING_BLOW_TYPE:
                return "Rewarding-Blow";
            case BOUNCE_TYPE:
                return "Bounce";
            case DISTRACT_TYPE:
                return "Distract";
            case EMPOWER_ARROW_TYPE:
                return "Empower-Arrow";
            case ARROW_SPLIT_TYPE:
                return "Arrow-Split";
            case TORCH_TYPE:
                return "Torch";
            case SPEED_TRIGGER_TYPE:
                return "Speed-Trigger";
            case TROPHIE_RECOGNITION_TYPE:
                return "Trophie-Recognition";
            case TRAP_TYPE:
                return "Trap";
            case FEAR_MONGER_TYPE:
                return "Fear-Monger";
            case SERRATION_TYPE:
                return "Serration";
            case RALLY_TYPE:
                return "Rally";
            case ENHANCE_RANGE_TYPE:
                return "Enhance-Range";
            case ATTENTION_SEEK_TYPE:
                return "Attention-Seek";
            case SHIELD_TYPE:
                return "Shield";
            case INFLATE_POWER_TYPE:
                return "Inflate-Power";
            case AIRSTRIKE_TYPE:
                return "Airstrike";
            case EARTH_SHATTER_TYPE:
                return "Earth-Shatter";
            default:
                return "Invalid Type!";
        }
    }
}
}
