package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.objects.IInteractiveObject;
import com.company.assembleegameclient.ui.panels.InteractPanel;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.core.model.MapModel;

public class InteractPanelMediator extends Mediator {


    [Inject]
    public var view:InteractPanel;

    [Inject]
    public var mapModel:MapModel;

    public function InteractPanelMediator() {
        super();
    }

    override public function initialize():void {
        this.view.requestInteractive = this.provideInteractive;
    }

    override public function destroy():void {
        super.destroy();
    }

    public function provideInteractive():IInteractiveObject {
        return this.mapModel.currentInteractiveTarget;
    }
}
}
