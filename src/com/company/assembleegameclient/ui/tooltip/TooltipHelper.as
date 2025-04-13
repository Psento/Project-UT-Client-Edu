package com.company.assembleegameclient.ui.tooltip {
public class TooltipHelper {
    public static const DEFAULT_COLOR:String = "#FFFF8F";
    public static const BETTER_COLOR:uint = 65280;

    public static const WORSE_COLOR:uint = 16731726;

    public static const NO_DIFF_COLOR:uint = 16777103;

    public static const WIS_BONUS_COLOR:uint = 4219875;

    public static const UNTIERED_COLOR:uint = 9055202;

    public static const SET_COLOR:uint = 16750848;

    public static const LEGENDARY_COLOR:uint = 16776960;

    public static const SACRED_COLOR:uint = 0x6afffb;
    // Untiered Tiers
    public static const COMMON_COLOR:uint = 0x69747a;

    public static const UNCOMMON_COLOR:uint = 0x177e2b;

    public static const TARNISHED_COLOR:uint = 0x224a98;

    public static const ARTIFACT_COLOR:uint = 0x45c3ff;

    public static const ANCESTRAL_COLOR:uint = 0xbc4a9b;

    public static const VALIANT_COLOR:uint = 0xffd647;

    public static const RELIC_COLOR:uint = 0x73172D;

    public static const EXILED_COLOR:uint = 0xeb015f;

    public static const CELESTIAL_COLOR:uint = 0xd1d3ea;
    public function TooltipHelper() {
        super();
    }

    public static function wrapInFontTag(text:String, color:String):String {
        var tagStr:String = "<font color=\"" + color + "\">" + text + "</font>";
        return tagStr;
    }

    public static function getFormattedString(value:Number):String {
        var formatted:Number = int(value * 1000) / 1000;
        return formatted.toString();
    }
}
}
