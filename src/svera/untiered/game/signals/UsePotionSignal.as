package svera.untiered.game.signals
{
   import svera.untiered.game.model.UsePotionVO;
   import org.osflash.signals.Signal;
   
   public class UsePotionSignal extends Signal
   {
       
      
      public function UsePotionSignal()
      {
         super(UsePotionVO);
      }
   }
}
