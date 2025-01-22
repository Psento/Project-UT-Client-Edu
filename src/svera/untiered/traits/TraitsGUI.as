package svera.untiered.traits {

import com.company.assembleegameclient.ui.TextButton;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.ui.SimpleText;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import org.swiftsuspenders.Injector;

import svera.untiered.core.StaticInjectorContext;
import svera.untiered.core.model.PlayerModel;
import svera.untiered.game.model.GameInitData;
import svera.untiered.game.signals.PlayGameSignal;

public class TraitsGUI extends Sprite {

    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var play:PlayGameSignal;

    /* initializing the list of assets we're using, there are three buttons to choose from so there's three vars. */
    public var awakeningIcons:Vector.<Bitmap> = new Vector.<Bitmap>;
    public var relicIcons:Vector.<Bitmap> = new Vector.<Bitmap>;
    public var backgroundIcons:Vector.<Bitmap> = new Vector.<Bitmap>;

    /* you cannot use BitmapAssets as buttons, so I made Sprite containers for each type of trait. */
    private var container:Sprite = new Sprite();
    private var containerTwo:Sprite = new Sprite();
    private var containerThree:Sprite = new Sprite();

    /* initializing the values for each trait */
    private var typeOne:int;
    private var typeTwo:int;
    private var typeThree:int;

    /* initializing header text and a select button for when you're done. */
    private var awakeningTitleText_:TextField;
    private var relicTitleText_:TextField;
    private var backgroundTitleText_:TextField;
    private var selectButton_:TextButton;

    /* adding desc. text, these will change depending on which trait is selected. */
    private var awakeningText:SimpleText;
    private var relicText:SimpleText;
    private var backgroundText:SimpleText;

    public function TraitsGUI() {
        /* sets the default value of the trait type to zero. */
        this.typeOne = 0;
        this.typeTwo = 0;
        this.typeThree = 0;

        /* makes a transparent background behind the UI. */
        graphics.clear();
        graphics.beginFill(2829099, 0.8);
        graphics.drawRect(0, 0, GameClient.StageWidth, GameClient.StageHeight);
        graphics.endFill();

        /* a BitmapAsset for the background, the .png has the runes circles, the details on the corners of the screen, the header and the description overlay. */
        addChild(new background());

        /* creates a line near the top of the screen above the background. */
        graphics.lineStyle(2, 6184542);
        graphics.moveTo(0, 100);
        graphics.lineTo(GameClient.StageWidth, 100);
        graphics.lineStyle();

        /* adds the containers for the assets on screen */
        addChild(this.container);
        addChild(this.containerTwo);
        addChild(this.containerThree);

        /* adds header text and a select button to close out of the GUI */
        var txt0:TextField = new TextField();
        txt0.autoSize = TextFieldAutoSize.CENTER;
        txt0.textColor = 11776947;
        var txt1:TextField = new TextField();
        txt1.autoSize = TextFieldAutoSize.CENTER;
        txt1.textColor = 11776947;
        var txt2:TextField = new TextField();
        txt2.autoSize = TextFieldAutoSize.CENTER;
        txt2.textColor = 11776947;
        var newFormat:TextFormat = new TextFormat();
        newFormat.size = 28;
        newFormat.bold = true;
        newFormat.align = TextFormatAlign.CENTER;
        txt0.defaultTextFormat = newFormat;
        txt1.defaultTextFormat = newFormat;
        txt2.defaultTextFormat = newFormat;
        this.awakeningTitleText_ = txt0;
        this.awakeningTitleText_.text = "Awakening";
        this.awakeningTitleText_.x = GameClient.StageWidth / 3 - this.awakeningTitleText_.width / 2;
        this.awakeningTitleText_.y = 16;
        addChild(this.awakeningTitleText_);
        this.relicTitleText_ = txt1;
        this.relicTitleText_.text = "Relic";
        this.relicTitleText_.x = GameClient.HalfStageWidth - this.relicTitleText_.width / 2;
        this.relicTitleText_.y = 16;
        addChild(this.relicTitleText_);
        this.backgroundTitleText_ = txt2;
        this.backgroundTitleText_.text = "Background";
        this.backgroundTitleText_.x = GameClient.StageWidth * (2 / 3) - this.backgroundTitleText_.width / 2;
        this.backgroundTitleText_.y = 16;
        addChild(this.backgroundTitleText_);
        this.selectButton_ = new TextButton(18, "Select", 120);
        this.selectButton_.x = GameClient.HalfStageWidth - selectButton_.width * 0.5;
        this.selectButton_.y = GameClient.StageHeight - (600 - 561);
        addChild(this.selectButton_);

        /* when the select button is selected, it will call a function that removes the GUI */
        this.selectButton_.addEventListener(MouseEvent.CLICK, onClose);

        /* calls the functions where the vectors and desc. text is handled */
        this.addIcons();
        this.addDesc();
    }

    public function onClose(param1:MouseEvent) : void {
        /* efficient way to remove the GUI from the screen. */
        var game:GameInitData = new GameInitData();
        var injector:Injector = StaticInjectorContext.getInjector();
        this.model = injector.getInstance(PlayerModel);
        this.play = injector.getInstance(PlayGameSignal);
        game.createCharacter = true;
        game.charId = this.model.getNextCharId();
        game.traits = [typeOne, typeTwo, typeThree];
        game.isNewGame = true;
        stage.focus = null;
        parent.removeChild(this);
        this.play.dispatch(game);
    }

    public function addDesc():void {
        /* initializes the text on screen. I am using BaseSimpleText because you can utilize html tags to make segments bold and unbold. */
        this.awakeningText = new SimpleText(14, 0xffffff, false, 213, 201);
        this.relicText = new SimpleText(14, 0xffffff, false, 213, 201);
        this.backgroundText = new SimpleText(14, 0xffffff, false, 213, 201);

        /* sets the position of the text. */
        this.awakeningText.multiline = true;
        this.awakeningText.wordWrap = true;
        this.awakeningText.x = 40;
        this.awakeningText.y = 309;
        this.relicText.multiline = true;
        this.relicText.wordWrap = true;
        this.relicText.x = 294;
        this.relicText.y = 309;
        this.backgroundText.multiline = true;
        this.backgroundText.wordWrap = true;
        this.backgroundText.x = 548;
        this.backgroundText.y = 309;

        /* uses <b> tags to make text bold. set the default values to the first runes description text on screen. */
        this.awakeningText.htmlText = "<b>Swift Stride:</b> \n - Movement Speed Multiplier x1.15 \n - Proficient with short range weapons \n - Reduced effectiveness to paralyzing effects";
        this.relicText.htmlText = "<b>Defenseless:</b> \n - Gain physical resistance based on your hp when not wearing armor.";
        this.backgroundText.htmlText = "<b>Acolyte:</b> \n - Primary stat [INT] \n - Secondary stat [HP]";

        /* adds the text on screen. */
        addChild(this.awakeningText);
        addChild(this.relicText);
        addChild(this.backgroundText);
    }

    public function addIcons():void {
        /* the []'s set each value on the icon's list, this is initializing each one being used */
        var SwiftStride:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 0);
        SwiftStride = TextureRedrawer.redraw(SwiftStride, 320, true, 0);
        var ElementalWard:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 43);
        ElementalWard = TextureRedrawer.redraw(ElementalWard, 320, true, 0);
        var Brave:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 24);
        Brave = TextureRedrawer.redraw(Brave, 320, true, 0);
        var LethalElegance:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 97);
        LethalElegance = TextureRedrawer.redraw(LethalElegance, 320, true, 0);
        var AgileDuelist:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 2);
        AgileDuelist = TextureRedrawer.redraw(AgileDuelist, 320, true, 0);
        var HalfBreed:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 42);
        HalfBreed = TextureRedrawer.redraw(HalfBreed, 320, true, 0);
        var Seer:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 59);
        Seer = TextureRedrawer.redraw(Seer, 320, true, 0);
        var VoidTouched:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 1);
        VoidTouched = TextureRedrawer.redraw(VoidTouched, 320, true, 0);
        var Thaumaturge:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 40);
        Thaumaturge = TextureRedrawer.redraw(Thaumaturge, 320, true, 0);
        var ResilientAvenger:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear", 27);
        ResilientAvenger = TextureRedrawer.redraw(ResilientAvenger, 320, true, 0);
        this.awakeningIcons[0] = new Bitmap(SwiftStride);
        this.awakeningIcons[1] = new Bitmap(ElementalWard);
        this.awakeningIcons[2] = new Bitmap(Brave);
        this.awakeningIcons[3] = new Bitmap(LethalElegance);
        this.awakeningIcons[4] = new Bitmap(AgileDuelist);
        this.awakeningIcons[5] = new Bitmap(HalfBreed);
        this.awakeningIcons[6] = new Bitmap(Seer);
        this.awakeningIcons[7] = new Bitmap(VoidTouched);
        this.awakeningIcons[8] = new Bitmap(Thaumaturge);
        this.awakeningIcons[9] = new Bitmap(ResilientAvenger);

        var Defenseless:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Defenseless = TextureRedrawer.redraw(Defenseless, 320, true, 0);
        var Mithridatism:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Mithridatism = TextureRedrawer.redraw(Mithridatism, 320, true, 0);
        var Healthy:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Healthy = TextureRedrawer.redraw(Healthy, 320, true, 0);
        var Absorption:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Absorption = TextureRedrawer.redraw(Absorption, 320, true, 0);
        var Scope:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Scope = TextureRedrawer.redraw(Scope, 320, true, 0);
        var Dexterous:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Dexterous = TextureRedrawer.redraw(Dexterous, 320, true, 0);
        var Holy:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Holy = TextureRedrawer.redraw(Holy, 320, true, 0);
        var Incombustible:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Incombustible = TextureRedrawer.redraw(Incombustible, 320, true, 0);
        var RazorSharp:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        RazorSharp = TextureRedrawer.redraw(RazorSharp, 320, true, 0);
        this.relicIcons[0] = new Bitmap(Defenseless);
        this.relicIcons[1] = new Bitmap(Mithridatism);
        this.relicIcons[2] = new Bitmap(Healthy);
        this.relicIcons[3] = new Bitmap(Absorption);
        this.relicIcons[4] = new Bitmap(Scope);
        this.relicIcons[5] = new Bitmap(Dexterous);
        this.relicIcons[6] = new Bitmap(Holy);
        this.relicIcons[7] = new Bitmap(Incombustible);
        this.relicIcons[8] = new Bitmap(RazorSharp);

        var Acolyte:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Acolyte = TextureRedrawer.redraw(Acolyte, 320, true, 0);
        var Charlatan:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Charlatan = TextureRedrawer.redraw(Charlatan, 320, true, 0);
        var Criminal:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Criminal = TextureRedrawer.redraw(Criminal, 320, true, 0);
        var Entertainer:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Entertainer = TextureRedrawer.redraw(Entertainer, 320, true, 0);
        var Hero:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Hero = TextureRedrawer.redraw(Hero, 320, true, 0);
        var Artisan:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Artisan = TextureRedrawer.redraw(Artisan, 320, true, 0);
        var Noble:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Noble = TextureRedrawer.redraw(Noble, 320, true, 0);
        var Outlander:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Outlander = TextureRedrawer.redraw(Outlander, 320, true, 0);
        var Sage:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Sage = TextureRedrawer.redraw(Sage, 320, true, 0);
        var Soldier:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Soldier = TextureRedrawer.redraw(Soldier, 320, true, 0);
        var Urchin:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        Urchin = TextureRedrawer.redraw(Urchin, 320, true, 0);
        this.backgroundIcons[0] = new Bitmap(Acolyte);
        this.backgroundIcons[1] = new Bitmap(Charlatan);
        this.backgroundIcons[2] = new Bitmap(Criminal);
        this.backgroundIcons[3] = new Bitmap(Entertainer);
        this.backgroundIcons[4] = new Bitmap(Hero);
        this.backgroundIcons[5] = new Bitmap(Artisan);
        this.backgroundIcons[6] = new Bitmap(Noble);
        this.backgroundIcons[7] = new Bitmap(Outlander);
        this.backgroundIcons[8] = new Bitmap(Sage);
        this.backgroundIcons[9] = new Bitmap(Soldier);
        this.backgroundIcons[10] = new Bitmap(Urchin);

        /* this argument basioally says, this value equals 0, if it is below five, it will call the function and increase the value by one until it'd be above or equal to 10.
        the function will allow each value of the asset (starting from 0) to be on screen. */
        for (var a:int = 0; a < 10; a++) {
            this.awakeningIcons.push(this.awakeningIcons[a]);
        }
        for (a = 0; a < 9; a++) {
            this.relicIcons.push(this.relicIcons[a]);
        }
        for (a = 0; a < 11; a++) {
            this.backgroundIcons.push(this.backgroundIcons[a]);
        }

        /* same as the last function, but this time it will make sure each rune icon is in these set positions */
        for (var b:int = 0; b < 10; b++) {
            this.awakeningIcons[b].x = GameClient.StageWidth / 3 - this.awakeningIcons[b].width / 2;
            this.awakeningIcons[b].y = 170.5 - this.awakeningIcons[b].height / 2;
        }
        for (b = 0; b < 9; b++) {
            this.relicIcons[b].x = GameClient.HalfStageWidth - this.relicIcons[b].width / 2;
            this.relicIcons[b].y = 170.5 - this.relicIcons[b].height / 2;
        }
        for (b = 0; b < 11; b++) {
            this.backgroundIcons[b].x = GameClient.StageWidth * (2 / 3) - this.backgroundIcons[b].width / 2;
            this.backgroundIcons[b].y = 170.5 - this.backgroundIcons[b].height / 2;
        }

        /* this makes it so if the container holding the assets is clicked, it will call a function.
        if you want to attach parameters to the function called, this is how it should be written:

        this.container.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { upd(); });
        this.containerTwo.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { upd2(); }); */
        this.container.addEventListener(MouseEvent.CLICK, f1);
        this.containerTwo.addEventListener(MouseEvent.CLICK, f2);
        this.containerThree.addEventListener(MouseEvent.CLICK, f3);
        this.container.addEventListener(MouseEvent.RIGHT_CLICK, b1);
        this.containerTwo.addEventListener(MouseEvent.RIGHT_CLICK, b2);
        this.containerThree.addEventListener(MouseEvent.RIGHT_CLICK, b3);

        /* this will add the sprite container to add the first asset of each type to itself */
        this.container.addChild(this.awakeningIcons[0]);
        this.containerTwo.addChild(this.relicIcons[0]);
        this.containerThree.addChild(this.backgroundIcons[0]);
    }

    private function f1(event:Event) : void {
        /* increases the trait type by one */
        this.typeOne++;

        /* removes and replaces the asset, for example: if you were on the first trait (0), it would increase to the second trait (1), and remove the one behind it (0), hence the this.typeOne - 1. */
        this.container.removeChild(this.awakeningIcons[this.typeOne - 1]);
        this.container.addChild(this.awakeningIcons[this.typeOne]);

        /* calls a function to update the text */
        this.updateText();
    }

    private function b1(event:Event) : void {
        /* decrease the trait type by one */
        this.typeOne--;

        /* removes and replaces the asset, for example: if you were on the first trait (0), it would increase to the second trait (9), and remove the one behind it (0), hence the this.typeOne - 1. */
        this.container.removeChild(this.awakeningIcons[this.typeOne + 1]);
        if (this.typeOne < 0) this.typeOne = 9;
        this.container.addChild(this.awakeningIcons[this.typeOne]);

        /* calls a function to update the text */
        this.updateText();
    }

    /* this function does the exact same thing, but for the second trait slot. */
    private function f2(event:Event) : void {
        this.typeTwo++;
        this.containerTwo.removeChild(this.relicIcons[this.typeTwo - 1]);
        this.containerTwo.addChild(this.relicIcons[this.typeTwo]);
        this.updateText();
    }

    private function b2(event:Event) : void {
        this.typeTwo--;
        this.containerTwo.removeChild(this.relicIcons[this.typeTwo + 1]);
        if (this.typeTwo < 0) this.typeTwo = 8;
        this.containerTwo.addChild(this.relicIcons[this.typeTwo]);
        this.updateText();
    }

    /* this function does the exact same thing, but for the second trait slot. */
    private function f3(event:Event) : void {
        this.typeThree++;
        this.containerThree.removeChild(this.backgroundIcons[this.typeThree - 1]);
        this.containerThree.addChild(this.backgroundIcons[this.typeThree]);
        this.updateText();
    }

    private function b3(event:Event) : void {
        this.typeThree--;
        this.containerThree.removeChild(this.backgroundIcons[this.typeThree + 1]);
        if (this.typeThree < 0) this.typeThree = 10;
        this.containerThree.addChild(this.backgroundIcons[this.typeThree]);
        this.updateText();
    }

    private function updateText():void {
        /* is the equivalent to saying if (this.typeOne == value), change the text to this. switches are the most efficient way of going about repeatable things with multiple values (like this). */
        switch (this.typeOne) {
            case -1:
                /* there should only be 9 awakenings to choose from, so if it goes below the 1st awakening, it will set it's text to the last awakening and change it's type back to the highest value */
                this.awakeningText.htmlText = "<b>Resilient Avenger:</b> \n - If you reach 0 hp, you regain 1 hp instead of becoming downed \n - When you land a critical hit with a small or short ranged weapon, deal additional damage based on your attack";
                this.typeOne = 9;
                break;
            case 0:
                this.awakeningText.htmlText = "<b>Swift Stride:</b> \n - Movement Speed Multiplier x1.15 \n - Proficient with Short range weapons \n - Reduced effectiveness to paralyzing effects";
                break;
            case 1:
                this.awakeningText.htmlText = "<b>Elemental Ward:</b> \n - Gained resistance to all elemental damage";
                break;
            case 2:
                this.awakeningText.htmlText = "<b>Brave:</b> \n - Proficient with Small range weapons \n - Reduced effectiveness to paralyzing effects";
                break;
            case 3:
                this.awakeningText.htmlText = "<b>Lethal Elegance:</b> \n - Proficient with Medium range weapons \n - Improved Light armor effectiveness";
                break;
            case 4:
                this.awakeningText.htmlText = "<b>Agile Duelist:</b> \n - Proficient with Long range weapons \n - Improved Light and Medium armor effectiveness";
                break;
            case 5:
                this.awakeningText.htmlText = "<b>Half Breed:</b> \n - Movement Speed Multiplier x0.75 \n - Proficient with Short range weapons \n - Gain a chance to not be affected by paralyzing effects \n - Reduced effectiveness to Light damage";
                break;
            case 6:
                this.awakeningText.htmlText = "<b>Seer:</b> \n - Movement Speed Multiplier x1.15 \n - Proficient with Long range weapons \n - Improved Light armor effectiveness \n - Reduced effectiveness to paralyzing effects";
                break;
            case 7:
                this.awakeningText.htmlText = "<b>Void Touched:</b> \n - Movement Speed Multiplier x0.75 \n - Gain a chance to not be affected by terrify - Attacks with minmax damage gain an effect, the damage will roll twice, if the initial damage was lower than 50% of the maximum damage \n - Reduced effectiveness to void damage";
                break;
            case 8:
                this.awakeningText.htmlText = "<b>Thaumaturge:</b> \n - Movement Speed Multiplier x0.75 \n - Gain additional INT and RP \n - Reduced effectiveness to electric damage";
                break;
            case 9:
                this.awakeningText.htmlText = "<b>Resilient Avenger:</b> \n - If you reach 0 hp, you regain 1 hp instead of becoming downed \n - When you land a critical hit with a small or short ranged weapon, deal additional damage based on your attack";
                break;
            case 10:
                /* there should only be 9 awakenings to choose from, so if it goes past the 9th awakening, it will set it's text to the first awakening and change it's type back to it's default value */
                this.awakeningText.htmlText = "<b>Swift Stride:</b> \n - Movement Speed Multiplier x1.15 \n - Proficient with short range weapons \n - Reduced effectiveness to paralyzing effects";
                this.typeOne = 0;
                break;
        }

        /* same function for the second trait slot. */
        switch (this.typeTwo) {
            case -1:
                this.relicText.htmlText = "<b>Razor Sharp:</b> \n - Return a portion of the damage taken back at the attacker.";
                this.typeTwo = 8;
                break;
            case 0:
                this.relicText.htmlText = "<b>Defenseless:</b> \n - Gain physical resistance based on your hp when not wearing armor.";
                break;
            case 1:
                this.relicText.htmlText = "<b>Mithridatism:</b> \n - Take only half the damage from poisons.";
                break;
            case 2:
                this.relicText.htmlText = "<b>Healthy:</b> \n - Healing effect multiplier x1.3.";
                break;
            case 3:
                this.relicText.htmlText = "<b>Absorption:</b> \n - Gained magic resistance.";
                break;
            case 4:
                this.relicText.htmlText = "<b>Scope:</b> \n - Gain ranged weapon bonus damage.";
                break;
            case 5:
                this.relicText.htmlText = "<b>Dexterous:</b> \n - Weapon damage scales with dexterity instead of magic damage or physical damage.";
                break;
            case 6:
                this.relicText.htmlText = "<b>Holy:</b> \n - Gain additional Light damage.";
                break;
            case 7:
                this.relicText.htmlText = "<b>Incombustible:</b> \n - Take only half the damage from fire.";
                break;
            case 8:
                this.relicText.htmlText = "<b>Razor Sharp:</b> \n - Return a portion of the damage taken back at the attacker.";
                break;
            case 9:
                this.relicText.htmlText = "<b>Defenseless:</b> \n - Gain physical resistance based on your hp when not wearing armor.";
                this.typeTwo = 0;
                break;
        }

        /* same function for the second trait slot. */
        switch (this.typeThree) {
            case -1:
                this.backgroundText.htmlText = "<b>Urchin:</b> \n - Primary stat [DEX] \n - Secondary stat [SPD]";
                this.typeThree = 10;
                break;
            case 0:
                this.backgroundText.htmlText = "<b>Acolyte:</b> \n - Primary stat [INT] \n - Secondary stat [HP]";
                break;
            case 1:
                this.backgroundText.htmlText = "<b>Charlatan:</b> \n - Primary stat [DEX] \n - Secondary stat [DEX]";
                break;
            case 2:
                this.backgroundText.htmlText = "<b>Criminal:</b> \n - Primary stat [INT] \n - Secondary stat [SPD]";
                break;
            case 3:
                this.backgroundText.htmlText = "<b>Entertainer:</b> \n - Primary stat [SPD] \n - Secondary stat [RP]";
                break;
            case 4:
                this.backgroundText.htmlText = "<b>Hero:</b> \n - Primary stat [VIG] \n - Secondary stat [HP]";
                break;
            case 5:
                this.backgroundText.htmlText = "<b>Artisan:</b> \n - Primary stat [INT] \n - Secondary stat [INT]";
                break;
            case 6:
                this.backgroundText.htmlText = "<b>Noble:</b> \n - Primary stat [RP] \n - Secondary stat [INT]";
                break;
            case 7:
                this.backgroundText.htmlText = "<b>Outlander:</b> \n - Primary stat [DEX] \n - Secondary stat [HP]";
                break;
            case 8:
                this.backgroundText.htmlText = "<b>Sage:</b> \n - Primary stat [RP] \n - Secondary stat [RP]";
                break;
            case 9:
                this.backgroundText.htmlText = "<b>Soldier:</b> \n - Primary stat [DEX] \n - Secondary stat [PHYS OR MAG](HIGHEST STAT)";
                break;
            case 10:
                this.backgroundText.htmlText = "<b>Urchin:</b> \n - Primary stat [DEX] \n - Secondary stat [SPD]";
                break;
            case 11:
                this.backgroundText.htmlText = "<b>Acolyte:</b> \n - Primary stat [INT] \n - Secondary stat [HP]";
                this.typeThree = 0;
                break;
        }

        /* BaseSimpleText has a function called updateMetrics which is really convenient for updating text after certain properties change (e.g: typeOne and typeTwo). */
        this.awakeningText.updateMetrics();
        this.relicText.updateMetrics();
        this.backgroundText.updateMetrics();
    }
}
}
