package svera.untiered.death.control {
import com.company.assembleegameclient.sound.Music;

import svera.untiered.core.model.PlayerModel;
import svera.untiered.death.model.DeathModel;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.messaging.impl.incoming.Death;

public class HandleDeathCommand {


    [Inject]
    public var death:Death;

    [Inject]
    public var closeDialogs:CloseDialogsSignal;

    [Inject]
    public var model:DeathModel;

    [Inject]
    public var player:PlayerModel;

    [Inject]
    public var normal:HandleNormalDeathSignal;

    public function HandleDeathCommand() {
        super();
    }

    public function execute():void {
        Music.load(Music.DEATH_MUSIC);
        this.closeDialogs.dispatch();
        if (this.isDeathPending()) {
            this.passPreviousDeathToFameView();
        } else {
            this.updateModelAndHandleDeath();
        }
    }

    private function isDeathPending():Boolean {
        return this.model.getIsDeathViewPending();
    }

    private function passPreviousDeathToFameView():void {
        this.normal.dispatch(this.model.getLastDeath());
    }

    private function updateModelAndHandleDeath():void {
        this.model.setLastDeath(this.death);
        this.normal.dispatch(this.death);
    }
}
}
