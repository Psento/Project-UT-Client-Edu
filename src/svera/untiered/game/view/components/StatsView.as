package svera.untiered.game.view.components {
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;

import mx.utils.StringUtil;

import svera.untiered.game.model.StatModel;

public class StatsView extends Sprite {

    public static const ATTACK:int = 0;
    public static const ARMOR:int = 1;
    public static const SPEED:int = 2;
    public static const DEXTERITY:int = 3;
    public static const VIGOR:int = 4;
    public static const INTELLECT:int = 5;
    public static const OVERSHIELDMAX:int = 6;
    public static const OVERSHIELDDELAY:int = 7;
    public static const OVERSHIELDRECHARGERATE:int = 8;
    public static const RESILIENCE:int = 9;
    public static const PHYSICALRESIST:int = 10;
    public static const MAGICRESIST:int = 11;
    public static const ELEMENTALRESIST:int = 12;
    public static const FIRERESIST:int = 13;
    public static const WATERRESIST:int = 14;
    public static const WINDRESIST:int = 15;
    public static const ELECTRICRESIST:int = 16;
    public static const EARTHRESIST:int = 17;
    public static const ICERESIST:int = 18;
    public static const VOIDRESIST:int = 19;
    public static const LIGHTRESIST:int = 20;
    public static const BLASTRESIST:int = 21;
    public static const STRENGTH:int = 22;
    public static const PHYSICALDMG:int = 23;
    public static const MAGICALDMG:int = 24;
    public static const FIREDMG:int = 25;
    public static const WATERDMG:int = 26;
    public static const WINDDMG:int = 27;
    public static const ELECTRICDMG:int = 28;
    public static const EARTHDMG:int = 29;
    public static const ICEDMG:int = 30;
    public static const VOIDDMG:int = 31;
    public static const LIGHTDMG:int = 32;
    public static const BLASTDMG:int = 33;
    public static const ABILITYPWR:int = 34;
    public static const CRITICALCHANCE:int = 35;
    public static const CRITICALDAMAGE:int = 36;
    public static const ABILITYCRITCHANCE:int = 37;
    public static const ABILITYCRITDAMAGE:int = 38;
    public static const EVASION:int = 39;
    public static const LUCK:int = 40;
    public static const TENACITY:int = 41;
    public static const ABILITYCOOLDOWN:int = 42;
    public static const DOWNDURATION:int = 43;
    public static const POWER:int = 44;
    public static const DASHCOOLDOWN:int = 45;
    public static const DASHWINDOW:int = 46;


    private static const statsModel:Array = [new StatModel("ATT", "Attack", "This stat increases the amount of damage done.", true),
        new StatModel("ARM", "Armor", "This stat decreases the amount of damage taken.", false),
        new StatModel("SPD", "Speed", "This stat increases the speed at which the character moves.", true),
        new StatModel("DEX", "Dexterity", "This stat increases the speed at which the character attacks.", true),
        new StatModel("VIG", "Vigor", "This stat increases the speed at which hit points are recovered.", true),
        new StatModel("INT", "Intellect", "This stat increases the speed at which resource points are recovered.", true),
        // Overshield Related
        new StatModel("OSM", "OvershieldMax","Overshield Capacity"), // Overshield Capacity
        new StatModel("OSD", "OvershieldDelay","Delay before overshield recharges"), // Delay before overshield recharges
        new StatModel("OSRR", "OvershieldRechargeRate","How fast overshield recharges"), // How fast overshield recharges
        // Resistance Related
        new StatModel("RSL","Resilience", "Physical, Magical, and Elemental Resistance in one. (Only Increased with stat points)"), // Physical, Magical, and Elemental Resistance in one. (Only Increased with stat points)
        new StatModel("PHYR","PhysicalResist", "Physical Resistance"), // Physical Resistance
        new StatModel("MGCR","MagicResist", "Magic Resistance"), // Magic Resistance
        new StatModel("ELMR","ElementalResist", "Elemental Resistance"), // Elemental Resistance
        new StatModel("FRER","FireResist", "Fire Damage"), // Fire Damage
        new StatModel("WTRR","WaterResist", "Water Damage"), // Water Damage
        new StatModel("WNDR","WindResist", "Wind Damage"), // Wind Damage
        new StatModel("ELCR","ElectricResist", "Electric Damage"), // Electric Damage
        new StatModel("ERTR","EarthResist", "Earth Damage"), // Earth Damage
        new StatModel("ICER","IceResist", "Ice Damage"), // Ice Damage
        new StatModel("VDR","VoidResist", "Void Damage"), // Void Damage
        new StatModel("LGHR","LightResist", "Light Damage"), // Light Damage
        new StatModel("BLSR","BlastResist", "Blast Resistance"), // Blast Resistance

        // Damage related
        new StatModel("STR","Strength", "Physical, Magical, and Elemental Damage in one. (Only Increased with stat points)"), // Physical, Magical, and Elemental Damage in one. (Only Increased with stat points)
        new StatModel("PHYD","PhysicalDMG", "Physical Damage"), // Physical Damage
        new StatModel("MGCD","MagicalDMG", "Magical Damage"), // Magical Damage
        new StatModel("FRD","FireDMG", "Fire Damage"), // Fire Damage
        new StatModel("WTRD","WaterDMG", "Water Damage"), // Water Damage
        new StatModel("WNDD","WindDMG", "Wind Damage"), // Wind Damage
        new StatModel("ELCD","ElectricDMG", "Electric Damage"), // Electric Damage
        new StatModel("ERTD","EarthDMG", "Earth Damage"), // Earth Damage
        new StatModel("ICED","IceDMG", "Ice Damage"), // Ice Damage
        new StatModel("VDD","VoidDMG", "Void Damage"), // Void Damage
        new StatModel("LGHD","LightDMG", "Light Damage"), // Light Damage
        new StatModel("BLSD","BlastDMG", "Blast Damage"), // Blast Damage
        new StatModel("ABLP","AbilityPWR", "Ability Power"), // Ability Power
        new StatModel("CRCH","CriticalChance", "Crit Chance"), // Crit Chance
        new StatModel("CRIT","CriticalDamage", "Crit Damage"), // Crit Damage
        new StatModel("ABLC","AbilityCritChance", "Ability Crit Chance"), // Ability Crit Chance
        new StatModel("ABLCD","AbilityCritDamage", "Ability Crit Damage"), // Ability Crit Damage

        // Character Related
        new StatModel("EVA","Evasion", "Chance to dodge incoming damage"), // Chance to dodge incoming damage
        new StatModel("LCK","Luck", "Droprate(maybe only modifies higher tier droprate SC+)"), // Droprate(maybe only modifies higher tier droprate SC+)
        new StatModel("TEN","Tenacity", "Reduce effectiveness of debuffs"), // Reduce effectiveness of debuffs
        new StatModel("ABLCD","AbilityCooldown", "Ability Cooldown"), // Ability Cooldown
        new StatModel("DWND","DownDuration", "Characters go down and can be helped up, if they don't get help or are alone they die."), // Characters go down and can be helped up, if they don't get help or are alone they die.
        new StatModel("PWR","Power", "Characters Calculated Power based on stat maxed."), // Characters Calculated Power based on stat maxed.

        // Dash Related
        new StatModel("DCD","DashCooldown", "Roll Cooldown Reduction"), // Roll Cooldown Reduction
        new StatModel("DW","DashWindow", "Roll Invulnerability Window") // Roll Invulnerability Window
    ];


    public var w_:int;
    public var h_:int;
    public var stats_:Vector.<StatView>;
    public var containerSprite:Sprite;

    public function StatsView(w:int, h:int) {
        var i:int;
        var statModel:StatModel = null;
        var stat:StatView = null;
        this.stats_ = new Vector.<StatView>();
        this.containerSprite = new Sprite();
        super();
        this.w_ = w;
        this.h_ = h;
        for (i = 0; i < statsModel.length; i++) {
            statModel = statsModel[i];

            trace(StringUtil.substitute("    public static const {0}:int = {1};\n", statModel.abbreviation.toUpperCase(), i));
            stat = new StatView(statModel.name, statModel.abbreviation, statModel.description, statModel.redOnZero);
            stat.x = (i % 2) * (w_ + 4);
            stat.y = int(i / 2) * stat.height;
            this.containerSprite.addChild(stat);
            this.stats_.push(stat);
        }
        addChild(this.containerSprite);
    }

    public function draw(go:Player):void {
        if (go != null) {
            this.stats_[ATTACK].draw(go.attack_, go.attackBoost_, go.attackMax_);
            this.stats_[ARMOR].draw(go.armor_, go.armorBoost_, go.armorMax_);
            this.stats_[SPEED].draw(go.speed_, go.speedBoost_, go.speedMax_);
            this.stats_[DEXTERITY].draw(go.dexterity_, go.dexterityBoost_, go.dexterityMax_);
            this.stats_[VIGOR].draw(go.vigor_, go.vigorBoost_, go.vigorMax_);
            this.stats_[INTELLECT].draw(go.intellect, go.intelligenceBoost_, go.intelligenceMax_);
            //stats_[
            stats_[RESILIENCE].draw(go.Resilience, 0, 0);
            stats_[PHYSICALRESIST].draw(go.PhysicalResist, 0, 0);
            stats_[MAGICRESIST].draw(go.MagicResist, 0, 0);
            stats_[ELEMENTALRESIST].draw(go.ElementalResist, 0, 0);
            stats_[FIRERESIST].draw(go.FireResist, 0, 0);
            stats_[WATERRESIST].draw(go.WaterResist, 0, 0);
            stats_[WINDRESIST].draw(go.WindResist, 0, 0);
            stats_[ELECTRICRESIST].draw(go.ElectricResist, 0, 0);
            stats_[EARTHRESIST].draw(go.EarthResist, 0, 0);
            stats_[ICERESIST].draw(go.IceResist, 0, 0);
            stats_[VOIDRESIST].draw(go.VoidResist, 0, 0);
            stats_[LIGHTRESIST].draw(go.LightResist, 0, 0);
            stats_[BLASTRESIST].draw(go.BlastResist, 0, 0);

            stats_[STRENGTH].draw(go.Strength, 0, 0);
            stats_[PHYSICALDMG].draw(go.PhysicalDMG, 0, 0);
            stats_[MAGICALDMG].draw(go.MagicalDMG, 0, 0);
            stats_[FIREDMG].draw(go.FireDMG, 0, 0);
            stats_[WATERDMG].draw(go.WaterDMG, 0, 0);
            stats_[WINDDMG].draw(go.WindDMG, 0, 0);
            stats_[ELECTRICDMG].draw(go.ElectricDMG, 0, 0);
            stats_[EARTHDMG].draw(go.EarthDMG, 0, 0);
            stats_[ICEDMG].draw(go.IceDMG, 0, 0);
            stats_[VOIDDMG].draw(go.VoidDMG, 0, 0);
            stats_[LIGHTDMG].draw(go.LightDMG, 0, 0);
            stats_[BLASTDMG].draw(go.BlastDMG, 0, 0);
            stats_[ABILITYPWR].draw(go.AbilityPWR, 0, 0);
            stats_[CRITICALCHANCE].draw(go.CriticalChance, 0, 0);
            stats_[CRITICALDAMAGE].draw(go.CriticalDamage, 0, 0);
            stats_[ABILITYCRITCHANCE].draw(go.AbilityCritChance, 0, 0);
            stats_[ABILITYCRITDAMAGE].draw(go.AbilityCritDamage, 0, 0);

            stats_[EVASION].draw(go.Evasion,0,0);
            stats_[LUCK].draw(go.Luck,0,0);
            stats_[TENACITY].draw(go.Tenacity,0,0);
            stats_[ABILITYCOOLDOWN].draw(go.AbilityCooldown,0,0);
            stats_[DOWNDURATION].draw(go.DownDuration,0,0);
            stats_[POWER].draw(go.Power,0,0);

            stats_[DASHCOOLDOWN].draw(go.DashCooldown, 0, 0);
            stats_[DASHWINDOW].draw(go.DashWindow, 0, 0);
        }
        this.containerSprite.x = 30 + (191 - this.containerSprite.width) * 0.5;
    }
}
}
