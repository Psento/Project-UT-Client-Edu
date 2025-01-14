package svera.untiered.death.control
{
import org.osflash.signals.Signal;

import svera.untiered.messaging.impl.incoming.Death;

public class HandleDeathSignal extends Signal
   {
       
      
      public function HandleDeathSignal()
      {
         super(Death);
      }
   }
}
