package svera.untiered.game.signals {
import org.osflash.signals.Signal;

import svera.untiered.game.model.GameInitData;

public class PlayGameSignal extends Signal {


    public function PlayGameSignal() {
        super(GameInitData);
    }
}
}
