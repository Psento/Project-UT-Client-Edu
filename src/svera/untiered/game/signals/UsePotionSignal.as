package svera.untiered.game.signals
{
import org.osflash.signals.Signal;

import svera.untiered.game.model.UsePotionVO;

public class UsePotionSignal extends Signal
   {
       
      
      public function UsePotionSignal()
      {
         super(UsePotionVO);
      }
   }
}
