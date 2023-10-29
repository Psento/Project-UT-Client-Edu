package svera.untiered.characters.reskin.control
{
   import svera.untiered.classes.model.CharacterSkin;
   import org.osflash.signals.Signal;
   
   public class ReskinCharacterSignal extends Signal
   {
       
      
      public function ReskinCharacterSignal()
      {
         super(CharacterSkin);
      }
   }
}
