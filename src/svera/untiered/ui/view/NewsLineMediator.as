package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.NewsLine;

import svera.lib.framework.Mediator;

import svera.untiered.honor.control.ShowHonorViewSignal;
import svera.untiered.honor.model.SimpleHonorVO;

public class NewsLineMediator extends Mediator {

    [Inject]
    public var showHonorView:ShowHonorViewSignal;

    private function getNewsLine():NewsLine {
        return view as NewsLine;
    }

    override public function initialize():void {
        this.getNewsLine.viewCharacterHonor.add(this.onViewHonor);
    }

    override public function destroy():void {
        this.getNewsLine.viewCharacterHonor.remove(this.onViewHonor);
    }

    private function onViewHonor(characterId:int):void {
        this.showHonorView.dispatch(new SimpleHonorVO(this.getNewsLine.accountId, characterId));
    }
}
}
