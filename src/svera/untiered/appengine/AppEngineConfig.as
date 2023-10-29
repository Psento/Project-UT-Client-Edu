package svera.untiered.appengine
{
   import svera.untiered.appengine.api.AppEngineClient;
   import svera.untiered.appengine.api.RetryLoader;
   import svera.untiered.appengine.impl.AppEngineRetryLoader;
   import svera.untiered.appengine.impl.SimpleAppEngineClient;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.framework.api.IConfig;
   import robotlegs.bender.framework.api.IContext;
   
   public class AppEngineConfig implements IConfig
   {
      [Inject]
      public var context:IContext;
      
      [Inject]
      public var injector:Injector;
      
      public function AppEngineConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.configureCoreDependencies();
         this.configureForSimplicity();
      }
      
      private function configureCoreDependencies() : void
      {
         this.injector.map(RetryLoader).toType(AppEngineRetryLoader);
      }

      private function configureForSimplicity() : void
      {
         this.injector.map(AppEngineClient).toType(SimpleAppEngineClient);
      }
   }
}
