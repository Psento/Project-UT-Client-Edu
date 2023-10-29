package svera.untiered.ui.commands
{
   import com.company.assembleegameclient.editor.Command;
   import com.company.assembleegameclient.game.GameSprite;
   import svera.untiered.ui.model.HUDModel;
   import svera.untiered.ui.signals.HUDModelInitialized;
   
   public class HUDInitCommand extends Command
   {
       
      
      [Inject]
      public var gameSprite:GameSprite;
      
      [Inject]
      public var model:HUDModel;
      
      [Inject]
      public var hudModelInitialized:HUDModelInitialized;
      
      public function HUDInitCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         this.model.gameSprite = this.gameSprite;
         this.hudModelInitialized.dispatch();
      }
   }
}
