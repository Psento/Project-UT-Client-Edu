package svera.untiered.game.signals
{
   import svera.untiered.game.model.AddSpeechBalloonVO;
   import org.osflash.signals.Signal;
   
   public class AddSpeechBalloonSignal extends Signal
   {
       
      
      public function AddSpeechBalloonSignal()
      {
         super(AddSpeechBalloonVO);
      }
   }
}
