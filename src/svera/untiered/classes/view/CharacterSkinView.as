package svera.untiered.classes.view {
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.TitleMenuOption;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

import svera.untiered.game.view.CurrencyDisplay;
import svera.untiered.ui.view.components.ScreenBase;

public class CharacterSkinView extends Sprite {
    private var playBtn:TitleMenuOption;
    public var play:Signal;
    public var back:Signal;
    public static var positionStuff:Signal;
    private var classDetailView:ClassDetailView;

    public function CharacterSkinView() {
        super();
        makeScreenBase()
        makeAccountScreen()
        makeLines();
        makeCurrencyDisplay();
        playBtn = makePlayButton();
        var backBtn:TitleMenuOption = makeBackButton();
        play = new NativeMappedSignal(playBtn, MouseEvent.CLICK);
        back = new NativeMappedSignal(backBtn, MouseEvent.CLICK);
        positionStuff = new Signal();
        makeClassDetailView();
    }

    private function makeScreenBase():ScreenBase {
        var base:ScreenBase = new ScreenBase(2);
        addChild(base);
        return base;
    }

    private function makeAccountScreen():AccountScreen {
        var screen:AccountScreen = new AccountScreen();
        addChild(screen);
        return screen;
    }

    private function makeCurrencyDisplay():CurrencyDisplay {
        var display:CurrencyDisplay = new CurrencyDisplay();
        display.x = GameClient.StageWidth;
        display.y = 20;
        addChild(display);
        return display;
    }

    private function makeLines():Shape {
        var shape:Shape = new Shape();
        shape.graphics.clear();
        shape.graphics.lineStyle(2, 5526612);
        shape.graphics.moveTo(0, 105);
        shape.graphics.lineTo(GameClient.StageWidth, 105);
        shape.graphics.moveTo(346, 105);
        shape.graphics.lineTo(346, GameClient.StageHeight - (600 - 526));
        //addChild(shape);
        return shape;
    }

    private function makePlayButton():TitleMenuOption {
        var option:TitleMenuOption;
        option = new TitleMenuOption("play", 36, false);
        option.x = GameClient.HalfStageWidth - option.width / 2;
        option.y = GameClient.StageHeight - (600 - 520);
        addChild(option);
        return option;
    }

    private function makeBackButton():TitleMenuOption {
        var option:TitleMenuOption = new TitleMenuOption("back", 22, false);
        option.x = 30;
        option.y = GameClient.StageHeight - (600 - 534);
        addChild(option);
        return option;
    }

    private function makeClassDetailView():ClassDetailView {
        classDetailView = new ClassDetailView();

        addChild(classDetailView);

        positionStuff.add(positionThings);

        //Add left and right here because theyre out of class detail bounds
        addChild(classDetailView.skinListView.rightSkin);
        addChild(classDetailView.skinListView.leftSkin);

        return classDetailView;
    }

    private function positionThings():void {
        classDetailView.x = (width - ClassDetailView.WIDTH) / 2;
        classDetailView.y = (GameClient.StageHeight - classDetailView.height) / 2;

        trace("Position things dispatched");
        classDetailView.positionSkins();

        classDetailView.skinListView.rightSkin.x = classDetailView.x + ClassDetailView.WIDTH + classDetailView.skinListView.rightSkin.width;
        classDetailView.skinListView.rightSkin.y = classDetailView.y + classDetailView.height / 2;

        classDetailView.skinListView.leftSkin.x = classDetailView.x - classDetailView.skinListView.leftSkin.width;
        classDetailView.skinListView.leftSkin.y = classDetailView.skinListView.rightSkin.y;
    }

    public function setPlayButtonEnabled(activate:Boolean):void {
        if (!activate) {
            this.playBtn.deactivate();
        }
    }
}
}
