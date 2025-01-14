package svera.untiered.game.view.components
{
import com.company.assembleegameclient.objects.Player;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.ui.signals.UpdateHUDSignal;

public class StatsMediator extends Mediator
   {
       
      
      [Inject]
      public var view:StatsView;
      
      [Inject]
      public var updateHUD:UpdateHUDSignal;
      
      public function StatsMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.updateHUD.add(this.onUpdateHUD);
      }
      
      override public function destroy() : void
      {
         this.updateHUD.remove(this.onUpdateHUD);
      }
      
      private function onUpdateHUD(player:Player) : void
      {
         this.view.draw(player);
      }
   }
}
