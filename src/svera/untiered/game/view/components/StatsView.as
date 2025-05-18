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

    private static const statsModel:Array = [new StatModel("ATT", "Attack", "This stat increases the amount of damage done.", true), new StatModel("ARM", "Armor", "This stat decreases the amount of damage taken.", false), new StatModel("SPD", "Speed", "This stat increases the speed at which the character moves.", true), new StatModel("DEX", "Dexterity", "This stat increases the speed at which the character attacks.", true), new StatModel("VIG", "Vigor", "This stat increases the speed at which hit points are recovered.", true), new StatModel("INT", "Intelligence", "This stat increases the speed at which resource points are recovered.", true)];


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
            stat.x = 0;
            stat.y = i * stat.height;
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
