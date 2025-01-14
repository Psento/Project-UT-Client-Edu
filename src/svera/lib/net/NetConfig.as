package svera.lib.net
{
import flash.net.Socket;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

import svera.lib.net.api.MessageMap;
import svera.lib.net.api.MessageProvider;
import svera.lib.net.impl.MessageCenter;
import svera.lib.net.impl.SocketServer;

public class NetConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      private var messageCenter:MessageCenter;
      
      public function NetConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.messageCenter = new MessageCenter().setInjector(this.injector);
         this.injector.map(Socket);
         this.injector.map(MessageMap).toValue(this.messageCenter);
         this.injector.map(MessageProvider).toValue(this.messageCenter);
         this.injector.map(SocketServer).asSingleton();
      }
   }
}
