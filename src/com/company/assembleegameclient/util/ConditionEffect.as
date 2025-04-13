package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.geom.Matrix;

public class ConditionEffect {
    public static const NOTHING:uint = 0;
    public static const DEAD:uint = 1;
    public static const MUTE:uint = 2;
    public static const DEFICIENT:uint = 3;
    public static const SLUGGISH:uint = 4;
    public static const NAUSEA:uint = 5;
    public static const EXHAUST:uint = 6;
    public static const STUNNED:uint = 7;
    public static const BLIND:uint = 8;
    public static const HALLUCINATING:uint = 9;
    public static const DRUNK:uint = 10;
    public static const DISORIENT:uint = 11;
    public static const STUN_IMMUNE:uint = 12;
    public static const INVISIBLE:uint = 13;
    public static const BIND:uint = 14;
    public static const SWIFT:uint = 15;
    public static const HEMORRHAGE:uint = 16;
    public static const VULNERABLE_IMMUNE:uint = 17;
    public static const REGENERATE:uint = 18;
    public static const STRENGTHEN:uint = 19;
    public static const FURY:uint = 20;
    public static const PAUSED:uint = 21;
    public static const CRIPPLE:uint = 22;
    public static const CRIPPLE_IMMUNE:uint = 23;
    public static const IMMORTAL:uint = 24;
    public static const INVULNERABLE:uint = 25;
    public static const HARDEN:uint = 26;
    public static const VULNERABLE:uint = 27;
    public static const HEXED:uint = 28;
    public static const NINJA_SPEEDY:uint = 29;
    public static const CONCUSS:uint = 30;
    public static const NEARSIGHT:uint = 31;
    public static const SLUGGISH_IMMUNE:uint = 32;
    public static const EXHAUST_IMMUNE:uint = 33;
    public static const BIND_IMMUNE:uint = 34;
    public static const TERRIFY:uint = 35;
    public static const TERRIFY_IMMUNE:uint = 36;
    public static const SWIFTNESS:uint = 37;
    public static const FRAGILE:uint = 38;
    public static const FRAGILE_IMMUNE:uint = 39;
    public static const HP_BOOST:uint = 40;
    public static const MP_BOOST:uint = 41;
    public static const ATT_BOOST:uint = 42;
    public static const DEF_BOOST:uint = 43;
    public static const SPD_BOOST:uint = 44;
    public static const DEX_BOOST:uint = 45;
    public static const VIT_BOOST:uint = 46;
    public static const WIS_BOOST:uint = 47;
    public static const CD_BOOST:uint = 48;
    public static const CC_BOOST:uint = 49;
    public static const RES_BOOST:uint = 50;
    public static const SH_BOOST:uint = 51;
    public static const HIDDEN:uint = 52;
    public static const MUTED:int = 53;
    public static const INTELLIGENCE:int = 54;
    public static const PRECISION:int = 55;
    public static const DISABLE:int = 56;
    public static const CHARGE:int = 57;
    public static const WITHER:int = 58;
    public static const GRASPOFZOL:int = 59;
    public static const SAMURAIBERSERK:int = 60;
    public static const TRIBESWARCRY:int = 61;
    public static const RELENTLESS:int = 62;
    public static const VENGEANCE:int = 63;
    public static const MANARECOVERY:int = 64;
    public static const ALLIANCE:int = 65;
    public static const HEALTHRECOVERY:int = 66;
    public static const DEFICIENT_IMMUNE:uint = 67;
    public static const HEMORRHAGE_IMMUNE:uint = 68;
    public static const AAMBITION:uint = 69;
    public static const UNTOUCHABLE:uint = 70;
    public static const FROZENRESOLVE:uint = 71;
    public static const BMEFFECT:uint = 72;
    public static const WARMEDUP:uint = 73;
    public static const KARMASHONOR:uint = 74;
    public static const ONEFORTHETEAM:uint = 75;
    public static const TSUNAMISFURY:uint = 76;
    public static const DOWNED:uint = 77;

    public static const GROUND_DAMAGE:uint = 99;

// batch 1
    public static const DEAD_BIT:uint = 1 << DEAD - 1;
    public static const MUTE_BIT:uint = 1 << MUTE - 1;
    public static const DEFICIENT_BIT:uint = 1 << DEFICIENT - 1;
    public static const SLUGGISH_BIT:uint = 1 << SLUGGISH - 1;
    public static const NAUSEA_BIT:uint = 1 << NAUSEA - 1;
    public static const EXHAUST_BIT:uint = 1 << EXHAUST - 1;
    public static const STUNNED_BIT:uint = 1 << STUNNED - 1;
    public static const BLIND_BIT:uint = 1 << BLIND - 1;
    public static const HALLUCINATING_BIT:uint = 1 << HALLUCINATING - 1;
    public static const DRUNK_BIT:uint = 1 << DRUNK - 1;
    public static const DISORIENT_BIT:uint = 1 << DISORIENT - 1;
    public static const STUN_IMMUNE_BIT:uint = 1 << STUN_IMMUNE - 1;
    public static const INVISIBLE_BIT:uint = 1 << INVISIBLE - 1;
    public static const BIND_BIT:uint = 1 << BIND - 1;
    public static const SWIFT_BIT:uint = 1 << SWIFT - 1;
    public static const HEMORRHAGE_BIT:uint = 1 << HEMORRHAGE - 1;
    public static const VULNERABLE_IMMUNE_BIT:uint = 1 << VULNERABLE_IMMUNE - 1;
    public static const REGENERATE_BIT:uint = 1 << REGENERATE - 1;
    public static const STRENGTHEN_BIT:uint = 1 << STRENGTHEN - 1;
    public static const FURY_BIT:uint = 1 << FURY - 1;
    public static const PAUSED_BIT:uint = 1 << PAUSED - 1;
    public static const CRIPPLE_BIT:uint = 1 << CRIPPLE - 1;
    public static const CRIPPLE_IMMUNE_BIT:uint = 1 << CRIPPLE_IMMUNE - 1;
    public static const IMMORTAL_BIT:uint = 1 << IMMORTAL - 1;
    public static const INVULNERABLE_BIT:uint = 1 << INVULNERABLE - 1;
    public static const HARDEN_BIT:uint = 1 << HARDEN - 1;
    public static const VULNERABLE_BIT:uint = 1 << VULNERABLE - 1;
    public static const HEXED_BIT:uint = 1 << HEXED - 1;
    public static const NINJA_SPEEDY_BIT:uint = 1 << NINJA_SPEEDY - 1;
    public static const CONCUSS_BIT:uint = 1 << CONCUSS - 1;
    public static const NEARSIGHT_BIT:uint = 1 << NEARSIGHT - 1;
    public static const SLUGGISH_IMMUNE_BIT:uint = 1 << SLUGGISH_IMMUNE - 1;

    // batch 2
    public static const EXHAUST_IMMUNE_BIT:uint = 1 << EXHAUST_IMMUNE - FIRST_BATCH_THREASHOLD;
    public static const BIND_IMMUNE_BIT:uint = 1 << BIND_IMMUNE - FIRST_BATCH_THREASHOLD;
    public static const TERRIFY_BIT:uint = 1 << TERRIFY - FIRST_BATCH_THREASHOLD;
    public static const TERRIFY_IMMUNE_BIT:uint = 1 << TERRIFY_IMMUNE - FIRST_BATCH_THREASHOLD;
    public static const SWIFTNESS_BIT:uint = 1 << SWIFTNESS - FIRST_BATCH_THREASHOLD;
    public static const FRAGILE_BIT:uint = 1 << FRAGILE - FIRST_BATCH_THREASHOLD;
    public static const FRAGILE_IMMUNE_BIT:uint = 1 << FRAGILE_IMMUNE - FIRST_BATCH_THREASHOLD;
    public static const HP_BOOST_BIT:uint = 1 << HP_BOOST - FIRST_BATCH_THREASHOLD;
    public static const MP_BOOST_BIT:uint = 1 << MP_BOOST - FIRST_BATCH_THREASHOLD;
    public static const ATT_BOOST_BIT:uint = 1 << ATT_BOOST - FIRST_BATCH_THREASHOLD;
    public static const DEF_BOOST_BIT:uint = 1 << DEF_BOOST - FIRST_BATCH_THREASHOLD;
    public static const SPD_BOOST_BIT:uint = 1 << SPD_BOOST - FIRST_BATCH_THREASHOLD;
    public static const DEX_BOOST_BIT:uint = 1 << DEX_BOOST - FIRST_BATCH_THREASHOLD;
    public static const VIT_BOOST_BIT:uint = 1 << VIT_BOOST - FIRST_BATCH_THREASHOLD;
    public static const WIS_BOOST_BIT:uint = 1 << WIS_BOOST - FIRST_BATCH_THREASHOLD;
    public static const CD_BOOST_BIT:uint = 1 << CD_BOOST - FIRST_BATCH_THREASHOLD;
    public static const CC_BOOST_BIT:uint = 1 << CC_BOOST - FIRST_BATCH_THREASHOLD;
    public static const RES_BOOST_BIT:uint = 1 << RES_BOOST - FIRST_BATCH_THREASHOLD;
    public static const SH_BOOST_BIT:uint = 1 << SH_BOOST - FIRST_BATCH_THREASHOLD;
    public static const HIDDEN_BIT:uint = 1 << HIDDEN - FIRST_BATCH_THREASHOLD;
    public static const MUTED_BIT:int = 1 << MUTED - FIRST_BATCH_THREASHOLD;
    public static const INTELLIGENCE_BIT:int = 1 << INTELLIGENCE - FIRST_BATCH_THREASHOLD;
    public static const PRECISION_BIT:int = 1 << PRECISION - FIRST_BATCH_THREASHOLD;
    public static const DISABLE_BIT:int = 1 << DISABLE - FIRST_BATCH_THREASHOLD;
    public static const CHARGE_BIT:int = 1 << CHARGE - FIRST_BATCH_THREASHOLD;
    public static const WITHER_BIT:int = 1 << WITHER - FIRST_BATCH_THREASHOLD;
    public static const GRASPOFZOL_BIT:int = 1 << GRASPOFZOL - FIRST_BATCH_THREASHOLD;
    public static const SAMURAIBERSERK_BIT:int = 1 << SAMURAIBERSERK - FIRST_BATCH_THREASHOLD;
    public static const TRIBESWARCRY_BIT:int = 1 << TRIBESWARCRY - FIRST_BATCH_THREASHOLD;
    public static const RELENTLESS_BIT:int = 1 << RELENTLESS - FIRST_BATCH_THREASHOLD;
    public static const VENGEANCE_BIT:int = 1 << VENGEANCE - FIRST_BATCH_THREASHOLD;

    // batch 3
    public static const MANARECOVERY_BIT:int = 1 << MANARECOVERY - SECOND_BATCH_THREASHOLD;
    public static const ALLIANCE_BIT:int = 1 << ALLIANCE - SECOND_BATCH_THREASHOLD;
    public static const HEALTHRECOVERY_BIT:int = 1 << HEALTHRECOVERY - SECOND_BATCH_THREASHOLD;
    public static const DEFICIENT_IMMUNE_BIT:uint = 1 << DEFICIENT_IMMUNE - SECOND_BATCH_THREASHOLD;
    public static const HEMORRHAGE_IMMUNE_BIT:uint = 1 << HEMORRHAGE_IMMUNE - SECOND_BATCH_THREASHOLD;
    public static const AAMBITION_BIT:uint = 1 << AAMBITION - SECOND_BATCH_THREASHOLD;
    public static const UNTOUCHABLE_BIT:uint = 1 << UNTOUCHABLE - SECOND_BATCH_THREASHOLD;
    public static const FROZENRESOLVE_BIT:uint = 1 << FROZENRESOLVE - SECOND_BATCH_THREASHOLD;
    public static const BMEFFECT_BIT:uint = 1 << BMEFFECT - SECOND_BATCH_THREASHOLD;
    public static const WARMEDUP_BIT:uint = 1 << WARMEDUP - SECOND_BATCH_THREASHOLD;
    public static const KARMASHONOR_BIT:uint = 1 << KARMASHONOR - SECOND_BATCH_THREASHOLD;
    public static const ONEFORTHETEAM_BIT:uint = 1 << ONEFORTHETEAM - SECOND_BATCH_THREASHOLD;
    public static const TSUNAMISFURY_BIT:uint = 1 << TSUNAMISFURY - SECOND_BATCH_THREASHOLD;
    public static const DOWNED_BIT:uint = 1 << DOWNED - SECOND_BATCH_THREASHOLD;

    // other stuff
    public static const MAP_FILTER_BITMASK:uint = DRUNK_BIT | BLIND_BIT | PAUSED_BIT;
    public static const PROJ_NOHIT_BITMASK:uint = IMMORTAL_BIT | CRIPPLE_BIT | PAUSED_BIT;

    // misc
    public static const CE_FIRST_BATCH:uint = 0;
    public static const CE_SECOND_BATCH:uint = 1;
    public static const CE_THIRD_BATCH:uint = 2;
    public static const FIRST_BATCH_THREASHOLD:uint = 32;
    public static const SECOND_BATCH_THREASHOLD:uint = 64;
    public static const THIRD_BATCH_THREASHOLD:uint = 96;
    private static const GLOW_FILTER:GlowFilter = new GlowFilter(0, 0.3, 6, 6, 2, BitmapFilterQuality.LOW, false, false);

    public static var effects_:Vector.<ConditionEffect> =
            new <ConditionEffect>[
                new ConditionEffect("", 0, null),//Nothing Effect
                new ConditionEffect("Dead", DEAD_BIT, null),
                new ConditionEffect("Mute", MUTE_BIT, [0], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Deficient", DEFICIENT_BIT, [1], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Sluggish", SLUGGISH_BIT, [2], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Nausea", NAUSEA_BIT, [3], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Exhaust", EXHAUST_BIT, [4], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Stunned", STUNNED_BIT, [5], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Blind", BLIND_BIT, [41]),
                new ConditionEffect("Hallucinating", HALLUCINATING_BIT, [42]),
                new ConditionEffect("Drunk", DRUNK_BIT, [43]),
                new ConditionEffect("Disorient", DISORIENT_BIT, [6], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Stun Immune", STUN_IMMUNE_BIT, null),
                new ConditionEffect("Invisible", INVISIBLE_BIT, [7], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Bind", BIND_BIT, [8], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Swift", SWIFT_BIT, [9], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Hemorrhage", HEMORRHAGE_BIT, [10], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Vulnerable Immune", VULNERABLE_IMMUNE_BIT, null),
                new ConditionEffect("Regenerate", REGENERATE_BIT, [11], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Strengthen", STRENGTHEN_BIT, [12], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Fury", FURY_BIT, [13], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Paused", PAUSED_BIT, null),
                new ConditionEffect("Cripple", CRIPPLE_BIT, [14], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Cripple Immune", CRIPPLE_IMMUNE_BIT, null),
                new ConditionEffect("Immortal", IMMORTAL_BIT, null),
                new ConditionEffect("Invulnerable", INVULNERABLE_BIT, [16], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Harden", HARDEN_BIT, [17], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Vulnerable", VULNERABLE_BIT, [18], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Hexed", HEXED_BIT, [42]),
                new ConditionEffect("Ninja Speedy", NINJA_SPEEDY_BIT, [9], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Concuss", CONCUSS_BIT, [19], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Nearsight", NEARSIGHT_BIT, [20], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Sluggish Immune", SLUGGISH_IMMUNE_BIT, null),
                new ConditionEffect("Deficient Immune", DEFICIENT_IMMUNE_BIT, null),
                new ConditionEffect("Hemorrhage Immune", HEMORRHAGE_IMMUNE_BIT, null),
                new ConditionEffect("Exhaust Immune", EXHAUST_IMMUNE_BIT, null),
                new ConditionEffect("Bind Immune", BIND_IMMUNE_BIT, null),
                new ConditionEffect("Terrify", TERRIFY_BIT, [21], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Terrify Immune", TERRIFY_IMMUNE_BIT, null),
                new ConditionEffect("Swiftness", SWIFTNESS_BIT, [72]),
                new ConditionEffect("Fragile", FRAGILE_BIT, [22], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Fragile Immune", FRAGILE_IMMUNE_BIT, null),
                new ConditionEffect("HP Boost", HP_BOOST_BIT, [64], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("MP Boost", MP_BOOST_BIT, [65], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Attack Boost", ATT_BOOST_BIT, [66], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Damage Reduction Boost", DEF_BOOST_BIT, [67], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Speed Boost", SPD_BOOST_BIT, [68], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Vigor Boost", VIT_BOOST_BIT, [70], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Intellect Boost", WIS_BOOST_BIT, [71], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Dexterity Boost", DEX_BOOST_BIT, [69], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Critical Damage Boost", CD_BOOST_BIT, [72], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Critical Chance Boost", CC_BOOST_BIT, [73], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Restoration Boost", RES_BOOST_BIT, [74], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Overshield Boost", SH_BOOST_BIT, [75], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Hidden", HIDDEN_BIT, [27], true),
                new ConditionEffect("Muted", MUTED_BIT, [21], true),
                new ConditionEffect("Intelligence", INTELLIGENCE_BIT, [23], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Precision", PRECISION_BIT, [24], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Disable", DISABLE_BIT, [25], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Charge", CHARGE_BIT, [26], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Wither", WITHER_BIT, [27], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Samurai Berserk", SAMURAIBERSERK_BIT, [50], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Tribe's Warcry", TRIBESWARCRY_BIT, [24], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("GraspofZol", GRASPOFZOL_BIT, [64]),
                new ConditionEffect("Relentless", RELENTLESS_BIT, [67]),
                new ConditionEffect("Vengeance", VENGEANCE_BIT, [68]),
                new ConditionEffect("ManaRecovery", MANARECOVERY_BIT, [69]),
                new ConditionEffect("Alliance", ALLIANCE_BIT, [70]),
                new ConditionEffect("HealthRecovery", HEALTHRECOVERY_BIT, [71]),
                new ConditionEffect("AAmbition", AAMBITION_BIT, null),
                new ConditionEffect("Untouchable", UNTOUCHABLE_BIT, null),
                new ConditionEffect("Frozen Resolve", FROZENRESOLVE_BIT, [17], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("BladeMaster Effect", BMEFFECT_BIT, [9], true, "Assets_StatusIcons16x16"),
                new ConditionEffect("Warmed Up", WARMEDUP_BIT, null),
                new ConditionEffect("Karma's Honor", KARMASHONOR_BIT, null),
                new ConditionEffect("One for the Team", ONEFORTHETEAM_BIT, null),
                new ConditionEffect("Tsunami's Fury", TSUNAMISFURY_BIT, null),
                new ConditionEffect("Downed", DOWNED_BIT, null)
            ];

    private static var conditionEffectFromName_:Object = null;
    private static var effectIconCache:Object = null;
    private static var bitToIcon_:Object = null;
    private static var bitToIcon2_:Object = null;
    private static var bitToIcon3_:Object = null;

    public var name_:String;
    public var bit_:uint;
    public var iconOffsets_:Array;
    public var localizationKey_:String;
    public var icon16Bit_:Boolean;
    public var imageSet_:String;

    public function ConditionEffect(name:String, bit:uint, iconOffsets:Array, icon16Bit:Boolean = false, _imageSet:String = null) {
        name_ = name;
        bit_ = bit;
        iconOffsets_ = iconOffsets;
        localizationKey_ = name;
        icon16Bit_ = icon16Bit;
        imageSet_ = _imageSet;
    }
    public static function getConditionEffectFromName(name:String):uint {
        var ce:uint = 0;
        if (conditionEffectFromName_ == null) {
            conditionEffectFromName_ = {};
            for (ce = 0; ce < effects_.length; ce++) {
                conditionEffectFromName_[effects_[ce].name_] = ce;
            }
        }
        return conditionEffectFromName_[name];
    }

    public static function getConditionEffectIcons(condition:uint, icons:Vector.<BitmapData>, index:int):void {
        var newCondition:uint = 0;
        var bit:uint = 0;
        var iconList:Vector.<BitmapData> = null;
        while (condition != 0) {
            newCondition = condition & condition - 1;
            bit = condition ^ newCondition;
            iconList = getIconsFromBit(bit);
            if (iconList != null) {
                icons.push(iconList[index % iconList.length]);
            }
            condition = newCondition;
        }
    }

    private static function getIconsFromBit(_arg1:uint):Vector.<BitmapData> {
        var drawMatrix:Matrix;
        var ce:uint;
        var icons:Vector.<BitmapData>;
        var i:int;
        var icon:BitmapData;
        var defaultMatrix:Matrix;
        if (bitToIcon_ == null) {
            bitToIcon_ = [];
            drawMatrix = new Matrix();
            drawMatrix.translate(4, 4);
            defaultMatrix = new Matrix();
            defaultMatrix.translate(1, 1);
            ce = 0;
            for (ce = 0; ce < effects_.length; ce++) {
                icons = null;
                if (effects_[ce].iconOffsets_ != null) {
                    icons = new Vector.<BitmapData>();
                    i = 0;
                    for (i = 0; i < effects_[ce].iconOffsets_.length; i++) {
                        if(effects_[ce].imageSet_ != null) {
                            icon = new BitmapDataSpy(18, 18, true, 0);
                            icon.draw(AssetLibrary.getImageFromSet(effects_[ce].imageSet_, effects_[ce].iconOffsets_[i]), defaultMatrix);
                        } else {
                            icon = new BitmapDataSpy(16, 16, true, 0);
                            icon.draw(AssetLibrary.getImageFromSet("lofiInterface2", effects_[ce].iconOffsets_[i]), drawMatrix);
                        }
                        icon = GlowRedrawer.outlineGlow(icon, 0xFFFFFFFF);
                        icon.applyFilter(icon, icon.rect, PointUtil.ORIGIN, GLOW_FILTER);
                        icons.push(icon);
                    }
                }
                bitToIcon_[effects_[ce].bit_] = icons;
            }
        }
        return bitToIcon_[_arg1];
    }

    private static function getIconsFromBit2(_arg1:uint):Vector.<BitmapData> {
        var icons:Vector.<BitmapData>;
        var ce:BitmapData;
        var drawMatrix:Matrix;
        var i:Matrix;
        var icon:uint;
        var defaultMatrix:int;
        if (bitToIcon2_ == null) {
            bitToIcon2_ = [];
            icons = new Vector.<BitmapData>();
            drawMatrix = new Matrix();
            drawMatrix.translate(4, 4);
            i = new Matrix();
            i.translate(1, 1);
            icon = 32;
            while (icon < 64) {
                icons = null;
                if (effects_[icon].iconOffsets_ != null) {
                    icons = new Vector.<BitmapData>();
                    defaultMatrix = 0;
                    while (defaultMatrix < effects_[icon].iconOffsets_.length) {
                        if (effects_[icon].icon16Bit_) {
                            ce = new BitmapDataSpy(18, 18, true, 0);
                            if(effects_[icon].imageSet_ != null)
                                ce.draw(AssetLibrary.getImageFromSet(effects_[icon].imageSet_, effects_[icon].iconOffsets_[i]), i);
                            else
                                ce.draw(AssetLibrary.getImageFromSet("lofiInterfaceBig", effects_[icon].iconOffsets_[i]), i);
                        }
                        else {
                            ce = new BitmapDataSpy(16, 16, true, 0);
                            ce.draw(AssetLibrary.getImageFromSet("lofiInterface2", effects_[icon].iconOffsets_[defaultMatrix]), drawMatrix);
                        }
                        ce = GlowRedrawer.outlineGlow(ce, 0xFFFFFFFF);
                        ce.applyFilter(ce, ce.rect, PointUtil.ORIGIN, GLOW_FILTER);
                        icons.push(ce);
                        defaultMatrix++;
                    }
                }
                bitToIcon2_[effects_[icon].bit_] = icons;
                icon++;
            }
        }
        if (bitToIcon2_ != null && bitToIcon2_[_arg1] != null) {
            return bitToIcon2_[_arg1];
        }
        return null;
    }

    private static function getIconsFromBit3(_arg1:uint):Vector.<BitmapData> {
        var drawMatrix:Vector.<BitmapData>;
        var ce:BitmapData;
        var icons:Matrix;
        var i:Matrix;
        var icon:uint;
        var defaultMatrix:int;
        if (bitToIcon3_ == null) {
            bitToIcon3_ = [];
            drawMatrix = new Vector.<BitmapData>();
            icons = new Matrix();
            icons.translate(4, 4);
            i = new Matrix();
            i.translate(1, 1);
            icon = 64;
            while (icon < effects_.length) {
                drawMatrix = null;
                if (effects_[icon].iconOffsets_ != null) {
                    drawMatrix = new Vector.<BitmapData>();
                    defaultMatrix = 0;
                    while (defaultMatrix < effects_[icon].iconOffsets_.length) {
                        if (effects_[icon].icon16Bit_) {
                            ce = new BitmapDataSpy(18, 18, true, 0);
                            if(effects_[icon].imageSet_ != null)
                                ce.draw(AssetLibrary.getImageFromSet(effects_[icon].imageSet_, effects_[icon].iconOffsets_[defaultMatrix]), i);
                            else
                                ce.draw(AssetLibrary.getImageFromSet("lofiInterfaceBig", effects_[icon].iconOffsets_[defaultMatrix]), i);
                        }
                        else {
                            ce = new BitmapDataSpy(16, 16, true, 0);
                            ce.draw(AssetLibrary.getImageFromSet("lofiInterface2", effects_[icon].iconOffsets_[defaultMatrix]), icons);
                        }
                        ce = GlowRedrawer.outlineGlow(ce, 0xFFFFFFFF);
                        ce.applyFilter(ce, ce.rect, PointUtil.ORIGIN, GLOW_FILTER);
                        drawMatrix.push(ce);
                        defaultMatrix++;
                    }
                }
                bitToIcon3_[effects_[icon].bit_] = drawMatrix;
                icon++;
            }
        }
        if (!(bitToIcon3_ == null) && !(bitToIcon3_[_arg1] == null)) {
            return bitToIcon3_[_arg1];
        }
        return null;
    }
}
}
