package svera.untiered.ui.view {
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import svera.lib.framework.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.account.web.view.WebAccountInfoView;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.HideTooltipsSignal;
import svera.untiered.core.signals.ShowTooltipSignal;

public class AccountScreenMediator extends Mediator {

    [Inject]
    public var account:Account;

    [Inject]
    public var playerModel:PlayerModel;

    [Inject]
    public var showTooltip:ShowTooltipSignal;

    [Inject]
    public var hideTooltips:HideTooltipsSignal;

    private function getAccountScreen():AccountScreen {
        return view as AccountScreen;
    }

    override public function initialize():void {
        this.getAccountScreen.tooltip.add(this.onTooltip);
        this.getAccountScreen.setRank(this.playerModel.getNumStars());
        this.getAccountScreen.setGuild(this.playerModel.getGuildName(), this.playerModel.getGuildRank());
        this.getAccountScreen.setAccountInfo(new WebAccountInfoView());
    }


    override public function destroy():void {
        this.getAccountScreen.tooltip.remove(this.onTooltip);
        this.hideTooltips.dispatch();
    }

    private function onTooltip(tooltip:ToolTip):void {
        this.showTooltip.dispatch(tooltip);
    }
}
}
