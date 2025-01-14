package svera.untiered.game.signals
{
import svera.lib.signals.DeferredQueueSignal;
import svera.untiered.game.model.AddTextLineVO;

public class AddTextLineSignal extends DeferredQueueSignal
   {
       
      
      public function AddTextLineSignal()
      {
         super(AddTextLineVO);
      }
   }
}
