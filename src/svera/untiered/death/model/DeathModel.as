package svera.untiered.death.model {
import svera.untiered.messaging.impl.incoming.Death;

public class DeathModel {


    private var isDeathHonorViewPending:Boolean;

    private var lastDeath:Death;

    public function DeathModel() {
        super();
    }

    public function setLastDeath(death:Death):void {
        this.lastDeath = death;
        this.isDeathHonorViewPending = true;
    }

    public function getLastDeath():Death {
        return this.lastDeath;
    }

    public function getIsDeathViewPending():Boolean {
        return this.isDeathHonorViewPending;
    }

    public function clearPendingDeathView():void {
        this.isDeathHonorViewPending = false;
    }
}
}
