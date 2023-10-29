package svera.untiered.game.signals
{
   import svera.untiered.game.model.GameInitData;
   import org.osflash.signals.Signal;
   
   public class PlayGameSignal extends Signal
   {
       
      
      public function PlayGameSignal()
      {
         super(GameInitData);
      }
   }
}
