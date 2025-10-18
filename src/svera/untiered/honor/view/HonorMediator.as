package svera.untiered.honor.view {
import flash.display.BitmapData;

import svera.lib.framework.Mediator;

import svera.untiered.assets.services.CharacterFactory;
import svera.untiered.core.signals.GotoPreviousScreenSignal;
import svera.untiered.core.signals.SetScreenSignal;
import svera.untiered.death.model.DeathModel;
import svera.untiered.honor.model.HonorModel;
import svera.untiered.honor.service.RequestCharacterHonorTask;
import svera.untiered.legends.view.LegendsView;
import svera.untiered.messaging.impl.incoming.Death;

public class HonorMediator extends Mediator {


    [Inject]
    public var view:HonorView;

    [Inject]
    public var honorModel:HonorModel;

    [Inject]
    public var deathModel:DeathModel;

    [Inject]
    public var setScreen:SetScreenSignal;

    [Inject]
    public var gotoPrevious:GotoPreviousScreenSignal;

    [Inject]
    public var task:RequestCharacterHonorTask;

    [Inject]
    public var factory:CharacterFactory;

    private var isFreshDeath:Boolean;

    private var death:Death;

    public function HonorMediator() {
        super();
    }

    override public function initialize():void {
        this.view.closed.add(this.onClosed);
        this.setViewDataFromDeath();
        this.requestHonorData();
    }

    override public function destroy():void {
        this.view.closed.remove(this.onClosed);
        this.view.clearBackground();
        this.death && this.death.disposeBackground();
        this.task.finished.removeAll();
    }

    private function setViewDataFromDeath():void {
        this.isFreshDeath = this.deathModel.getIsDeathViewPending();
        this.view.setIsAnimation(this.isFreshDeath);
        this.death = this.deathModel.getLastDeath();
        if (this.death && this.death.background) {
            this.view.setBackground(this.death.background);
        }
    }

    private function requestHonorData():void {
        this.task.accountId = this.honorModel.accountId;
        this.task.charId = this.honorModel.characterId;
        this.task.finished.addOnce(this.onHonorResponse);
        this.task.start();
    }

    private function onHonorResponse(task:RequestCharacterHonorTask, isOK:Boolean, error:String = ""):void {
        var icon:BitmapData = this.makeIcon();
        this.view.setCharacterInfo(task.name, task.level, task.type);
        this.view.setDeathInfo(task.deathDate, task.killer);
        this.view.setIcon(icon);
        this.view.setScore(task.totalHonor, task.xml);
    }

    private function makeIcon():BitmapData {
        //if(this.isFreshDeath && this.death.isZombie)
        //{
        //   return this.makeZombieTexture();
        //}
        return this.makeNormalTexture();
    }

    private function makeNormalTexture():BitmapData {
        return this.factory.makeIcon(this.task.template, 250, this.task.texture1, this.task.texture2);
    }

    /*private function makeZombieTexture() : BitmapData
    {
       var textureData:TextureData = ObjectLibrary.typeToTextureData_[this.death.zombieType];
       var animatedChar:AnimatedChar = textureData.animatedChar_;
       var image:MaskedImage = animatedChar.imageFromDir(AnimatedChar.RIGHT,AnimatedChar.STAND,0);
       return TextureRedrawer.resize(image.image_,image.mask_,250,true,this.task.texture1,this.task.texture2);
    }*/

    private function onClosed():void {
        if (this.isFreshDeath) {
            this.setScreen.dispatch(new LegendsView());
        } else {
            this.gotoPrevious.dispatch();
        }
    }
}
}
