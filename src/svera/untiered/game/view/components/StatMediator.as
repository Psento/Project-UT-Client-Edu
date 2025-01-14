package svera.untiered.game.view.components
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class StatMediator extends Mediator
   {
       
      
      [Inject]
      public var view:StatView;
      
      public function StatMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
      }
      
      override public function destroy() : void
      {
      }
   }
}
