package svera.untiered.ui.signals
{
   import com.company.assembleegameclient.objects.Player;
   import org.osflash.signals.Signal;
   
   public class UpdateHUDSignal extends Signal
   {
       
      
      public function UpdateHUDSignal()
      {
         super(Player);
      }
   }
}
