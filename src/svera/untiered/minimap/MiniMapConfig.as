package svera.untiered.minimap
{
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

import svera.untiered.minimap.control.MiniMapZoomSignal;
import svera.untiered.minimap.control.SetMiniMapMapSignal;
import svera.untiered.minimap.control.UpdateGameObjectTileSignal;
import svera.untiered.minimap.control.UpdateGroundTileSignal;
import svera.untiered.minimap.view.MiniMap;
import svera.untiered.minimap.view.MiniMapMediator;

public class MiniMapConfig implements IConfig
   {
       
      
      [Inject]
      public var context:IContext;
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      public function MiniMapConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.injector.map(MiniMapZoomSignal).asSingleton();
         this.injector.map(SetMiniMapMapSignal).asSingleton();
         this.injector.map(UpdateGameObjectTileSignal).asSingleton();
         this.injector.map(UpdateGroundTileSignal).asSingleton();
         this.mediatorMap.map(MiniMap).toMediator(MiniMapMediator);
      }
   }
}
