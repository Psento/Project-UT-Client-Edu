package svera.untiered.game.view.components {
import svera.lib.framework.Mediator;

public class StatMediator extends Mediator {


    [Inject]
    public var view:StatView;

    public function StatMediator() {
        super();
    }

    override public function initialize():void {
    }

    override public function destroy():void {
    }
}
}
