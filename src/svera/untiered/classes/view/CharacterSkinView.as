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
        var option:TitleMenuOption = null;
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

    private var selectedSkin:int = 0;
    private function makeClassDetailView():ClassDetailView {
        var view:ClassDetailView = new ClassDetailView();

        addChild(view);

        var skinListView:CharacterSkinListView = new CharacterSkinListView();

        addChild(skinListView);

        var leftSkin:TitleMenuOption = new TitleMenuOption(">", 24, true, true);
        var rightSkin:TitleMenuOption = new TitleMenuOption("<", 24, true, true);
        function left():void
        {
            if(++selectedSkin >= skinListView.items.length){
                selectedSkin = 0;
            }
            skinListView.items[selectedSkin].setIsSelected(true);
        }
        function right():void
        {
            if(--selectedSkin <= 0){
                selectedSkin = skinListView.items.length - 1;
            }
            skinListView.items[selectedSkin].setIsSelected(true);
        }
        leftSkin.clicked.add(left);
        rightSkin.clicked.add(right);

        positionStuff.addOnce(function ():void {
            view.x = (width - view.width) / 2;
            view.y = (GameClient.StageHeight - view.height) / 2;

            skinListView.x = (width - skinListView.width) / 2;
            skinListView.y = view.y + skinListView.height;

            leftSkin.x = view.x + view.width + leftSkin.width;
            leftSkin.y = view.y + view.height / 2;

            rightSkin.x = view.x - rightSkin.width;
            rightSkin.y = leftSkin.y;
        });

        addChild(leftSkin);
        addChild(rightSkin);

        return view;
    }

    public function setPlayButtonEnabled(activate:Boolean):void {
        if (!activate) {
            this.playBtn.deactivate();
        }
    }
}
}
