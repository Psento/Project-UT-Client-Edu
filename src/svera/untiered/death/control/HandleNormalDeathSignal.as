package svera.untiered.death.control
{
   import svera.untiered.messaging.impl.incoming.Death;
   import org.osflash.signals.Signal;
   
   public class HandleNormalDeathSignal extends Signal
   {
       
      
      public function HandleNormalDeathSignal()
      {
         super(Death);
      }
   }
}
