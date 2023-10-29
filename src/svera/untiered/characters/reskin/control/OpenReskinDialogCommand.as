package svera.untiered.characters.reskin.control
{
   import flash.display.DisplayObject;
   import svera.untiered.characters.reskin.view.ReskinCharacterView;
   import svera.untiered.classes.model.CharacterSkins;
   import svera.untiered.classes.model.ClassesModel;
   import svera.untiered.classes.view.CharacterSkinListItemFactory;
   import svera.untiered.core.model.PlayerModel;
   import svera.untiered.dialogs.control.OpenDialogSignal;
   
   public class OpenReskinDialogCommand
   {
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var player:PlayerModel;
      
      [Inject]
      public var model:ClassesModel;
      
      [Inject]
      public var factory:CharacterSkinListItemFactory;
      
      public function OpenReskinDialogCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.openDialog.dispatch(this.makeView());
      }
      
      private function makeView() : ReskinCharacterView
      {
         var view:ReskinCharacterView = new ReskinCharacterView();
         view.setList(this.makeList());
         view.x = (800 - view.width) * 0.5;
         view.y = (600 - view.viewHeight) * 0.5;
         return view;
      }
      
      private function makeList() : Vector.<DisplayObject>
      {
         var skins:CharacterSkins = this.getCharacterSkins();
         return this.factory.make(skins);
      }
      
      private function getCharacterSkins() : CharacterSkins
      {
         return this.model.getSelected().skins;
      }
   }
}
