package svera.untiered.ui.view.components
{
   import com.company.assembleegameclient.ui.SoundIcon;
   import flash.display.Sprite;

public class ScreenBase extends Sprite
   {
      private var currBackground = new DefaultBackground();
      public function ScreenBase(newBackground:int = 0)
      {
         ChangeBackground(newBackground);
         addChild(new SoundIcon());
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
