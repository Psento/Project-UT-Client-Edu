package svera.untiered.minimap.control {
import org.osflash.signals.Signal;

import svera.untiered.ui.model.UpdateGameObjectTileVO;

public class UpdateGameObjectTileSignal extends Signal {


    public function UpdateGameObjectTileSignal() {
        super(UpdateGameObjectTileVO);
    }
}
}
