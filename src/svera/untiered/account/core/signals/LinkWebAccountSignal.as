package svera.untiered.account.core.signals
{
import org.osflash.signals.Signal;

import svera.untiered.account.web.model.AccountData;

public class LinkWebAccountSignal extends Signal
   {
       
      
      public function LinkWebAccountSignal()
      {
         super(AccountData);
      }
   }
}
