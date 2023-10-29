package svera.untiered.classes.control
{
   import svera.untiered.classes.model.CharacterSkin;
   import org.osflash.signals.Signal;
   
   public class BuyCharacterSkinSignal extends Signal
   {
       
      
      public function BuyCharacterSkinSignal()
      {
         super(CharacterSkin);
      }
   }
}
