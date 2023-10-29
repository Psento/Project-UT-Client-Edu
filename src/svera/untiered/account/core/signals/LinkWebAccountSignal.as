package svera.untiered.account.core.signals
{
   import svera.untiered.account.web.model.AccountData;
   import org.osflash.signals.Signal;
   
   public class LinkWebAccountSignal extends Signal
   {
       
      
      public function LinkWebAccountSignal()
      {
         super(AccountData);
      }
   }
}
