package svera.untiered.game.model
{
   public class GameInitData
   {
      public var gameId:int;
      public var createCharacter:Boolean;
      public var charId:int;
      public var isNewGame:Boolean;
      public var traits:Array = [ -1, -1, -1 ];
      
      public function GameInitData()
      {
         super();
      }
   }
}
