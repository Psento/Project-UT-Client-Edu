package svera.untiered.death.control
{
   import svera.untiered.messaging.impl.incoming.Death;
   import org.osflash.signals.Signal;
   
   public class HandleDeathSignal extends Signal
   {
       
      
      public function HandleDeathSignal()
      {
         super(Death);
      }
   }
}
