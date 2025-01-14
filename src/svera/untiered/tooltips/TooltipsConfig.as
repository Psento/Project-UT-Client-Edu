package svera.untiered.tooltips
{
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

import svera.untiered.tooltips.view.TooltipsMediator;
import svera.untiered.tooltips.view.TooltipsView;

public class TooltipsConfig implements IConfig
   {
       
      
      [Inject]
      public var context:IContext;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      public function TooltipsConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.mediatorMap.map(TooltipsView).toMediator(TooltipsMediator);
      }
   }
}
