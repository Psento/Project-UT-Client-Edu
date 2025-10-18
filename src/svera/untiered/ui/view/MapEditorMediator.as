package svera.untiered.ui.view {
import com.company.assembleegameclient.mapeditor.MapEditor;

import svera.lib.framework.Mediator;

import svera.untiered.core.model.PlayerModel;

public class MapEditorMediator extends Mediator {

    [Inject]
    public var model:PlayerModel;

    public function getMapEditor():MapEditor {
        return view as MapEditor;
    }

    override public function initialize():void {
        this.getMapEditor.initialize(this.model);
    }
}
}
