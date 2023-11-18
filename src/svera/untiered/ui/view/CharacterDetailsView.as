package svera.untiered.ui.view
{
   import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.IconButton;
import com.company.assembleegameclient.ui.options.KeyCodeBox;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.ui.SimpleText;
   import com.company.util.AssetLibrary;
import com.company.util.KeyCodes;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeSignal;
   
   public class CharacterDetailsView extends Sprite
   {
      
      public static const NEXUS_BUTTON:String = "NEXUS_BUTTON";
       
      
      private var portrait_:Bitmap;
      
      private var button:IconButton;
      
      private var nameText_:SimpleText;
      private var recallText_:SimpleText;
      private var consumableOneText_:SimpleText;
      private var consumableTwoText_:SimpleText;
      
      public function CharacterDetailsView()
      {
         this.portrait_ = new Bitmap(null);
         this.nameText_ = new SimpleText(20,11776947,false,0,0);
         this.recallText_ = new SimpleText(20,11776947,false,0,0);
         this.consumableOneText_ = new SimpleText(10,11776947,false,0,0);
         this.consumableTwoText_ = new SimpleText(10,11776947,false,0,0);
         super();
      }
      
      public function init(playerName:String, buttonType:String) : void
      {
         this.createPortrait();
         this.createHotkeysText();
      }
      
      private function createPortrait() : void
      {
         this.portrait_.x = -5;
         this.portrait_.y = -9;
         addChild(this.portrait_);
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
      }
      
      public function update(player:Player) : void
      {
         this.portrait_.bitmapData = player.getPortraitHUD();
      }

      public function draw(player:Player) : void
      {
      }
      
      public function setName(name:String) : void
      {
         this.nameText_.text = name;
      }
   }
}
