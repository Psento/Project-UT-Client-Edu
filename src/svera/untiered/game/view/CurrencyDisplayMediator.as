package svera.untiered.game.view {
import svera.lib.framework.Mediator;

import svera.untiered.core.model.PlayerModel;

public class CurrencyDisplayMediator extends Mediator {


    [Inject]
    public var view:CurrencyDisplay;

    [Inject]
    public var model:PlayerModel;

    public function CurrencyDisplayMediator() {
        super();
    }

    override public function initialize():void {
        this.model.tsavoriteChanged.add(this.onTsavoriteChanged);
        this.model.medallionsChanged.add(this.onMedallionsChanged);
        this.model.honorChanged.add(this.onHonorChanged);
        this.model.honorChanged.add(this.onHonorChanged);
        this.view.draw(this.model.getTsavorite(), this.model.getMedallions(), this.model.getHonor());
    }

    override public function destroy():void {
        this.model.tsavoriteChanged.remove(this.onTsavoriteChanged);
        this.model.medallionsChanged.remove(this.onMedallionsChanged);
        this.model.honorChanged.remove(this.onHonorChanged);
        this.model.honorChanged.remove(this.onHonorChanged);
    }

    private function onTsavoriteChanged(tsavorite:int):void {
        this.view.draw(tsavorite, this.model.getMedallions(), this.model.getHonor());
    }

    private function onMedallionsChanged(medallions:int):void {
        this.view.draw(this.model.getTsavorite(), medallions, this.model.getHonor());
    }

    private function onHonorChanged(honor:int):void {
        this.view.draw(this.model.getTsavorite(), this.model.getMedallions(), honor);
    }
}
}
