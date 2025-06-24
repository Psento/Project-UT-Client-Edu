package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.NewsLine;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.honor.control.ShowHonorViewSignal;
import svera.untiered.honor.model.SimpleHonorVO;

public class NewsLineMediator extends Mediator {


    [Inject]
    public var view:NewsLine;

    [Inject]
    public var showHonorView:ShowHonorViewSignal;

    public function NewsLineMediator() {
        super();
    }

    override public function initialize():void {
        this.view.viewCharacterHonor.add(this.onViewHonor);
    }

    override public function destroy():void {
        this.view.viewCharacterHonor.remove(this.onViewHonor);
    }

    private function onViewHonor(characterId:int):void {
        this.showHonorView.dispatch(new SimpleHonorVO(this.view.accountId, characterId));
    }
}
}
