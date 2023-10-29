package svera.untiered.legends.control
{
   import svera.untiered.legends.model.Timespan;
   import org.osflash.signals.Signal;
   
   public class RequestFameListSignal extends Signal
   {
       
      
      public function RequestFameListSignal()
      {
         super(Timespan);
      }
   }
}
