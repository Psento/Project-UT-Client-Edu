package svera.untiered.game.view.components {
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;

import svera.untiered.game.model.StatModel;

public class StatsView extends Sprite {

    public static const ATTACK:int = 0;

    public static const ARMOR:int = 1;

    public static const SPEED:int = 2;

    public static const DEXTERITY:int = 3;

    public static const VIGOR:int = 4;

    public static const INTELLIGENCE:int = 5;

    public static const NUM_STAT:int = 6;

    private static const statsModel:Array = [new StatModel("ATT", "Attack", "This stat increases the amount of damage done.", true),
        new StatModel("ARM", "Armor", "This stat decreases the amount of damage taken.", false),
        new StatModel("SPD", "Speed", "This stat increases the speed at which the character moves.", true),
        new StatModel("DEX", "Dexterity", "This stat increases the speed at which the character attacks.", true),
        new StatModel("VIG", "Vigor", "This stat increases the speed at which hit points are recovered.", true),
        new StatModel("INT", "Intellect", "This stat increases the speed at which resource points are recovered.", true),
        // Overshield Related
        new StatModel("OSM", "OvershieldMax",""), // Overshield Capacity
        new StatModel("OSD", "OvershieldDelay",""), // Delay before overshield recharges
        new StatModel("OSRR", "OvershieldRechargeRate",""), // How fast overshield recharges
        // Resistance Related
        new StatModel("RSL","Resilience", ""), // Physical, Magical, and Elemental Resistance in one. (Only Increased with stat points)
        new StatModel("PHYR","PhysicalResist", ""), // Physical Resistance
        new StatModel("MGCR","MagicResist", ""), // Magic Resistance
        new StatModel("ELMR","ElementalResist", ""), // Elemental Resistance
        new StatModel("FRER","FireResist", ""), // Fire Damage
        new StatModel("WTRR","WaterResist", ""), // Water Damage
        new StatModel("WNDR","WindResist", ""), // Wind Damage
        new StatModel("ELCR","ElectricResist", ""), // Electric Damage
        new StatModel("ERTR","EarthResist", ""), // Earth Damage
        new StatModel("ICER","IceResist", ""), // Ice Damage
        new StatModel("VDR","VoidResist", ""), // Void Damage
        new StatModel("LGHR","LightResist", ""), // Light Damage
        new StatModel("BLSR","BlastResist", ""), // Blast Resistance

        // Damage related
        new StatModel("STR","Strength", ""), // Physical, Magical, and Elemental Damage in one. (Only Increased with stat points)
        new StatModel("PHYD","PhysicalDMG", ""), // Physical Damage
        new StatModel("MGCD","MagicalDMG", ""), // Magical Damage
        new StatModel("FRD","FireDMG", ""), // Fire Damage
        new StatModel("WTRD","WaterDMG", ""), // Water Damage
        new StatModel("WNDD","WindDMG", ""), // Wind Damage
        new StatModel("ELCD","ElectricDMG", ""), // Electric Damage
        new StatModel("ERTD","EarthDMG", ""), // Earth Damage
        new StatModel("ICED","IceDMG", ""), // Ice Damage
        new StatModel("VDD","VoidDMG", ""), // Void Damage
        new StatModel("LGHD","LightDMG", ""), // Light Damage
        new StatModel("BLSD","BlastDMG", ""), // Blast Damage
        new StatModel("ABLP","AbilityPWR", ""), // Ability Power
        new StatModel("CRCH","CriticalChance", ""), // Crit Chance
        new StatModel("CRIT","CriticalDamage", ""), // Crit Damage
        new StatModel("ABLC","AbilityCritChance", ""), // Ability Crit Chance
        new StatModel("ABLCD","AbilityCritDamage", ""), // Ability Crit Damage

        // Character Related
        new StatModel("EVA","Evasion", ""), // Chance to dodge incoming damage
        new StatModel("LCK","Luck", ""), // Droprate(maybe only modifies higher tier droprate SC+)
        new StatModel("TEN","Tenacity", ""), // Reduce effectiveness of debuffs
        new StatModel("ABLCD","AbilityCooldown", ""), // Ability Cooldown
        new StatModel("DWND","DownDuration", ""), // Characters go down and can be helped up, if they don't get help or are alone they die.
        new StatModel("PWR","Power", ""), // Characters Calculated Power based on stat maxed.

        // Dash Related
        new StatModel("DCD","DashCooldown", ""), // Roll Cooldown Reduction
        new StatModel("DW","DashWindow", "") // Roll Invulnerability Window
    ];


    public var w_:int;
    public var h_:int;
    public var stats_:Vector.<StatView>;
    public var containerSprite:Sprite;

    public function StatsView(w:int, h:int) {
        var i:int = 0;
        var statModel:StatModel = null;
        var stat:StatView = null;
        this.stats_ = new Vector.<StatView>();
        this.containerSprite = new Sprite();
        super();
        this.w_ = w;
        this.h_ = h;
        for (i = 0; i < statsModel.length; i++) {
            statModel = statsModel[i];
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
            this.stats_[INTELLIGENCE].draw(go.intelligence_, go.intelligenceBoost_, go.intelligenceMax_);
        }
        this.containerSprite.x = 30 + (191 - this.containerSprite.width) * 0.5;
    }
}
}
