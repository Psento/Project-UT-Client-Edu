package svera.untiered.minimap.control {
import org.osflash.signals.Signal;

import svera.untiered.minimap.model.UpdateGroundTileVO;

public class UpdateGroundTileSignal extends Signal {


    public function UpdateGroundTileSignal() {
        super(UpdateGroundTileVO);
    }
}
}
