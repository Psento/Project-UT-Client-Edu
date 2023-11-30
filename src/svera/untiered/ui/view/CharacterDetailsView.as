package svera.untiered.ui.view
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.IconButton;
import com.company.assembleegameclient.ui.options.KeyCodeBox;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.ui.SimpleText;
   import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;
import com.company.util.KeyCodes;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.GraphicsPath;
import flash.display.Shape;
import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeSignal;

import svera.untiered.ui.view.components.PotionSlotView;

public class CharacterDetailsView extends Sprite
   {
      
      public static const NEXUS_BUTTON:String = "NEXUS_BUTTON";

      private var potionsView:PotionSlotView;
      
      private var portrait_:Bitmap;
      
      private var button:IconButton;
      
      private var nameText_:SimpleText;
      private var recallText_:SimpleText;
      private var consumableOneText_:SimpleText;
      private var consumableTwoText_:SimpleText;

      private var portraitMask:Shape;
      private var content:Sprite;
      public function CharacterDetailsView() {

         this.content = new Sprite();
         this.portraitMask = new Shape();

         this.content.graphics.clear();
         this.content.graphics.beginFill(0,0);
         this.content.graphics.drawRect(0,0,72,64);
         this.content.graphics.endFill();
         this.portraitMask.graphics.clear();
         this.portraitMask.graphics.beginFill(0,0);
         this.portraitMask.graphics.drawRect(0,0,72,64);
         this.portraitMask.graphics.endFill();

         this.content.mask = this.portraitMask;
         this.content.addChild(this.portraitMask);

         addChild(this.content);
         this.nameText_ = new SimpleText(20,11776947,false,0,0);
         this.recallText_ = new SimpleText(20,11776947,false,0,0);
         this.consumableOneText_ = new SimpleText(10,11776947,false,0,0);
         this.consumableTwoText_ = new SimpleText(10,11776947,false,0,0);
         super();
      }
      
      public function init() : void
      {
         this.createHotkeysText();
      }

      private function createHotkeysText() : void
      {
         var keyCodeBox:KeyCodeBox = new KeyCodeBox(Parameters.data_["escapeToNexus"])
         this.recallText_.x = 82;
         this.recallText_.y = 5;
         this.recallText_.setBold(true);
         this.recallText_.filters = [new DropShadowFilter(0,0,0)];
         this.recallText_.text = KeyCodes.CharCodeStrings[keyCodeBox.keyCode_];
         this.recallText_.updateMetrics();
         addChild(this.recallText_);
         keyCodeBox = new KeyCodeBox(Parameters.data_["useHealthPotion"])
         this.consumableOneText_.x = this.recallText_.x - 4;
         this.consumableOneText_.y = this.recallText_.y + 27;
         this.consumableOneText_.setBold(true);
         this.consumableOneText_.filters = [new DropShadowFilter(0,0,0)];
         this.consumableOneText_.text = KeyCodes.CharCodeStrings[keyCodeBox.keyCode_];
         this.consumableOneText_.updateMetrics();
         addChild(this.consumableOneText_);
         keyCodeBox = new KeyCodeBox(Parameters.data_["useMagicPotion"])
         this.consumableTwoText_.x = this.recallText_.x + 10;
         this.consumableTwoText_.y = this.recallText_.y + 27;
         this.consumableTwoText_.setBold(true);
         this.consumableTwoText_.filters = [new DropShadowFilter(0,0,0)];
         this.consumableTwoText_.text = KeyCodes.CharCodeStrings[keyCodeBox.keyCode_];
         this.consumableTwoText_.updateMetrics();
         addChild(this.consumableTwoText_);
         potionsView = new PotionSlotView(0);
         potionsView.x = consumableOneText_.x;
         potionsView.y = consumableOneText_.y;
         addChild(potionsView);
         potionsView = new PotionSlotView(1);
         potionsView.x = consumableTwoText_.x;
         potionsView.y = consumableTwoText_.y;
         addChild(potionsView);
      }
      
      public function update(player:Player) : void
      {
      }

      public function draw(player:Player) : void
      {
         if(portrait_ == null)
         {
            var bmd:BitmapData = ObjectLibrary.getRedrawnTextureFromType(player.objectType_, 64 * 3,false)
            this.portrait_ = new Bitmap(bmd);
            this.portrait_.x = this.content.width/2 - this.portrait_.width/2+5;
            this.portrait_.y = (64 - this.portrait_.height) / 2 - 64/2;
            this.content.addChild(this.portrait_);
            this.content.x = 2;
            this.content.y = 4;
         }
      }
      
      public function setName(name:String) : void
      {
         this.nameText_.text = name;
      }
   }
}
