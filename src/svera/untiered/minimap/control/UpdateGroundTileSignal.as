package svera.untiered.minimap.control
{
   import svera.untiered.minimap.model.UpdateGroundTileVO;
   import org.osflash.signals.Signal;
   
   public class UpdateGroundTileSignal extends Signal
   {
       
      
      public function UpdateGroundTileSignal()
      {
         super(UpdateGroundTileVO);
      }
   }
}
