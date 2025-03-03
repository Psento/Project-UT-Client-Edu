package svera.untiered.game.signals {
import org.osflash.signals.Signal;

import svera.untiered.game.model.AddSpeechBalloonVO;

public class AddSpeechBalloonSignal extends Signal {


    public function AddSpeechBalloonSignal() {
        super(AddSpeechBalloonVO);
    }
}
}
