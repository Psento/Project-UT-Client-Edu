package svera.untiered.minimap.control
{
   import svera.untiered.ui.model.UpdateGameObjectTileVO;
   import org.osflash.signals.Signal;
   
   public class UpdateGameObjectTileSignal extends Signal
   {
       
      
      public function UpdateGameObjectTileSignal()
      {
         super(UpdateGameObjectTileVO);
      }
   }
}
