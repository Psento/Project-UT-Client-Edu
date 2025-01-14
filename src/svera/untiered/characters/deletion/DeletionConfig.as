package svera.untiered.characters.deletion
{
import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

import svera.untiered.characters.deletion.control.DeleteCharacterCommand;
import svera.untiered.characters.deletion.control.DeleteCharacterSignal;
import svera.untiered.characters.deletion.service.DeleteCharacterTask;
import svera.untiered.characters.deletion.view.ConfirmDeleteCharacterDialog;
import svera.untiered.characters.deletion.view.ConfirmDeleteCharacterMediator;

public class DeletionConfig implements IConfig
   {
       
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      public function DeletionConfig()
      {
         super();
      }
      
      public function configure() : void
      {
         this.injector.map(DeleteCharacterTask);
         this.mediatorMap.map(ConfirmDeleteCharacterDialog).toMediator(ConfirmDeleteCharacterMediator);
         this.commandMap.map(DeleteCharacterSignal).toCommand(DeleteCharacterCommand);
      }
   }
}
