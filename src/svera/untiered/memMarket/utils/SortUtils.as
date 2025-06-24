package svera.untiered.memMarket.utils {
import com.company.assembleegameclient.objects.ObjectLibrary;

import svera.untiered.memMarket.MemMarket;
import svera.untiered.memMarket.content.MemMarketItem;

public class SortUtils
{
    /* Sorting options */
    public static const LOWEST_TO_HIGHEST:String = "Lowest -> Highest";
    public static const HIGHEST_TO_LOWEST:String = "Highest -> Lowest";
    public static const JUST_ADDED:String = "Just added";
    public static const ENDING_SOON:String = "Ending soon";

    public static const ALLTIERS:String = "All Tiers";
    public static const TARNISHED:String = "Tarnished";
    public static const ARTIFACT:String = "Artifact";
    public static const VALIANT:String = "Valiant";
    public static const RELIC:String = "Relic";
    public static const EXILED:String = "Exiled";

    public static const ALLSTATS:String = "All Stats";
    public static const HP:String = "Health";
    public static const MP:String = "Mana";
    public static const ATK:String = "Attack";
    public static const DEF:String = "Dmg R";
    public static const SPD:String = "Speed";
    public static const VIT:String = "Vigor";
    public static const WIS:String = "Intellect";
    public static const DEX:String = "Dexterity";
    public static const FRT:String = "Fortune";
    public static const MGT:String = "Crit D";
    public static const LCK:String = "Crit C";
    public static const RES:String = "Restoration";
    public static const PRT:String = "Overshield";

    public static const ALLITEMTYPES:String = "All Types";
    public static const SWORD:String = "Sword";
    public static const DAGGER:String = "Dagger";
    public static const BOW:String = "Bow";
    public static const WAND:String = "Wand";
    public static const STAFF:String = "Staff";
    public static const KATANA:String = "Katana";
    public static const LANCE:String = "Lance";
    public static const BLADES:String = "Blades";
    public static const LIGHTARMOR:String = "L-Armor";
    public static const MEDIUMARMOR:String = "M-Armor";
    public static const HEAVYARMOR:String = "H-Armor";
    public static const TOME:String = "Tome";
    public static const SHIELD:String = "Shield";
    public static const SPELL:String = "Spell";
    public static const SEAL:String = "Seal";
    public static const CLOAK:String = "Cloak";
    public static const QUIVER:String = "Quiver";
    public static const HELMET:String = "Helmet";
    public static const POISON:String = "Poison";
    public static const SKULL:String = "Skull";
    public static const TRAP:String = "Trap";
    public static const ORB:String = "Orb";
    public static const PRISM:String = "Prism";
    public static const SCEPTER:String = "Scepter";
    public static const SHURIKEN:String = "Shuriken";
    public static const SHEATH:String = "Sheath";
    public static const BANNER:String = "Banner";
    public static const SIPHON:String = "Siphon";
    public static const CHARM:String = "Charm";
    public static const DICE:String = "Dice";
    public static const JACKET:String = "Jacket";
    public static const TALISMAN:String = "Talisman";
    public static const ACCESSORY:String = "Accessory";
    public static const INGREDIENT:String = "Ingredients";
    public static const UTILITY:String = "Utility";
    public static const CAPSULE:String = "Capsule";

    public static const SORT_CHOICES:Vector.<String> = new <String>
    [
        LOWEST_TO_HIGHEST,
        HIGHEST_TO_LOWEST,
        //FAME_TO_GOLD,
        //GOLD_TO_FAME,
        JUST_ADDED,
        ENDING_SOON
    ];
    public static const TIER_SORT_CHOICES:Vector.<String> = new <String>
    [
        ALLTIERS,
        TARNISHED,
        ARTIFACT,
        VALIANT,
        RELIC,
        EXILED
    ];
    public static const STAT_SORT_CHOICES:Vector.<String> = new <String>
    [
        ALLSTATS,
        HP,
        MP,
        ATK,
        DEF,
        SPD,
        VIT,
        WIS,
        DEX,
        FRT,
        MGT,
        LCK,
        RES,
        PRT
    ];
    public static const ITEMTYPE_SORT_CHOICES:Vector.<String> = new <String>
    [
        ALLITEMTYPES,
        SWORD,
        DAGGER,
        BOW,
        WAND,
        STAFF,
        KATANA,
        LANCE,
        BLADES,
        LIGHTARMOR,
        MEDIUMARMOR,
        HEAVYARMOR,
        TOME,
        SHIELD,
        SPELL,
        SEAL,
        CLOAK,
        QUIVER,
        HELMET,
        POISON,
        SKULL,
        TRAP,
        ORB,
        PRISM,
        SCEPTER,
        SHURIKEN,
        SHEATH,
        BANNER,
        SIPHON,
        CHARM,
        DICE,
        JACKET,
        TALISMAN,
        ACCESSORY,
        INGREDIENT,
        UTILITY,
        CAPSULE
    ];
    public static function lowestToHighest(itemA:MemMarketItem, itemB:MemMarketItem) : int
    {
        if (itemA.data_.price_ < itemB.data_.price_)
        {
            return -1;
        }
        else if (itemA.data_.price_ > itemB.data_.price_)
        {
            return 1;
        }
        else return 0;
    }

    public static function highestToLowest(itemA:MemMarketItem, itemB:MemMarketItem) : int
    {
        if (itemA.data_.price_ < itemB.data_.price_)
        {
            return 1;
        }
        else if (itemA.data_.price_ > itemB.data_.price_)
        {
            return -1;
        }
        else return 0;
    }

    /*public static function honorToGold(itemA:MemMarketItem, itemB:MemMarketItem) : int
    {
        if (itemA.data_.currency_ < itemB.data_.currency_)
        {
            return 1;
        }
        else if (itemA.data_.currency_ > itemB.data_.currency_)
        {
            return -1;
        }
        else return 0;
    }

    public static function goldToHonor(itemA:MemMarketItem, itemB:MemMarketItem) : int
    {
        if (itemA.data_.currency_ < itemB.data_.currency_)
        {
            return -1;
        }
        else if (itemA.data_.currency_ > itemB.data_.currency_)
        {
            return 1;
        }
        else return 0;
    } */

    public static function justAdded(itemA:MemMarketItem, itemB:MemMarketItem) : int
    {
        if (itemA.data_.startTime_ < itemB.data_.startTime_)
        {
            return 1;
        }
        else if (itemA.data_.startTime_ > itemB.data_.startTime_)
        {
            return -1;
        }
        else return 0;
    }

    public static function endingSoon(itemA:MemMarketItem, itemB:MemMarketItem) : int
    {
        if (itemA.data_.timeLeft_ < itemB.data_.timeLeft_)
        {
            return -1;
        }
        else if (itemA.data_.timeLeft_ > itemB.data_.timeLeft_)
        {
            return 1;
        }
        else return 0;
    }
}
}
