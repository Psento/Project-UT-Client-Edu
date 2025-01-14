package svera.untiered.characters.reskin
{
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

import svera.lib.net.api.MessageMap;
import svera.untiered.characters.reskin.control.OpenReskinDialogCommand;
import svera.untiered.characters.reskin.control.OpenReskinDialogSignal;
import svera.untiered.characters.reskin.control.ReskinCharacterCommand;
import svera.untiered.characters.reskin.control.ReskinCharacterSignal;
import svera.untiered.characters.reskin.control.ReskinHandler;
import svera.untiered.characters.reskin.view.ReskinCharacterMediator;
import svera.untiered.characters.reskin.view.ReskinCharacterView;
import svera.untiered.characters.reskin.view.ReskinPanel;
import svera.untiered.characters.reskin.view.ReskinPanelMediator;
import svera.untiered.messaging.impl.GameServerConnection;
import svera.untiered.messaging.impl.outgoing.Reskin;

public class ReskinConfig implements IConfig
   {
       
      
      [Inject]
      public var context:IContext;
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      [Inject]
      public var messageMap:MessageMap;
      
      public function ReskinConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.mediatorMap.map(ReskinCharacterView).toMediator(ReskinCharacterMediator);
         this.mediatorMap.map(ReskinPanel).toMediator(ReskinPanelMediator);
         this.commandMap.map(OpenReskinDialogSignal).toCommand(OpenReskinDialogCommand);
         this.commandMap.map(ReskinCharacterSignal).toCommand(ReskinCharacterCommand);
         this.messageMap.map(GameServerConnection.RESKIN).toMessage(Reskin).toHandler(ReskinHandler);
      }
   }
}
