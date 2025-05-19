package svera.untiered.ui.view {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.StatusBar;

import flash.display.Shape;
import flash.display.Sprite;

public class StatMetersView extends Sprite {

    private var expBar_:StatusBar;

    private var fameBar_:StatusBar;

    private var hpBar_:StatusBar;

    private var spBar_:StatusBar;

    private var rpBar_:StatusBar;

    private var levelMask:Shape;
    private var content:Sprite;

    public function StatMetersView() {
        this.levelMask = new Shape();
        this.content = new Sprite();
        this.content.graphics.clear();
        this.content.graphics.beginFill(0, 0);
        this.content.graphics.drawRect(0, 0, 22, 22);
        this.content.graphics.endFill();
        this.levelMask.graphics.clear();
        this.levelMask.graphics.beginFill(0, 0);
        this.levelMask.graphics.drawRect(0, 0, 22, 22);
        this.levelMask.graphics.endFill();

        this.content.mask = this.levelMask;
        this.content.addChild(this.levelMask);

        super();
        this.expBar_ = new StatusBar(72, 20, 5931045, 5526612, "Lvl X");
        this.fameBar_ = new StatusBar(72, 20, 14835456, 5526612, "Fame");
        this.hpBar_ = new StatusBar(245, 20, 14693428, 5526612, "HP");
        this.spBar_ = new StatusBar(245, 20, 16777215, 14693428, "SP");
        this.rpBar_ = new StatusBar(245, 20, 6325472, 5526612, "RP");
        this.hpBar_.x = 0;
        this.hpBar_.y = 0;
        this.spBar_.x = this.hpBar_.x;
        this.spBar_.y = this.hpBar_.y;
        this.rpBar_.x = this.spBar_.x;
        this.rpBar_.y = 21;
        this.expBar_.x = -72 - 1.5; // Idk some magic 2, without it its missaligned
        this.expBar_.y = this.rpBar_.y;
        this.spBar_.visible = false;
        this.expBar_.visible = true;
        this.fameBar_.visible = false;
        addChild(this.expBar_);
        addChild(this.fameBar_);
        addChild(this.hpBar_);
        addChild(this.spBar_);
        addChild(this.rpBar_);
        addChild(this.content);
    }

    public function update(player:Player):void {
        var lvlText:String = player.level_.toString();
        if (lvlText != this.expBar_.labelText_.text) {
            this.expBar_.labelText_.text = lvlText;
            this.expBar_.labelText_.updateMetrics();
            this.expBar_.labelText_.x = this.content.width / 2 - this.expBar_.labelText_.width / 2;
            this.expBar_.labelText_.y = this.content.height / 2 - this.expBar_.labelText_.height / 2;
            content.addChild(this.expBar_.labelText_);
        }
        if (player.level_ != 100) {
            if (!this.expBar_.visible) {
                this.expBar_.visible = true;
                this.fameBar_.visible = false;
            }
            this.content.y = this.expBar_.y - 3;
            this.content.x = this.expBar_.x - 24;
            this.expBar_.valueText_.setSize(10);
            this.expBar_.valueText_.y = this.expBar_.height / 2 - this.expBar_.valueText_.height / 2;
            this.expBar_.boostText_.setSize(10);
            this.expBar_.boostText_.y = this.expBar_.valueText_.y;
            this.expBar_.draw(player.exp_, player.nextLevelExp_, 0);
        } else {
            if (!this.fameBar_.visible) {
                this.fameBar_.visible = true;
                this.expBar_.visible = false;
            }
            this.fameBar_.draw(player.charFame_, player.nextClassQuestFame_, 0);
        }
        this.spBar_.valueText_.textColor = 16777215;
        this.spBar_.boostText_.textColor = 16777215;
        this.spBar_.visible = player.sp_ > 0;
        this.spBar_.labelText_.y = this.spBar_.height / 2 - this.spBar_.labelText_.height / 2;
        this.spBar_.valueText_.y = this.spBar_.height / 2 - this.spBar_.valueText_.height / 2;
        this.spBar_.boostText_.y = this.spBar_.height / 2 - this.spBar_.valueText_.height / 2;

        this.hpBar_.labelText_.visible = !(player.sp_ > 0);
        this.hpBar_.valueText_.visible = !(player.sp_ > 0);
        this.hpBar_.boostText_.visible = !(player.sp_ > 0);
        this.hpBar_.labelText_.y = this.hpBar_.height / 2 - this.hpBar_.labelText_.height / 2;
        this.hpBar_.valueText_.y = this.hpBar_.height / 2 - this.hpBar_.valueText_.height / 2;
        this.hpBar_.boostText_.y = this.hpBar_.height / 2 - this.hpBar_.boostText_.height / 2;

        this.rpBar_.labelText_.y = this.rpBar_.height / 2 - this.rpBar_.labelText_.height / 2;
        this.rpBar_.valueText_.y = this.rpBar_.height / 2 - this.rpBar_.valueText_.height / 2;
        this.rpBar_.boostText_.y = this.rpBar_.height / 2 - this.rpBar_.boostText_.height / 2;

        this.spBar_.draw(player.sp_, player.maxSP_, player.maxSPBoost_, player.maxSPMax_);
        this.hpBar_.draw(player.hp_, player.maxHP_, player.maxHPBoost_, player.maxHPMax_);
        this.rpBar_.draw(player.rp_, player.maxRP_, player.maxRPBoost_, player.maxRPMax_);
    }
}
}
