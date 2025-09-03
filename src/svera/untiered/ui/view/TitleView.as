package svera.untiered.ui.view {
import com.company.assembleegameclient.constants.ScreenTypes;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.UIHandler;
import com.company.ui.SimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import org.osflash.signals.Signal;

import svera.untiered.ui.view.components.ScreenBase;

public class TitleView extends Sprite {
    private static const COPYRIGHT:String = "© Svera Network 2022";


    public var playClicked:Signal;
    public var legendsClicked:Signal;
    public var editorClicked:Signal;
    public var accountClicked:Signal;
    public var quitClicked:Signal;

    private var playButton:TitleMenuOption;
    private var legendsButton:TitleMenuOption;
    private var editorButton:TitleMenuOption;
    private var accountButton:TitleMenuOption;
    private var quitButton:TitleMenuOption;

    private var versionText:SimpleText;
    private var copyrightText:SimpleText;
    private var uiHandler:UIHandler;

    public function TitleView() {
        super();
        addChild(new ScreenBase(1));
        addChild(new AccountScreen());
        this.makeChildren();
    }

    private function makeChildren():void {
        this.uiHandler = UIHandler.getInstance();
        this.playButton = new TitleMenuOption(ScreenTypes.PLAY, 18, false, false);
        this.playClicked = this.playButton.clicked;
        this.addChild(this.playButton);
        this.legendsButton = new TitleMenuOption(ScreenTypes.LEGENDS, 18, false, false);
        this.legendsClicked = this.legendsButton.clicked;
        this.addChild(this.legendsButton);
        this.editorButton = new TitleMenuOption(ScreenTypes.EDITOR, 18, false, false);
        this.editorClicked = this.editorButton.clicked;
        this.addChild(editorButton);
        this.accountButton = new TitleMenuOption(ScreenTypes.ACCOUNT, 18, false, false);
        this.accountClicked = this.accountButton.clicked;
        this.addChild(this.accountButton);
        this.quitButton = new TitleMenuOption("Quit Game", 18, false, false);
        this.quitClicked = this.quitButton.clicked;
        this.addChild(this.quitButton);
        this.versionText = new SimpleText(12, 8355711, false, 0, 0);
        this.versionText.filters = [new DropShadowFilter(0, 0, 0)];
        this.addChild(this.versionText);
        this.copyrightText = new SimpleText(12, 8355711, false, 0, 0);
        this.copyrightText.text = COPYRIGHT;
        this.copyrightText.updateMetrics();
        this.copyrightText.filters = [new DropShadowFilter(0, 0, 0)];
        this.addChild(this.copyrightText);
    }

    public function initialize():void {
        this.updateVersionText();
        this.registerButtons();
    }

    public function destroy():void {
        this.unregisterButtons();
    }

    private function updateVersionText():void {
        this.versionText.htmlText = "V" + Parameters.BUILD_VERSION;
        this.versionText.updateMetrics();
    }

    private function registerButtons():void {
        // Register all buttons with UIHandler for responsive positioning
        this.uiHandler.register(this.playButton, UIHandler.CENTER, 0, 100, true);
        this.uiHandler.register(this.legendsButton, UIHandler.CENTER, 0, 140, true);
        this.uiHandler.register(this.editorButton, UIHandler.CENTER, 0, 180, true);
        this.uiHandler.register(this.accountButton, UIHandler.CENTER, 0, 220, true);
        this.uiHandler.register(this.quitButton, UIHandler.CENTER, 0, 260, true);
        // Version and copyright - bottom right corner
        this.uiHandler.register(this.versionText, UIHandler.BOTTOM_RIGHT, -10, -30, false);
        this.uiHandler.register(this.copyrightText, UIHandler.BOTTOM_RIGHT, -10, -10, false);
    }

    private function unregisterButtons():void {
        this.uiHandler.unregister(this.playButton);
        this.uiHandler.unregister(this.legendsButton);
        this.uiHandler.unregister(this.editorButton);
        this.uiHandler.unregister(this.accountButton);
        this.uiHandler.unregister(this.quitButton);
        this.uiHandler.unregister(this.versionText);
        this.uiHandler.unregister(this.copyrightText);
    }
}
}
