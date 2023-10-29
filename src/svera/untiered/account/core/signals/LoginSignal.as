package svera.untiered.account.core.signals
{
   import svera.untiered.account.web.model.AccountData;
   import org.osflash.signals.Signal;
   
   public class LoginSignal extends Signal
   {
       
      
      public function LoginSignal()
      {
         super(AccountData);
      }
   }
}
