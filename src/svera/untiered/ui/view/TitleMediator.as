package svera.untiered.ui.view {
import com.company.assembleegameclient.mapeditor.MapEditor;

import svera.lib.framework.Mediator;

import svera.untiered.account.core.Account;
import svera.untiered.account.core.signals.OpenAccountInfoSignal;
import svera.untiered.account.core.signals.OpenQuitDialogSignal;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.core.signals.SetScreenWithValidDataSignal;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.legends.view.LegendsView;
import svera.untiered.ui.signals.EnterGameSignal;

public class TitleMediator extends Mediator {

    [Inject]
    public var account:Account;

    [Inject]
    public var playerModel:PlayerModel;

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;

    [Inject]
    public var enterGame:EnterGameSignal;

    [Inject]
    public var openAccountInfo:OpenAccountInfoSignal;

    [Inject]
    public var openQuitDialog:OpenQuitDialogSignal;

    [Inject]
    public var openDialog:OpenDialogSignal;

    private function get getTitleView():TitleView {
        return view as TitleView;
    }

    override public function initialize():void {
        this.getTitleView.initialize();
        this.getTitleView.playClicked.add(this.handleIntentionToPlay);
        this.getTitleView.legendsClicked.add(this.showLegendsScreen);
        this.getTitleView.editorClicked.add(this.showMapEditor);
        this.getTitleView.accountClicked.add(this.handleIntentionToReviewAccount);
        this.getTitleView.quitClicked.add(this.handleIntentionToQuitGame);
    }

    override public function destroy():void {
        this.getTitleView.playClicked.remove(this.handleIntentionToPlay);
        this.getTitleView.legendsClicked.remove(this.showLegendsScreen);
        this.getTitleView.editorClicked.remove(this.showMapEditor);
        this.getTitleView.accountClicked.remove(this.handleIntentionToReviewAccount);
        this.getTitleView.quitClicked.remove(this.handleIntentionToQuitGame);
        getTitleView.destroy();
    }

    private function handleIntentionToPlay():void {
        if (this.account.isRegistered()) {
            this.enterGame.dispatch();
        } else {
            this.openAccountInfo.dispatch(false);
        }
    }

    private function showLegendsScreen():void {
        this.setScreen.dispatch(new LegendsView());
    }

    private function showMapEditor():void {
        this.setScreen.dispatch(new MapEditor());
    }

    private function handleIntentionToReviewAccount():void {
        this.openAccountInfo.dispatch(false);
    }

    private function handleIntentionToQuitGame():void {
        this.openQuitDialog.dispatch(false);
    }
}
}
