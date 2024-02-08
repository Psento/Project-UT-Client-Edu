package svera.untiered.ui.view
{
   import com.company.assembleegameclient.constants.ScreenTypes;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.AccountScreen;
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.assembleegameclient.ui.SoundIcon;
   import com.company.untiered.graphics.ScreenGraphic;
   import com.company.ui.SimpleText;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
import svera.untiered.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;
   
   public class TitleView extends Sprite
   {
      private static const COPYRIGHT:String = "© Svera, Inc.";
       
      
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
      
      public function TitleView()
      {
         super();
         addChild(new ScreenBase(1));
         addChild(new AccountScreen());
         this.makeChildren();
      }
      
      private function makeChildren() : void
      {
         this.playButton = new TitleMenuOption(ScreenTypes.PLAY,18,false, false);
         this.playClicked = this.playButton.clicked;
         this.addChild(this.playButton);
         this.legendsButton = new TitleMenuOption(ScreenTypes.LEGENDS,18,false, false);
         this.legendsClicked = this.legendsButton.clicked;
         this.addChild(this.legendsButton);
         this.editorButton = new TitleMenuOption(ScreenTypes.EDITOR,18,false, false);
         this.editorClicked = this.editorButton.clicked;
         this.addChild(editorButton);
         this.accountButton = new TitleMenuOption(ScreenTypes.ACCOUNT,18,false, false);
         this.accountClicked = this.accountButton.clicked;
         this.addChild(this.accountButton);
         this.quitButton = new TitleMenuOption("Quit Game",18,false, false);
         this.quitClicked = this.quitButton.clicked;
         this.addChild(this.quitButton);
         this.versionText = new SimpleText(12,8355711,false,0,0);
         this.versionText.filters = [new DropShadowFilter(0,0,0)];
         this.addChild(this.versionText);
         this.copyrightText = new SimpleText(12,8355711,false,0,0);
         this.copyrightText.text = COPYRIGHT;
         this.copyrightText.updateMetrics();
         this.copyrightText.filters = [new DropShadowFilter(0,0,0)];
         this.addChild(this.copyrightText);
      }
      
      public function initialize() : void
      {
         this.updateVersionText();
         this.positionButtons();
      }
      
      private function updateVersionText() : void
      {
         this.versionText.htmlText = "V" + Parameters.BUILD_VERSION;
         this.versionText.updateMetrics();
      }
      
      private function positionButtons() : void
      {
         this.playButton.x = stage.width / 2 - this.playButton.width / 2;
         this.playButton.y = stage.height / 2 + (this.playButton.height * 2);
         this.legendsButton.x = stage.width / 2 - this.legendsButton.width / 2;
         this.legendsButton.y = this.playButton.y + this.legendsButton.height + 18;
         this.editorButton.x = stage.width / 2 - this.editorButton.width / 2;
         this.editorButton.y = this.legendsButton.y + this.editorButton.height + 18;
         this.accountButton.x = stage.width / 2 - this.accountButton.width / 2;
         this.accountButton.y = this.editorButton.y + this.accountButton.height + 18;
         this.quitButton.x = stage.width / 2 - this.quitButton.width / 2;
         this.quitButton.y = this.accountButton.y + this.quitButton.height + 18;
         this.versionText.x = stage.width - this.versionText.width - this.versionText.height / 2;
         this.versionText.y = stage.height - this.versionText.height - this.versionText.height / 2;
         this.copyrightText.x = stage.width - this.copyrightText.width - this.copyrightText.height / 2;
         this.copyrightText.y = stage.height - this.versionText.height - this.copyrightText.height - this.copyrightText.height / 2;
      }
   }
}
