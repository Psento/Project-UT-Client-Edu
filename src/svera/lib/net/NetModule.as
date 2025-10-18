package svera.lib.net {
import flash.net.Socket;

import org.swiftsuspenders.Injector;

import svera.lib.framework.AppContext;

import svera.lib.framework.IModule;

import svera.lib.net.api.MessageMap;
import svera.lib.net.api.MessageProvider;
import svera.lib.net.impl.MessageCenter;
import svera.lib.net.impl.SocketServer;

public class NetModule implements IModule {

    private var messageCenter:MessageCenter;

    public function NetModule() {
        super();
    }

    public function configure(context:AppContext):void {
        this.messageCenter = new MessageCenter().setInjector(context.injector);
        context.injector.map(Socket);
        context.injector.map(MessageMap).toValue(this.messageCenter);
        context.injector.map(MessageProvider).toValue(this.messageCenter);
        context.injector.map(SocketServer).asSingleton();
    }
}
}
