package svera.untiered.legends.view {
import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.death.model.DeathModel;
import svera.untiered.fame.control.ShowFameViewSignal;
import svera.untiered.legends.control.ExitLegendsSignal;
import svera.untiered.legends.control.FameListUpdateSignal;
import svera.untiered.legends.control.RequestFameListSignal;
import svera.untiered.legends.model.Legend;
import svera.untiered.legends.model.LegendsModel;
import svera.untiered.legends.model.Timespan;

public class LegendsMediator extends Mediator {


    [Inject]
    public var view:LegendsView;

    [Inject]
    public var model:LegendsModel;

    [Inject]
    public var deathModel:DeathModel;

    [Inject]
    public var showFameDetail:ShowFameViewSignal;

    [Inject]
    public var requestFameList:RequestFameListSignal;

    [Inject]
    public var update:FameListUpdateSignal;

    [Inject]
    public var exit:ExitLegendsSignal;

    public function LegendsMediator() {
        super();
    }

    override public function initialize():void {
        this.view.close.add(this.onClose);
        this.view.timespanChanged.add(this.onTimespanChanged);
        this.view.showDetail.add(this.onShowCharacter);
        this.update.add(this.updateLegendList);
        this.onTimespanChanged(this.model.getTimespan());
    }

    private function onClose():void {
        this.exit.dispatch();
    }

    override public function destroy():void {
        this.view.close.remove(this.onClose);
        this.view.timespanChanged.remove(this.onTimespanChanged);
        this.view.showDetail.remove(this.onShowCharacter);
        this.update.remove(this.updateLegendList);
        this.deathModel.clearPendingDeathView();
        this.model.clear();
    }

    private function onTimespanChanged(timespan:Timespan):void {
        this.model.setTimespan(timespan);
        if (this.model.hasLegendList()) {
            this.updateLegendList();
        } else {
            this.showLoadingAndRequestFameList();
        }
    }

    private function showLoadingAndRequestFameList():void {
        this.view.clear();
        this.view.showLoading();
        this.requestFameList.dispatch(this.model.getTimespan());
    }

    private function updateLegendList(timespan:Timespan = null):void {
        timespan = timespan || this.model.getTimespan();
        this.view.hideLoading();
        this.view.setLegendsList(timespan, this.model.getLegendList());
    }

    private function onShowCharacter(legend:Legend):void {
        this.showFameDetail.dispatch(legend);
    }
}
}
