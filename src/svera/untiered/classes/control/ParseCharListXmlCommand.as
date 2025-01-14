package svera.untiered.classes.control
{
import robotlegs.bender.framework.api.ILogger;

import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.classes.model.ClassesModel;

public class ParseCharListXmlCommand
   {
      [Inject]
      public var data:XML;
      
      [Inject]
      public var model:ClassesModel;
      
      [Inject]
      public var logger:ILogger;
      
      public function ParseCharListXmlCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.parseOwnership();
      }

      private function parseOwnership() : void
      {
         var owned:int = 0;
         var skin:CharacterSkin = null;
         var ownership:Array = Boolean(this.data.OwnedSkins.length())?this.data.OwnedSkins.split(","):[];
         for each(owned in ownership)
         {
            skin = this.model.getCharacterSkin(owned);
            if(skin)
            {
               skin.setState(CharacterSkinState.OWNED);
            }
            else
            {
               this.logger.warn("Cannot set Character Skin ownership: type {0} not found",[owned]);
            }
         }
      }
   }
}
