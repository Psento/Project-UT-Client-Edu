package svera.untiered.game.view
{
   import svera.untiered.core.model.PlayerModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class CurrencyDisplayMediator extends Mediator
   {
       
      
      [Inject]
      public var view:CurrencyDisplay;
      
      [Inject]
      public var model:PlayerModel;
      
      public function CurrencyDisplayMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.model.tsavoriteChanged.add(this.onTsavoriteChanged);
         this.model.medallionsChanged.add(this.onMedallionsChanged);
         this.model.honorChanged.add(this.onHonorChanged);
         this.model.fameChanged.add(this.onFameChanged);
         this.view.draw(this.model.getTsavorite(),this.model.getMedallions(),this.model.getHonor(),this.model.getFame());
      }
      
      override public function destroy() : void
      {
         this.model.tsavoriteChanged.remove(this.onTsavoriteChanged);
         this.model.medallionsChanged.remove(this.onMedallionsChanged);
         this.model.honorChanged.remove(this.onHonorChanged);
         this.model.fameChanged.remove(this.onFameChanged);
      }
      
      private function onTsavoriteChanged(tsavorite:int) : void
      {
         this.view.draw(tsavorite,this.model.getMedallions(),this.model.getHonor(),this.model.getFame());
      }

      private function onMedallionsChanged(medallions:int) : void
      {
         this.view.draw(this.model.getTsavorite(),medallions,this.model.getHonor(),this.model.getFame());
      }

      private function onHonorChanged(honor:int) : void
      {
         this.view.draw(this.model.getTsavorite(),this.model.getMedallions(),honor,this.model.getFame());
      }
      
      private function onFameChanged(fame:int) : void
      {
         this.view.draw(this.model.getTsavorite(),this.model.getMedallions(),this.model.getHonor(),fame);
      }
   }
}
