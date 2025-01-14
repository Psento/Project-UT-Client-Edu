package svera.untiered.fame.control
{
import org.osflash.signals.Signal;

import svera.untiered.fame.model.FameVO;

public class ShowFameViewSignal extends Signal
   {
       
      
      public function ShowFameViewSignal()
      {
         super(FameVO);
      }
   }
}
