package svera.lib.framework {

/**
 * Module interface - replaces Robotlegs IConfig
 */
public interface IModule {
    function configure(context:AppContext):void;
}
}