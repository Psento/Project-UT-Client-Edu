package svera.untiered.messaging.impl.data {
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class StatData {
    public static const SIZE_STAT:int = 0;
    public static const MAX_HP_STAT:int = 1;
    public static const HP_STAT:int = 2;
    public static const MAX_SP_STAT:int = 3;
    public static const SP_STAT:int = 4;
    public static const MAX_RP_STAT:int = 5;
    public static const RP_STAT:int = 6;
    public static const NEXT_LEVEL_EXP_STAT:int = 7;
    public static const EXP_STAT:int = 8;
    public static const LEVEL_STAT:int = 9;
    public static const AWAKENING_STAT:int = 10;
    public static const RELIC_STAT:int = 11;
    public static const BACKGROUND_STAT:int = 12;
    public static const STATPOINTS_STAT:int = 13;
    public static const ASCENSIONPOINTS_STAT:int = 14;
    public static const INVENTORY_0_STAT:int = 15;
    public static const INVENTORY_1_STAT:int = 16;
    public static const INVENTORY_2_STAT:int = 17;
    public static const INVENTORY_3_STAT:int = 18;
    public static const INVENTORY_4_STAT:int = 19;
    public static const INVENTORY_5_STAT:int = 20;
    public static const INVENTORY_6_STAT:int = 21;
    public static const INVENTORY_7_STAT:int = 22;
    public static const INVENTORY_8_STAT:int = 23;
    public static const INVENTORY_9_STAT:int = 24;
    public static const INVENTORY_10_STAT:int = 25;
    public static const INVENTORY_11_STAT:int = 26;
    public static const INVENTORY_12_STAT:int = 27;
    public static const INVENTORY_13_STAT:int = 28;
    public static const INVENTORY_14_STAT:int = 29;
    public static const INVENTORY_15_STAT:int = 30;
    public static const INVENTORY_16_STAT:int = 31;
    public static const INVENTORY_17_STAT:int = 32;
    public static const INVENTORY_18_STAT:int = 33;
    public static const INVENTORY_19_STAT:int = 34;
    public static const INVENTORY_20_STAT:int = 35;
    public static const INVENTORY_21_STAT:int = 36;
    public static const INVENTORY_22_STAT:int = 37;
    public static const INVENTORY_23_STAT:int = 38;
    public static const INVENTORY_24_STAT:int = 39;
    public static const INVENTORY_25_STAT:int = 40;
    public static const INVENTORY_26_STAT:int = 41;
    public static const INVENTORY_27_STAT:int = 42;
    public static const INVENTORY_28_STAT:int = 43;
    public static const ATTACK_STAT:int = 44;
    public static const ARMOR_STAT:int = 45;
    public static const SPEED_STAT:int = 46;
    public static const VIGOR_STAT:int = 47;
    public static const WISDOM_STAT:int = 48;
    public static const DEXTERITY_STAT:int = 49;
    public static const CONDITION_STAT:int = 50;
    public static const NUM_STARS_STAT:int = 51;
    public static const NAME_STAT:int = 52;
    public static const TEX1_STAT:int = 53;
    public static const TEX2_STAT:int = 54;
    public static const MERCHANDISE_TYPE_STAT:int = 55;
    public static const MERCHANDISE_PRICE_STAT:int = 56;
    public static const TSAVORITE_STAT:int = 57;
    public static const MEDALLIONS_STAT:int = 58;
    public static const HONOR_STAT:int = 59;
    public static const ACTIVE_STAT:int = 60;
    public static const ACCOUNT_ID_STAT:int = 61;
    public static const FAME_STAT:int = 62;
    public static const MERCHANDISE_CURRENCY_STAT:int = 63;
    public static const CONNECT_STAT:int = 64;
    public static const MERCHANDISE_COUNT_STAT:int = 65;
    public static const MERCHANDISE_MINS_LEFT_STAT:int = 66;
    public static const MERCHANDISE_DISCOUNT_STAT:int = 67;
    public static const MERCHANDISE_RANK_REQ_STAT:int = 68;
    public static const MAX_HP_BOOST_STAT:int = 69;
    public static const MAX_SP_BOOST_STAT:int = 70;
    public static const MAX_RP_BOOST_STAT:int = 71;
    public static const ATTACK_BOOST_STAT:int = 72;
    public static const ARMOR_BOOST_STAT:int = 73;
    public static const SPEED_BOOST_STAT:int = 74;
    public static const VIGOR_BOOST_STAT:int = 75;
    public static const INTELLIGENCE_BOOST_STAT:int = 76;
    public static const DEXTERITY_BOOST_STAT:int = 77;
    public static const CHAR_FAME_STAT:int = 78;
    public static const NEXT_CLASS_QUEST_FAME_STAT:int = 79;
    public static const LEGENDARY_RANK_STAT:int = 80;
    public static const SINK_LEVEL_STAT:int = 81;
    public static const ALT_TEXTURE_STAT:int = 82;
    public static const GUILD_NAME_STAT:int = 83;
    public static const GUILD_RANK_STAT:int = 84;
    public static const BREATH_STAT:int = 85;
    public static const HEALTH_POTION_STACK_STAT:int = 86;
    public static const MAGIC_POTION_STACK_STAT:int = 87;
    public static const TEXTURE_STAT:int = 88;
    public static const ITEMDATA_0_STAT:int = 89;
    public static const ITEMDATA_1_STAT:int = 90;
    public static const ITEMDATA_2_STAT:int = 91;
    public static const ITEMDATA_3_STAT:int = 92;
    public static const ITEMDATA_4_STAT:int = 93;
    public static const ITEMDATA_5_STAT:int = 94;
    public static const ITEMDATA_6_STAT:int = 95;
    public static const ITEMDATA_7_STAT:int = 96;
    public static const ITEMDATA_8_STAT:int = 97;
    public static const ITEMDATA_9_STAT:int = 98;
    public static const ITEMDATA_10_STAT:int = 99;
    public static const ITEMDATA_11_STAT:int = 100;
    public static const ITEMDATA_12_STAT:int = 101;
    public static const ITEMDATA_13_STAT:int = 102;
    public static const ITEMDATA_14_STAT:int = 103;
    public static const ITEMDATA_15_STAT:int = 104;
    public static const ITEMDATA_16_STAT:int = 105;
    public static const ITEMDATA_17_STAT:int = 106;
    public static const ITEMDATA_18_STAT:int = 107;
    public static const ITEMDATA_19_STAT:int = 108;
    public static const ITEMDATA_20_STAT:int = 109;
    public static const ITEMDATA_21_STAT:int = 110;
    public static const ITEMDATA_22_STAT:int = 111;
    public static const ITEMDATA_23_STAT:int = 112;
    public static const ITEMDATA_24_STAT:int = 113;
    public static const ITEMDATA_25_STAT:int = 114;
    public static const ITEMDATA_26_STAT:int = 115;
    public static const ITEMDATA_27_STAT:int = 116;
    public static const ITEMDATA_28_STAT:int = 117;
    public static const ITEMDATA_29_STAT:int = 118;
    public static const ITEMDATA_30_STAT:int = 119;
    public static const ITEMDATA_31_STAT:int = 120;
    public static const ITEMDATA_32_STAT:int = 121;
    public static const ITEMDATA_33_STAT:int = 122;
    public static const ITEMDATA_34_STAT:int = 123;
    public static const ITEMDATA_35_STAT:int = 124;
    public static const ITEMDATA_36_STAT:int = 125;
    public static const OWNER_ACCOUNT_ID_STAT:int = 126;
    public static const PetId:int = 127;
    public static const PetSkin:int = 128;
    public static const PetType:int = 129;
    public static const PetRarity:int = 130;
    public static const PetMaxLevel:int = 131;
    public static const PetUnk1:int = 132;
    public static const PetAbilityPower1:int = 133;
    public static const PetAbilityPower2:int = 134;
    public static const PetAbilityPower3:int = 135;
    public static const PetAbilityLevel1:int = 136;
    public static const PetAbilityLevel2:int = 137;
    public static const PetAbilityLevel3:int = 138;
    public static const PetAbilityType1:int = 139;
    public static const PetAbilityType2:int = 140;
    public static const PetAbilityType3:int = 141;
    public static const Effects2:int = 142;
    public static const Tokens:int = 143;
    public static const DamageMin:int = 144;
    public static const DamageMax:int = 145;
    public static const DamageMinBonus:int = 146;
    public static const DamageMaxBonus:int = 147;
    public static const FortuneBonus:int = 148;
    public static const Rank:int = 149;
    public static const Admin:int = 150;
    public static const Fortune:int = 151;
    public static const RaidToken:int = 152;
    public static const Surge:int = 153;
    public static const Evasion:int = 154;
    public static const Might:int = 155;
    public static const MightBonus:int = 156;
    public static const Luck:int = 157;
    public static const LuckBonus:int = 158;
    public static const Restoration:int = 159;
    public static const Protection:int = 160;
    public static const RestorationBonus:int = 161;
    public static const ProtectionBonus:int = 162;
    public static const ProtectionPoints:int = 163;
    public static const ProtectionPointsMax:int = 164;
    public static const Effect:int = 165;
    public static const MarksEnabled:int = 166;
    public static const Mark:int = 167;
    public static const Node1:int = 168;
    public static const Node2:int = 169;
    public static const Node3:int = 170;
    public static const Node4:int = 171;
    public static const AscensionEnabled:int = 172;
    public static const RageBar:int = 173;
    public static const RestoralEssenceFragments:int = 174;
    public static const ChanceDenom:int = 175;
    public static const SeasonalExperienceGoal:int = 176;
    public static const SeasonalExperience:int = 177;
    public static const SeasonalTier:int = 178;
    public static const SeasonalPremium:int = 179;
    public static const PartyId:int = 180;
    public static const PartyRank:int = 181;
    public static const PartySummoner:int = 182;
    public static const CosmeticPetType:int = 183;
    public static const HasCosmeticPet:int = 184;

    
    public static const FireFragments:int = 185;
    public static const WaterFragments:int = 186;
    public static const AirFragments:int = 187;
    public static const ElectricFragments:int = 188;
    public static const EarthFragments:int = 189;
    public static const IceFragments:int = 190;
    public static const VoidFragments:int = 191;
    public static const LightFragments:int = 192;

    public static const APotions:int = 193;
    public static const DPotions:int = 194;
    public static const SPotions:int = 195;
    public static const DEPotions:int = 196;
    public static const VPotions:int = 197;
    public static const WPotions:int = 198;
    public static const LPotions:int = 199;
    public static const MPotions:int = 200;
    public static const RPotions:int = 201;
    public static const LUPotions:int = 202;
    public static const MIPotions:int = 203;
    public static const PPotions:int = 204;
    public static const FireAspect:int = 205;
    public static const WaterAspect:int = 206;
    public static const AirAspect:int = 207;
    public static const ElectricAspect:int = 208;
    public static const EarthAspect:int = 209;
    public static const IceAspect:int = 210;
    public static const VoidAspect:int = 211;
    public static const LightAspect:int = 212;
    public static const EvasionBonus:int = 213;

    public static const LegendaryLootbox:int = 214;
    public static const EventLootbox:int = 215;
    public static const GoldLootbox:int = 216;
    public static const EliteLootbox:int = 217;
    public static const PremiumLootbox:int = 218;

    public static const Effects3:int = 219;

    public static const MiningTier:int = 220;
    public static const LumberTier:int = 221;
    public static const ForageTier:int = 222;

    public static const SURGE:int= 110;


    public var statType_:uint = 0;

    public var statValue_:int;

    public var strStatValue_:String;

    public var uintStatValue:uint;

    public function StatData() {
        super();
    }

    public static function statToName(stat:int):String {
        switch (stat) {
            case 0:
                return "Maximum HP";
            case 1:
                return "Maximum SP";
            case 2:
                return "Maximum RP";
            case 3:
                return "Attack";
            case 4:
                return "Armor";
            case 5:
                return "Speed";
            case 6:
                return "Dexterity";
            case 7:
                return "Vigor";
            case 8:
                return "Intelligence";
            default:
                return "Unknown Stat";
        }
    }

    public function isStringStat():Boolean {
        switch (this.statType_) {
            case NAME_STAT:
            case GUILD_NAME_STAT:
                return true;
            default:
                return false;
        }
    }

    public function parseFromInput(data:IDataInput):void {
        this.statType_ = data.readUnsignedByte();
        if (this.isStringStat()) {
            this.strStatValue_ = data.readUTF();
        } else {
            this.statValue_ = data.readInt();
        }
    }

    public function writeToOutput(data:IDataOutput):void {
        data.writeByte(this.statType_);
        if (this.isStringStat()) {
            data.writeUTF(this.strStatValue_);

        } else {
            data.writeInt(this.statValue_);
        }
    }

    public function toString():String {
        if (this.isStringStat()) {
            return "[" + this.statType_ + ": \"" + this.strStatValue_ + "\"]";
        }
        return "[" + this.statType_ + ": " + this.statValue_ + "]";
    }
}
}
