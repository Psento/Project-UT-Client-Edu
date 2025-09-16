package svera.untiered.classes.view {
import com.company.assembleegameclient.util.HonorUtil;

import flash.events.TimerEvent;
import flash.utils.Timer;

import robotlegs.bender.bundles.mvcs.Mediator;

import svera.untiered.assets.model.Animation;
import svera.untiered.assets.services.CharacterFactory;
import svera.untiered.classes.control.FocusCharacterSkinSignal;
import svera.untiered.classes.model.CharacterClass;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.ClassesModel;
import svera.untiered.core.model.PlayerModel;

public class ClassDetailMediator extends Mediator {


    [Inject]
    public var view:ClassDetailView;

    [Inject]
    public var classesModel:ClassesModel;

    [Inject]
    public var playerModel:PlayerModel;

    [Inject]
    public var focusSet:FocusCharacterSkinSignal;

    [Inject]
    public var factory:CharacterFactory;

    private const skins:Object = new Object();

    private var character:CharacterClass;

    private var nextSkin:CharacterSkin;

    private const nextSkinTimer:Timer = new Timer(250, 1);

    public function ClassDetailMediator() {
        super();
    }

    override public function initialize():void {
        this.character = this.classesModel.getSelected();
        this.nextSkinTimer.addEventListener(TimerEvent.TIMER, this.delayedFocusSet);
        this.focusSet.add(this.onFocusSet);
        this.setCharacterData();
        this.onFocusSet();
    }

    override public function destroy():void {
        this.focusSet.remove(this.onFocusSet);
        this.nextSkinTimer.removeEventListener(TimerEvent.TIMER, this.delayedFocusSet);
        this.view.setWalkingAnimation(null);
        this.disposeAnimations();
    }

    private function setCharacterData():void {
        var honor:int = this.playerModel.charList.bestHonor(this.character.id);
        var stars:int = HonorUtil.numStars(honor);
        this.view.setData(this.character.name, this.character.description, stars, this.playerModel.charList.bestLevel(this.character.id), honor);
        var nextStarHonor:int = HonorUtil.nextStarHonor(honor, 0);
        this.view.setNextGoal(this.character.name, nextStarHonor);
        CharacterSkinView.positionStuff.dispatch();
    }

    private function onFocusSet(skin:CharacterSkin = null):void {
        this.nextSkin = skin || this.character.skins.getSelectedSkin();
        this.nextSkinTimer.start();
    }

    private function delayedFocusSet(e:TimerEvent):void {
        var animation:Animation = this.skins[this.nextSkin.id] = this.skins[this.nextSkin.id] || this.factory.makeWalkingIcon(this.nextSkin.template, 200);
        this.view.setWalkingAnimation(animation);
    }

    private function disposeAnimations():void {
        var id:* = null;
        var animation:Animation = null;
        for (id in this.skins) {
            animation = this.skins[id];
            animation.dispose();
            delete this.skins[id];
        }
    }
}
}
