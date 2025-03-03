package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.account.web.view.WebAccountInfoView;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.HideTooltipsSignal;
import svera.untiered.core.signals.ShowTooltipSignal;

public class AccountScreenMediator extends Mediator {
    [Inject]
    public var view:AccountScreen;

    [Inject]
    public var account:Account;

    [Inject]
    public var playerModel:PlayerModel;

    [Inject]
    public var showTooltip:ShowTooltipSignal;

    [Inject]
    public var hideTooltips:HideTooltipsSignal;

    public function AccountScreenMediator() {
        super();
    }

    override public function initialize():void {
        this.view.tooltip.add(this.onTooltip);
        this.view.setRank(this.playerModel.getNumStars());
        this.view.setGuild(this.playerModel.getGuildName(), this.playerModel.getGuildRank());
        this.view.setAccountInfo(new WebAccountInfoView());
    }


    override public function destroy():void {
        this.view.tooltip.remove(this.onTooltip);
        this.hideTooltips.dispatch();
    }

    private function onTooltip(tooltip:ToolTip):void {
        this.showTooltip.dispatch(tooltip);
    }
}
}
