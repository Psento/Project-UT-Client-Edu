package svera.untiered.account.core.signals
{
import org.osflash.signals.Signal;

import svera.untiered.account.web.model.AccountData;

public class LoginSignal extends Signal
   {
       
      
      public function LoginSignal()
      {
         super(AccountData);
      }
   }
}
