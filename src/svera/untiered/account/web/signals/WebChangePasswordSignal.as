package svera.untiered.account.web.signals
{
   import svera.untiered.account.web.model.ChangePasswordData;
   import org.osflash.signals.Signal;
   
   public class WebChangePasswordSignal extends Signal
   {
       
      
      public function WebChangePasswordSignal()
      {
         super(ChangePasswordData);
      }
   }
}
