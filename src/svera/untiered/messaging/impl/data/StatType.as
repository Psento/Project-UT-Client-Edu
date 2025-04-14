package svera.untiered.messaging.impl.data {
public class StatType {

        public static var Size:int;
        public static var MaxHp:int;
        public static var Hp:int;
        public static var MaxSp:int;
        public static var Sp:int;
        public static var MaxRp:int;
        public static var Rp:int;
        public static var NextLevelExp:int;
        public static var Exp:int;
        public static var Level:int;
        public static var Awakening:int;
        public static var Relic:int;
        public static var Background:int;
        public static var StatPoints:int;
        public static var AscensionPoints:int;
        public static var Inventory:int;
        public static var Attack:int;
        public static var Armor:int;
        public static var Speed:int;
        public static var Vigor:int;
        public static var Intelligence:int;
        public static var Dexterity:int;
        public static var Condition:int;
        public static var NumStars:int;
        public static var Name:int;
        public static var Tex1:int;
        public static var Tex2:int;
        public static var MerchandiseType:int;
        public static var MerchandisePrice:int;
        public static var Tsavorite:int;
        public static var Medallions:int;
        public static var Honor:int;
        public static var Active:int;
        public static var AccountId:int;
        public static var Fame:int;
        public static var MerchandiseCurrency:int;
        public static var Connect:int;
        public static var MerchandiseCount:int;
        public static var MerchandiseMinsLeft:int;
        public static var MerchandiseDiscount:int;
        public static var MerchandiseRankReq:int;
        public static var MaxHpBoost:int;
        public static var MaxSpBoost:int;
        public static var MaxRpBoost:int;
        public static var AttackBoost:int;
        public static var ArmorBoost:int;
        public static var SpeedBoost:int;
        public static var VigorBoost:int;
        public static var IntelligenceBoost:int;
        public static var DexterityBoost:int;
        public static var CharFame:int;
        public static var NextClassQuestFame:int;
        public static var LegendaryRank:int;
        public static var SinkLevel:int;
        public static var AltTexture:int;
        public static var GuildName:int;
        public static var GuildRank:int;
        public static var Breath:int;
        public static var HealthPotionStack:int;
        public static var MagicPotionStack:int;
        public static var Texture:int;
        public static var ItemData:int;
        public static var ItemDataChange:int;
        public static var OwnerAccountId:int;

        public static var PetId:int;
        public static var PetSkin:int;
        public static var PetType:int;
        public static var PetRarity:int;
        public static var PetMaxLevel:int;
        public static var PetUnk1:int;
        public static var PetAbilityPower1:int;
        public static var PetAbilityPower2:int;
        public static var PetAbilityPower3:int;
        public static var PetAbilityLevel1:int;
        public static var PetAbilityLevel2:int;
        public static var PetAbilityLevel3:int;
        public static var PetAbilityType1:int;
        public static var PetAbilityType2:int;
        public static var PetAbilityType3:int;
        public static var Effects2:int;
        public static var Tokens:int;
        public static var DamageMin:int;
        public static var DamageMax:int;
        public static var DamageMinBonus:int;
        public static var DamageMaxBonus:int;
        public static var FortuneBonus:int;
        public static var Rank:int;
        public static var Admin:int;
        public static var Fortune:int;
        public static var RaidToken:int;
        public static var Surge:int;
        public static var Evasion:int;
        public static var Might:int;
        public static var MightBonus:int;
        public static var Luck:int;
        public static var LuckBonus:int;
        public static var Restoration:int;
        public static var Protection:int;
        public static var RestorationBonus:int;
        public static var ProtectionBonus:int;
        public static var ProtectionPoints:int;
        public static var ProtectionPointsMax:int;
        public static var Effect:int;
        public static var MarksEnabled:int;
        public static var Mark:int;
        public static var Node1:int;
        public static var Node2:int;
        public static var Node3:int;
        public static var Node4:int;
        public static var AscensionEnabled:int;
        public static var RageBar:int;
        public static var RestoralEssenceFragments:int;
        public static var ChanceDenom:int;
        public static var SeasonalExperienceGoal:int;
        public static var SeasonalExperience:int;
        public static var SeasonalTier:int;
        public static var SeasonalPremium:int;
        public static var PartyId:int;
        public static var PartyRank:int;
        public static var PartySummoner:int;
        public static var CosmeticPetType:int;
        public static var HasCosmeticPet:int;
        public static var FireFragments:int;
        public static var WaterFragments:int;
        public static var AirFragments:int;
        public static var ElectricFragments:int;
        public static var EarthFragments:int;
        public static var IceFragments:int;
        public static var VoidFragments:int;
        public static var LightFragments:int;

        public static var APotions:int;
        public static var DPotions:int;
        public static var SPotions:int;
        public static var DEPotions:int;
        public static var VPotions:int;
        public static var WPotions:int;
        public static var LPotions:int;
        public static var MPotions:int;
        public static var RPotions:int;
        public static var LUPotions:int;
        public static var MIPotions:int;
        public static var PPotions:int;
        public static var FireAspect:int;
        public static var WaterAspect:int;
        public static var AirAspect:int;
        public static var ElectricAspect:int;
        public static var EarthAspect:int;
        public static var IceAspect:int;
        public static var VoidAspect:int;
        public static var LightAspect:int;
        public static var EvasionBonus:int;

        public static var LegendaryLootbox:int;
        public static var EventLootbox:int;
        public static var GoldLootbox:int;
        public static var EliteLootbox:int;
        public static var PremiumLootbox:int;
        public static var Effects3:int;

        public static var MiningTier:int;
        public static var LumberTier:int;
        public static var ForageTier:int;

        loadTypes();

        private static function loadTypes(): void {
                for (var i:int = 0; i < types.length; i++) {
                        StatType[types[i]] = i;
                }
        }


        private static var types:Vector.<String> = new <String>[
                "Size",
                "MaxHp",
                "Hp",
                "MaxSp",
                "Sp",
                "MaxRp",
                "Rp",
                "NextLevelExp",
                "Exp",
                "Level",
                "Awakening",
                "Relic",
                "Background",
                "StatPoints",
                "AscensionPoints",
                "Inventory",
                "Attack",
                "Armor",
                "Speed",
                "Vigor",
                "Intelligence",
                "Dexterity",
                "Condition",
                "NumStars",
                "Name",
                "Tex1",
                "Tex2",
                "MerchandiseType",
                "MerchandisePrice",
                "Tsavorite",
                "Medallions",
                "Honor",
                "Active",
                "AccountId",
                "Fame",
                "MerchandiseCurrency",
                "Connect",
                "MerchandiseCount",
                "MerchandiseMinsLeft",
                "MerchandiseDiscount",
                "MerchandiseRankReq",
                "MaxHpBoost",
                "MaxSpBoost",
                "MaxRpBoost",
                "AttackBoost",
                "ArmorBoost",
                "SpeedBoost",
                "VigorBoost",
                "IntelligenceBoost",
                "DexterityBoost",
                "CharFame",
                "NextClassQuestFame",
                "LegendaryRank",
                "SinkLevel",
                "AltTexture",
                "GuildName",
                "GuildRank",
                "Breath",
                "HealthPotionStack",
                "MagicPotionStack",
                "Texture",
                "ItemData",
                "ItemDataChange",
                "OwnerAccountId",

                "PetId",
                "PetSkin",
                "PetType",
                "PetRarity",
                "PetMaxLevel",
                "PetUnk1",
                "PetAbilityPower1",
                "PetAbilityPower2",
                "PetAbilityPower3",
                "PetAbilityLevel1",
                "PetAbilityLevel2",
                "PetAbilityLevel3",
                "PetAbilityType1",
                "PetAbilityType2",
                "PetAbilityType3",
                "Effects2",
                "Tokens",
                "DamageMin",
                "DamageMax",
                "DamageMinBonus",
                "DamageMaxBonus",
                "FortuneBonus",
                "Rank",
                "Admin",
                "Fortune",
                "RaidToken",
                "Surge",
                "Evasion",
                "Might",
                "MightBonus",
                "Luck",
                "LuckBonus",
                "Restoration",
                "Protection",
                "RestorationBonus",
                "ProtectionBonus",
                "ProtectionPoints",
                "ProtectionPointsMax",
                "Effect",
                "MarksEnabled",
                "Mark",
                "Node1",
                "Node2",
                "Node3",
                "Node4",
                "AscensionEnabled",
                "RageBar",
                "RestoralEssenceFragments",
                "ChanceDenom",
                "SeasonalExperienceGoal",
                "SeasonalExperience",
                "SeasonalTier",
                "SeasonalPremium",
                "PartyId",
                "PartyRank",
                "PartySummoner",
                "CosmeticPetType",
                "HasCosmeticPet",
                "FireFragments",
                "WaterFragments",
                "AirFragments",
                "ElectricFragments",
                "EarthFragments",
                "IceFragments",
                "VoidFragments",
                "LightFragments",

                "APotions",
                "DPotions",
                "SPotions",
                "DEPotions",
                "VPotions",
                "WPotions",
                "LPotions",
                "MPotions",
                "RPotions",
                "LUPotions",
                "MIPotions",
                "PPotions",
                "FireAspect",
                "WaterAspect",
                "AirAspect",
                "ElectricAspect",
                "EarthAspect",
                "IceAspect",
                "VoidAspect",
                "LightAspect",
                "EvasionBonus",

                "LegendaryLootbox",
                "EventLootbox",
                "GoldLootbox",
                "EliteLootbox",
                "PremiumLootbox",
                "Effects3",

                "MiningTier",
                "LumberTier",
                "ForageTier"
        ];
}
}
