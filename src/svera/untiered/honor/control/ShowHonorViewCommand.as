package svera.untiered.honor.control {
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.honor.model.HonorModel;
import svera.untiered.honor.model.HonorVO;
import svera.untiered.honor.view.HonorView;

public class ShowHonorViewCommand {


    [Inject]
    public var vo:HonorVO;

    [Inject]
    public var model:HonorModel;

    [Inject]
    public var setScreen:SetScreenSignal;

    public function ShowHonorViewCommand() {
        super();
    }

    public function execute():void {
        this.model.accountId = this.vo.getAccountId();
        this.model.characterId = this.vo.getCharacterId();
        this.setScreen.dispatch(new HonorView());
    }
}
}
