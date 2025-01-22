package svera.untiered.ui.view.components
{
import com.company.assembleegameclient.ui.SoundIcon;

import flash.display.Sprite;
import flash.events.Event;

import mx.core.BitmapAsset;

public class ScreenBase extends Sprite
   {
      private static var currBackground:BitmapAsset = new DefaultBackground();
      public function ScreenBase(newBackground:int = 0)
      {
         ChangeBackground(newBackground);
         addChild(new SoundIcon());
         GameClient.STAGE.addEventListener(Event.RESIZE, OnResize, false, 0, true);
         OnResize(null);
      }
      public function OnResize(e:Event):void{
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
