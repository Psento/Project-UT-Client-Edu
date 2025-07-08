package svera.untiered.messaging.impl.data {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class StatData {
    public static const SIZE:int = 0;
    public static const MAXHP:int = 1;
    public static const HP:int = 2;
    public static const MAXSP:int = 3;
    public static const SP:int = 4;
    public static const MAXRP:int = 5;
    public static const RP:int = 6;
    public static const NEXTLEVELEXP:int = 7;
    public static const EXP:int = 8;
    public static const LEVEL:int = 9;
    public static const AWAKENING:int = 10;
    public static const RELIC:int = 11;
    public static const BACKGROUND:int = 12;
    public static const STATPOINTS:int = 13;
    public static const ASCENSIONPOINTS:int = 14;
    public static const INVENTORY:int = 15;
    public static const ATTACK:int = 16;
    public static const ARMOR:int = 17;
    public static const SPEED:int = 18;
    public static const VIGOR:int = 19;
    public static const INTELLECT:int = 20;
    public static const DEXTERITY:int = 21;
    public static const OVERSHIELDMAX:int = 22;
    public static const OVERSHIELDDELAY:int = 23;
    public static const OVERSHIELDRECHARGERATE:int = 24;
    public static const MAXSTAMINA:int = 25;
    public static const MAXRAGE:int = 26;
    public static const MAXFURY:int = 27;
    public static const RESILIENCE:int = 28;
    public static const PHYSICALRESIST:int = 29;
    public static const MAGICRESIST:int = 30;
    public static const ELEMENTALRESIST:int = 31;
    public static const FIRERESIST:int = 32;
    public static const WATERRESIST:int = 33;
    public static const WINDRESIST:int = 34;
    public static const ELECTRICRESIST:int = 35;
    public static const EARTHRESIST:int = 36;
    public static const ICERESIST:int = 37;
    public static const VOIDRESIST:int = 38;
    public static const LIGHTRESIST:int = 39;
    public static const BLASTRESIST:int = 40;
    public static const STRENGTH:int = 41;
    public static const PHYSICALDMG:int = 42;
    public static const MAGICALDMG:int = 43;
    public static const FIREDMG:int = 44;
    public static const WATERDMG:int = 45;
    public static const WINDDMG:int = 46;
    public static const ELECTRICDMG:int = 47;
    public static const EARTHDMG:int = 48;
    public static const ICEDMG:int = 49;
    public static const VOIDDMG:int = 50;
    public static const LIGHTDMG:int = 51;
    public static const BLASTDMG:int = 52;
    public static const ABILITYPWR:int = 53;
    public static const CRITICALCHANCE:int = 54;
    public static const CRITICALDAMAGE:int = 55;
    public static const ABILITYCRITCHANCE:int = 56;
    public static const ABILITYCRITDAMAGE:int = 57;
    public static const TENACITY:int = 58;
    public static const ABILITYCOOLDOWN:int = 59;
    public static const DOWNDURATION:int = 60;
    public static const POWER:int = 61;
    public static const DASHCOOLDOWN:int = 62;
    public static const DASHWINDOW:int = 63;
    public static const CONDITION:int = 64;
    public static const NUMSTARS:int = 65;
    public static const NAME:int = 66;
    public static const TEX1:int = 67;
    public static const TEX2:int = 68;
    public static const MERCHANDISETYPE:int = 69;
    public static const MERCHANDISEPRICE:int = 70;
    public static const TSAVORITE:int = 71;
    public static const MEDALLIONS:int = 72;
    public static const HONOR:int = 73;
    public static const ACTIVE:int = 74;
    public static const ACCOUNTID:int = 75;
    public static const MERCHANDISECURRENCY:int = 76;
    public static const CONNECT:int = 77;
    public static const MERCHANDISECOUNT:int = 78;
    public static const MERCHANDISEMINSLEFT:int = 79;
    public static const MERCHANDISEDISCOUNT:int = 80;
    public static const MERCHANDISERANKREQ:int = 81;
    public static const MAXHPBOOST:int = 82;
    public static const MAXSPBOOST:int = 83;
    public static const MAXRPBOOST:int = 84;
    public static const ATTACKBOOST:int = 85;
    public static const ARMORBOOST:int = 86;
    public static const SPEEDBOOST:int = 87;
    public static const VIGORBOOST:int = 88;
    public static const INTELLECTBOOST:int = 89;
    public static const DEXTERITYBOOST:int = 90;
    public static const CHARHONOR:int = 91;
    public static const NEXTCLASSQUESTHONOR:int = 92;
    public static const LEGENDARYRANK:int = 93;
    public static const SINKLEVEL:int = 94;
    public static const ALTTEXTURE:int = 95;
    public static const GUILDNAME:int = 96;
    public static const GUILDRANK:int = 97;
    public static const BREATH:int = 98;
    public static const HEALTHPOTIONSTACK:int = 99;
    public static const MAGICPOTIONSTACK:int = 100;
    public static const TEXTURE:int = 101;
    public static const OWNERACCOUNTID:int = 102;
    public static const PETID:int = 103;
    public static const PETSKIN:int = 104;
    public static const PETTYPE:int = 105;
    public static const PETRARITY:int = 106;
    public static const PETMAXLEVEL:int = 107;
    public static const PETUNK1:int = 108;
    public static const PETABILITYPOWER1:int = 109;
    public static const PETABILITYPOWER2:int = 110;
    public static const PETABILITYPOWER3:int = 111;
    public static const PETABILITYLEVEL1:int = 112;
    public static const PETABILITYLEVEL2:int = 113;
    public static const PETABILITYLEVEL3:int = 114;
    public static const PETABILITYTYPE1:int = 115;
    public static const PETABILITYTYPE2:int = 116;
    public static const PETABILITYTYPE3:int = 117;
    public static const EFFECTS2:int = 118;
    public static const TOKENS:int = 119;
    public static const DAMAGEMIN:int = 120;
    public static const DAMAGEMAX:int = 121;
    public static const DAMAGEMINBONUS:int = 122;
    public static const DAMAGEMAXBONUS:int = 123;
    public static const FORTUNEBONUS:int = 124;
    public static const RANK:int = 125;
    public static const ADMIN:int = 126;
    public static const FORTUNE:int = 127;
    public static const RAIDTOKEN:int = 128;
    public static const SURGE:int = 129;
    public static const EVASION:int = 130;
    public static const MIGHT:int = 131;
    public static const MIGHTBONUS:int = 132;
    public static const LUCK:int = 133;
    public static const LUCKBONUS:int = 134;
    public static const RESTORATION:int = 135;
    public static const PROTECTION:int = 136;
    public static const RESTORATIONBONUS:int = 137;
    public static const PROTECTIONBONUS:int = 138;
    public static const PROTECTIONPOINTS:int = 139;
    public static const PROTECTIONPOINTSMAX:int = 140;
    public static const EFFECT:int = 141;
    public static const MARKSENABLED:int = 142;
    public static const MARK:int = 143;
    public static const NODE1:int = 144;
    public static const NODE2:int = 145;
    public static const NODE3:int = 146;
    public static const NODE4:int = 147;
    public static const ASCENSIONENABLED:int = 148;
    public static const RAGEBAR:int = 149;
    public static const RESTORALESSENCEFRAGMENTS:int = 150;
    public static const CHANCEDENOM:int = 151;
    public static const SEASONALEXPERIENCEGOAL:int = 152;
    public static const SEASONALEXPERIENCE:int = 153;
    public static const SEASONALTIER:int = 154;
    public static const SEASONALPREMIUM:int = 155;
    public static const PARTYID:int = 156;
    public static const PARTYRANK:int = 157;
    public static const PARTYSUMMONER:int = 158;
    public static const COSMETICPETTYPE:int = 159;
    public static const HASCOSMETICPET:int = 160;
    public static const FIREFRAGMENTS:int = 161;
    public static const WATERFRAGMENTS:int = 162;
    public static const AIRFRAGMENTS:int = 163;
    public static const ELECTRICFRAGMENTS:int = 164;
    public static const EARTHFRAGMENTS:int = 165;
    public static const ICEFRAGMENTS:int = 166;
    public static const VOIDFRAGMENTS:int = 167;
    public static const LIGHTFRAGMENTS:int = 168;
    public static const APOTIONS:int = 169;
    public static const DPOTIONS:int = 170;
    public static const SPOTIONS:int = 171;
    public static const DEPOTIONS:int = 172;
    public static const VPOTIONS:int = 173;
    public static const WPOTIONS:int = 174;
    public static const LPOTIONS:int = 175;
    public static const MPOTIONS:int = 176;
    public static const RPOTIONS:int = 177;
    public static const LUPOTIONS:int = 178;
    public static const MIPOTIONS:int = 179;
    public static const PPOTIONS:int = 180;
    public static const FIREASPECT:int = 181;
    public static const WATERASPECT:int = 182;
    public static const AIRASPECT:int = 183;
    public static const ELECTRICASPECT:int = 184;
    public static const EARTHASPECT:int = 185;
    public static const ICEASPECT:int = 186;
    public static const VOIDASPECT:int = 187;
    public static const LIGHTASPECT:int = 188;
    public static const EVASIONBONUS:int = 189;
    public static const LEGENDARYLOOTBOX:int = 190;
    public static const EVENTLOOTBOX:int = 191;
    public static const GOLDLOOTBOX:int = 192;
    public static const ELITELOOTBOX:int = 193;
    public static const PREMIUMLOOTBOX:int = 194;
    public static const EFFECTS3:int = 195;
    public static const MININGTIER:int = 196;
    public static const LUMBERTIER:int = 197;
    public static const FORAGETIER:int = 198;



    public var statType_:uint = 0;

    public var statValue_:int;

    public var strStatValue_:String;

    public var uintStatValue:uint;
    public var statByteArray:ByteArray;


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
            case NAME:
            case GUILDNAME:
            case EFFECT:
                return true;
            default:
                return false;
        }
    }

    public function parseFromInput(data:IDataInput):void {
        this.statType_ = data.readUnsignedByte();
        if (this.isStringStat()) {
            this.strStatValue_ = data.readUTF();
        }else if (statType_ == INVENTORY) {
            var len:Number = data.readShort();
            statByteArray = new ByteArray();
            for(var i:Number = 0; i < len; i++) {
                this.statByteArray.writeByte(data.readUnsignedByte());
            }
            this.statByteArray.endian = "littleEndian";
            this.statByteArray.position = 0;
            return;
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
