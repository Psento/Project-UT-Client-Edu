package com.company.assembleegameclient.map {
import svera.lib.framework.Mediator;

public class MapMediator extends Mediator {
    [Inject]
    public var view:Map;

    public function MapMediator() {
        super();
    }

    override public function initialize():void {
    }

    override public function destroy():void {
    }
}
}
