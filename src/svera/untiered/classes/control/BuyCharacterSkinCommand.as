package svera.untiered.classes.control {
import svera.lib.framework.ICommand;
import svera.lib.tasks.TaskMonitor;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.classes.services.BuySkinTask;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.dialogs.control.OpenDialogSignal;
import svera.untiered.ui.view.NotEnoughTsavoriteDialog;

public class BuyCharacterSkinCommand implements ICommand {


    [Inject]
    public var skin:CharacterSkin;

    [Inject]
    public var model:PlayerModel;

    [Inject]
    public var task:BuySkinTask;

    [Inject]
    public var monitor:TaskMonitor;

    [Inject]
    public var openDialog:OpenDialogSignal;

    public function BuyCharacterSkinCommand() {
        super();
    }

    public function execute():void {
        if (this.isSkinPurchasable()) {
            this.enterPurchaseFlow();
        }
    }

    private function enterPurchaseFlow():void {
        if (this.isSkinAffordable()) {
            this.purchaseSkin();
        } else {
            this.enterGetTsavoriteFlow();
        }
    }

    private function isSkinPurchasable():Boolean {
        return this.skin.getState() == CharacterSkinState.PURCHASABLE;
    }

    private function isSkinAffordable():Boolean {
        return this.model.getTsavorite() >= this.skin.cost;
    }

    private function purchaseSkin():void {
        this.monitor.add(this.task);
        this.task.start();
    }

    private function enterGetTsavoriteFlow():void {
        this.openDialog.dispatch(new NotEnoughTsavoriteDialog());
    }
}
}
