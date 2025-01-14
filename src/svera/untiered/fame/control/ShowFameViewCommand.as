package svera.untiered.fame.control
{
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.fame.model.FameModel;
import svera.untiered.fame.model.FameVO;
import svera.untiered.fame.view.FameView;

public class ShowFameViewCommand
   {
       
      
      [Inject]
      public var vo:FameVO;
      
      [Inject]
      public var model:FameModel;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      public function ShowFameViewCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         this.model.accountId = this.vo.getAccountId();
         this.model.characterId = this.vo.getCharacterId();
         this.setScreen.dispatch(new FameView());
      }
   }
}
