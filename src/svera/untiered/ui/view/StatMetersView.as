package svera.untiered.ui.view
{
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.StatusBar;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class StatMetersView extends Sprite
   {
       
      
      private var expBar_:StatusBar;
      
      private var fameBar_:StatusBar;
      
      private var hpBar_:StatusBar;

      private var spBar_:StatusBar;
      
      private var rpBar_:StatusBar;
      
      public function StatMetersView()
      {
         super();
         this.expBar_ = new StatusBar(176,16,5931045,5526612,"Lvl X");
         this.fameBar_ = new StatusBar(176,16,14835456,5526612,"Fame");
         this.hpBar_ = new StatusBar(176,16,14693428,5526612,"HP");
         this.spBar_ = new StatusBar(176,16,16777215,14693428,"SP");
         this.rpBar_ = new StatusBar(176,16,6325472,5526612,"RP");
         this.hpBar_.y = 24;
         this.spBar_.y = 24;
         this.rpBar_.y = 48;
         this.spBar_.visible = false;
         this.expBar_.visible = true;
         this.fameBar_.visible = false;
         addChild(this.expBar_);
         addChild(this.fameBar_);
         addChild(this.hpBar_);
         addChild(this.spBar_);
         addChild(this.rpBar_);
      }
      
      public function update(player:Player) : void
      {
         var lvlText:String = "Lvl " + player.level_;
         if(lvlText != this.expBar_.labelText_.text)
         {
            this.expBar_.labelText_.text = lvlText;
            this.expBar_.labelText_.updateMetrics();
         }
         if(player.level_ != 100)
         {
            if(!this.expBar_.visible)
            {
               this.expBar_.visible = true;
               this.fameBar_.visible = false;
            }
            this.expBar_.draw(player.exp_,player.nextLevelExp_,0);
         }
         else
         {
            if(!this.fameBar_.visible)
            {
               this.fameBar_.visible = true;
               this.expBar_.visible = false;
            }
            this.fameBar_.draw(player.charFame_,player.nextClassQuestFame_,0);
         }
         this.spBar_.valueText_.textColor = 16777215;
         this.spBar_.boostText_.textColor = 16777215;
         this.spBar_.visible = player.sp_ > 0;
         this.hpBar_.labelText_.visible = !(player.sp_ > 0);
         this.hpBar_.valueText_.visible = !(player.sp_ > 0);
         this.hpBar_.boostText_.visible = !(player.sp_ > 0);

         this.spBar_.draw(player.sp_,player.maxSP_,player.maxSPBoost_,player.maxSPMax_);
         this.hpBar_.draw(player.hp_,player.maxHP_,player.maxHPBoost_,player.maxHPMax_);
         this.rpBar_.draw(player.rp_,player.maxRP_,player.maxRPBoost_,player.maxRPMax_);
      }
   }
}
