package svera.untiered.assets
{
   import svera.untiered.assets.services.CharacterFactory;
   import svera.untiered.assets.services.IconFactory;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.framework.api.IConfig;
   
   public class AssetsConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      public function AssetsConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.injector.map(CharacterFactory).asSingleton();
         this.injector.map(IconFactory).asSingleton();
      }
   }
}
