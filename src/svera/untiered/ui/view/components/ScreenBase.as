package svera.untiered.ui.view.components
{
import com.company.assembleegameclient.ui.SoundIcon;

import flash.display.Sprite;
import flash.events.Event;

import mx.core.BitmapAsset;

public class ScreenBase extends Sprite
   {
      private var currBackground:BitmapAsset = new DefaultBackground();
      public function ScreenBase(newBackground:int = 0)
      {
         ChangeBackground(newBackground);
         addChild(new SoundIcon());
         addEventListener(Event.RESIZE, OnResize, false, 0, true);
         OnResize(null);
      }
      private function OnResize(e:Event):void{
         currBackground.width = GameClient.StageWidth;
         currBackground.height = GameClient.StageHeight;
      }
      private function ChangeBackground(newBackground:int = 0):void
      {
         if(contains(currBackground))
            removeChild(currBackground);
         switch (newBackground) {
            case 0:
               currBackground = new DefaultBackground();
               break;
            case 1:
               currBackground = new HomescreenBackground();
               break;
            case 2:
               currBackground = new CharSelectionBackground();
               break;
         }
         addChild(currBackground);
      }
   }
}
