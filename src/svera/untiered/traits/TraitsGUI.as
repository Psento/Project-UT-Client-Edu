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

import mx.core.BitmapAsset;

public class TraitsGUI extends Sprite {
    /* initializing the list of assets we're using, there are three buttons to choose from so there's three vars. */
    public var awakeningIcons = new Vector.<Bitmap>;
    public var relicIcons = new Vector.<Bitmap>;
    public var backgroundIcons = new Vector.<Bitmap>;

    /* you cannot use BitmapAssets as buttons, so I made Sprite containers for each type of trait. */
    private var container = new Sprite();
    private var containerTwo = new Sprite();
    private var containerThree = new Sprite();

    /* initializing the values for each trait */
    private var typeOne:int;
    private var typeTwo:int;
    private var typeThree:int;

    /* initializing header text and a select button for when you're done. */
    private var titleText_:TextField;
    private var selectButton_:TextButton;

    /* adding desc. text, these will change depending on which trait is selected. */
    private var awakeningText:SimpleText;
    private var relicText:SimpleText;
    private var backgroundText:SimpleText;
    public function TraitsGUI() {
        /* sets the default value of the rune type to zero. */
        this.typeOne = 0;
        this.typeTwo = 0;
        this.typeThree = 0;

        /* makes a transparent background behind the UI. */
        graphics.clear();
        graphics.beginFill(2829099,0.8);
        graphics.drawRect(0,0,800,600);
        graphics.endFill();

        /* a BitmapAsset for the background, the .png has the runes circles, the details on the corners of the screen, the header and the description overlay. */
        addChild(new background());

        /* creates a line near the top of the screen above the background. */
        graphics.lineStyle(2,6184542);
        graphics.moveTo(0,100);
        graphics.lineTo(800,100);
        graphics.lineStyle();

        /* adds the containers for the assets on screen */
        addChild(this.container);
        addChild(this.containerTwo);
        addChild(this.containerThree);

        /* adds header text and a select button to close out of the GUI */
        var txt:TextField = new TextField();
        txt.autoSize = TextFieldAutoSize.CENTER;
        txt.textColor = 11776947;
        var newFormat:TextFormat = new TextFormat();
        newFormat.size = 28;
        newFormat.bold = true;
        newFormat.align = TextFormatAlign.CENTER;
        txt.defaultTextFormat = newFormat;
        this.titleText_ = txt;
        this.titleText_.text = "Traits";
        this.titleText_.x = 400 - this.titleText_.width / 2;
        this.titleText_.y = 32;
        addChild(this.titleText_);
        this.selectButton_ = new TextButton(18, "Select", 120);
        this.selectButton_.x = 340;
        this.selectButton_.y = 525;
        addChild(this.selectButton_);

        /* when the select button is selected, it will call a function that removes the GUI */
        this.selectButton_.addEventListener(MouseEvent.CLICK, onClose);

        /* calls the functions where the vectors and desc. text is handled */
        this.addIcons();
        this.addDesc();
    }

    public function onClose(param1:MouseEvent)
    {
        /* efficient way to remove the GUI from the screen. */
        stage.focus = null;
        parent.removeChild(this);
    }

    public function addDesc(): void
    {
        /* initializes the text on screen. I am using BaseSimpleText because you can utilize html tags to make segments bold and unbold. */
        this.awakeningText = new SimpleText(14, 0xffffff, false, 570, 50);
        this.relicText = new SimpleText(14, 0xffffff, false, 570, 50);
        this.backgroundText = new SimpleText(14, 0xffffff, false, 570, 50);

        /* sets the position of the text. */
        this.awakeningText.multiline = true;
        this.awakeningText.x = 115;
        this.awakeningText.y = 423;
        this.relicText.multiline = true;
        this.relicText.x = 115;
        this.relicText.y = 445;
        this.backgroundText.multiline = true;
        this.backgroundText.x = 115;
        this.backgroundText.y = 467;

        /* uses <b> tags to make text bold. set the default values to the first runes description text on screen. */
        this.awakeningText.htmlText = "<b>Swift Stride:</b> - Movement Speed Multiplier x1.15 - Proficient with short range weapons - Reduced effectiveness to paralyzing effects";
        this.relicText.htmlText = "<b>Defenseless:</b> Gain physical resistance based on your hp when not wearing armor.";
        this.backgroundText.htmlText = "<b>Acolyte:</b> Primary stat [INT] Secondary stat [HP]";

        /* adds the text on screen. */
        addChild(this.awakeningText);
        addChild(this.relicText);
        addChild(this.backgroundText);
    }

    public function addIcons(): void
    {
        /* the []'s set each value on the icon's list, this is initializing each one being used */
        var SwiftStride:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",0);
        SwiftStride = TextureRedrawer.redraw(SwiftStride,320,true,0);
        var ElementalWard:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",43);
        ElementalWard = TextureRedrawer.redraw(ElementalWard,320,true,0);
        var Brave:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",24);
        Brave = TextureRedrawer.redraw(Brave,320,true,0);
        var LethalElegance:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",97);
        LethalElegance = TextureRedrawer.redraw(LethalElegance,320,true,0);
        var AgileDuelist:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",2);
        AgileDuelist = TextureRedrawer.redraw(AgileDuelist,320,true,0);
        var HalfBreed:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",42);
        HalfBreed = TextureRedrawer.redraw(HalfBreed,320,true,0);
        var Seer:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",59);
        Seer = TextureRedrawer.redraw(Seer,320,true,0);
        var VoidTouched:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",1);
        VoidTouched = TextureRedrawer.redraw(VoidTouched,320,true,0);
        var Thaumaturge:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",40);
        Thaumaturge = TextureRedrawer.redraw(Thaumaturge,320,true,0);
        var ResilientAvenger:BitmapData = AssetLibrary.getImageFromSet("Assets_StarterGear",27);
        ResilientAvenger = TextureRedrawer.redraw(ResilientAvenger,320,true,0);
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

        var Defenseless:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Defenseless = TextureRedrawer.redraw(Defenseless,320,true,0);
        var Mithridatism:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Mithridatism = TextureRedrawer.redraw(Mithridatism,320,true,0);
        var Healthy:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Healthy = TextureRedrawer.redraw(Healthy,320,true,0);
        var Absorption:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Absorption = TextureRedrawer.redraw(Absorption,320,true,0);
        var Scope:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Scope = TextureRedrawer.redraw(Scope,320,true,0);
        var Dexterous:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Dexterous = TextureRedrawer.redraw(Dexterous,320,true,0);
        var Holy:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Holy = TextureRedrawer.redraw(Holy,320,true,0);
        var Incombustible:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Incombustible = TextureRedrawer.redraw(Incombustible,320,true,0);
        var RazorSharp:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        RazorSharp = TextureRedrawer.redraw(RazorSharp,320,true,0);
        this.relicIcons[0] = new Bitmap(Defenseless);
        this.relicIcons[1] = new Bitmap(Mithridatism);
        this.relicIcons[2] = new Bitmap(Healthy);
        this.relicIcons[3] = new Bitmap(Absorption);
        this.relicIcons[4] = new Bitmap(Scope);
        this.relicIcons[5] = new Bitmap(Dexterous);
        this.relicIcons[6] = new Bitmap(Holy);
        this.relicIcons[7] = new Bitmap(Incombustible);
        this.relicIcons[8] = new Bitmap(RazorSharp);

        var Acolyte:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Acolyte = TextureRedrawer.redraw(Acolyte,320,true,0);
        var Charlatan:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Charlatan = TextureRedrawer.redraw(Charlatan,320,true,0);
        var Criminal:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Criminal = TextureRedrawer.redraw(Criminal,320,true,0);
        var Entertainer:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Entertainer = TextureRedrawer.redraw(Entertainer,320,true,0);
        var Hero:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Hero = TextureRedrawer.redraw(Hero,320,true,0);
        var Artisan:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Artisan = TextureRedrawer.redraw(Artisan,320,true,0);
        var Noble:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Noble = TextureRedrawer.redraw(Noble,320,true,0);
        var Outlander:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Outlander = TextureRedrawer.redraw(Outlander,320,true,0);
        var Sage:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Sage = TextureRedrawer.redraw(Sage,320,true,0);
        var Soldier:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Soldier = TextureRedrawer.redraw(Soldier,320,true,0);
        var Urchin:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
        Urchin = TextureRedrawer.redraw(Urchin,320,true,0);
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
        for (var a:int = 0; a < 10; a++)
        {
            this.awakeningIcons.push(this.awakeningIcons[a]);
        }
        for (var a:int = 0; a < 9; a++)
        {
            this.relicIcons.push(this.relicIcons[a]);
        }
        for (var a:int = 0; a < 11; a++)
        {
            this.backgroundIcons.push(this.backgroundIcons[a]);
        }

        /* same as the last function, but this time it will make sure each rune icon is in these set positions */
        for (var b:int = 0; b < 10; b++)
        {
            this.awakeningIcons[b].x = 145 - this.awakeningIcons[b].width / 2;
            this.awakeningIcons[b].y = 300 - this.awakeningIcons[b].height / 2;
        }
        for (var b:int = 0; b < 9; b++)
        {
            this.relicIcons[b].x = 400 - this.awakeningIcons[b].width / 2;
            this.relicIcons[b].y = 300 - this.awakeningIcons[b].height / 2;
        }
        for (var b:int = 0; b < 11; b++)
        {
            this.backgroundIcons[b].x = 655 - this.awakeningIcons[b].width / 2;
            this.backgroundIcons[b].y = 300 - this.awakeningIcons[b].height / 2;
        }

        /* this makes it so if the container holding the assets is clicked, it will call a function.
        if you want to attach parameters to the function called, this is how it should be written:

        this.container.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { upd(); });
        this.containerTwo.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { upd2(); }); */
        this.container.addEventListener(MouseEvent.CLICK, upd);
        this.containerTwo.addEventListener(MouseEvent.CLICK, upd2);
        this.containerThree.addEventListener(MouseEvent.CLICK, upd3);

        /* this will add the sprite container to add the first asset of each type to itself */
        this.container.addChild(this.awakeningIcons[0]);
        this.containerTwo.addChild(this.relicIcons[0]);
        this.containerThree.addChild(this.backgroundIcons[0]);
    }

    private function upd(event:Event)
    {
        /* increases the trait type by one */
        this.typeOne++;

        /* removes and replaces the asset, for example: if you were on the first trait (0), it would increase to the second trait (1), and remove the one behind it (0), hence the this.typeOne - 1. */
        this.container.removeChild(this.awakeningIcons[this.typeOne - 1]);
        this.container.addChild(this.awakeningIcons[this.typeOne]);

        /* calls a function to update the text */
        this.updateText();
    }

    /* this function does the exact same thing, but for the second trait slot. */
    private function upd2(event:Event)
    {
        this.typeTwo++;
        this.containerTwo.removeChild(this.relicIcons[this.typeTwo - 1]);
        this.containerTwo.addChild(this.relicIcons[this.typeTwo]);
        this.updateText();
    }

    /* this function does the exact same thing, but for the second trait slot. */
    private function upd3(event:Event)
    {
        this.typeThree++;
        this.containerThree.removeChild(this.backgroundIcons[this.typeThree - 1]);
        this.containerThree.addChild(this.backgroundIcons[this.typeThree]);
        this.updateText();
    }

    private function updateText(): void
    {
        /* is the equivalent to saying if (this.typeOne == value), change the text to this. switches are the most efficient way of going about repeatable things with multiple values (like this). */
        switch (this.typeOne)
        {
            case 0:
                this.awakeningText.htmlText = "<b>Swift Stride:</b> - Movement Speed Multiplier x1.15 - Proficient with Short range weapons - Reduced effectiveness to paralyzing effects";
                break;
            case 1:
                this.awakeningText.htmlText = "<b>Elemental Ward:</b> - Gained resistance to all elemental damage";
                break;
            case 2:
                this.awakeningText.htmlText = "<b>Brave:</b> - Proficient with Small range weapons - Reduced effectiveness to paralyzing effects";
                break;
            case 3:
                this.awakeningText.htmlText = "<b>Lethal Elegance:</b> - Proficient with Medium range weapons - Improved Light armor effectiveness";
                break;
            case 4:
                this.awakeningText.htmlText = "<b>Agile Duelist:</b> - Proficient with Long range weapons - Improved Light and Medium armor effectiveness";
                break;
            case 5:
                this.awakeningText.htmlText = "<b>Half Breed:</b> - Movement Speed Multiplier x0.75 - Proficient with Short range weapons - Gain a chance to not be affected by paralyzing effects - Reduced effectiveness to Light damage";
                break;
            case 6:
                this.awakeningText.htmlText = "<b>Seer:</b> - Movement Speed Multiplier x1.15 - Proficient with Long range weapons - Improved Light armor effectiveness - Reduced effectiveness to paralyzing effects";
                break;
            case 7:
                this.awakeningText.htmlText = "<b>Void Touched:</b> - Movement Speed Multiplier x0.75 - Gain a chance to not be affected by terrify - Attacks with minmax damage gain an effect, the damage will roll twice, if the initial damage was lower than 50% of the maximum damage - Reduced effectiveness to void damage";
                break;
            case 8:
                this.awakeningText.htmlText = "<b>Thaumaturge:</b> - Movement Speed Multiplier x0.75 - Gain additional INT and RP - Reduced effectiveness to electric damage";
                break;
            case 9:
                this.awakeningText.htmlText = "<b>Resilient Avenger:</b> - If you reach 0 hp, you regain 1 hp instead of becoming downed - When you land a critical hit with a small or short ranged weapon, deal additional damage based on your attack";
                break;
            case 10:
                /* there should only be 10 awakenings to choose from, so if it goes past the 10th awakening, it will set it's text to the first awakening and change it's type back to it's default value */
                this.awakeningText.htmlText = "<b>Swift Stride:</b> - Movement Speed Multiplier x1.15 - Proficient with short range weapons - Reduced effectiveness to paralyzing effects";
                this.typeOne = 0;
                break;
        }

        /* same function for the second trait slot. */
        switch (this.typeTwo)
        {
            case 0:
                this.relicText.htmlText = "<b>Defenseless:</b> Gain physical resistance based on your hp when not wearing armor.";
                break;
            case 1:
                this.relicText.htmlText = "<b>Mithridatism:</b> Take only half the damage from poisons.";
                break;
            case 2:
                this.relicText.htmlText = "<b>Healthy:</b> Healing effect multiplier x1.3.";
                break;
            case 3:
                this.relicText.htmlText = "<b>Absorption:</b> Gained magic resistance.";
                break;
            case 4:
                this.relicText.htmlText = "<b>Scope:</b> Gain ranged weapon bonus damage.";
                break;
            case 5:
                this.relicText.htmlText = "<b>Dexterous:</b> Weapon damage scales with dexterity instead of magic damage or physical damage.";
                break;
            case 6:
                this.relicText.htmlText = "<b>Holy:</b> Gain additional Light damage.";
                break;
            case 7:
                this.relicText.htmlText = "<b>Incombustible:</b> Take only half the damage from fire.";
                break;
            case 8:
                this.relicText.htmlText = "<b>Razor Sharp:</b> Return a portion of the damage taken back at the attacker.";
                break;
            case 9:
                this.relicText.htmlText = "<b>Defenseless:</b> Gain physical resistance based on your hp when not wearing armor.";
                this.typeTwo = 0;
                break;
        }

        /* same function for the second trait slot. */
        switch (this.typeThree)
        {
            case 0:
                this.backgroundText.htmlText = "<b>Acolyte:</b> Primary stat [INT] Secondary stat [HP]";
                break;
            case 1:
                this.backgroundText.htmlText = "<b>Charlatan:</b> Primary stat [DEX] Secondary stat [DEX]";
                break;
            case 2:
                this.backgroundText.htmlText = "<b>Criminal:</b> Primary stat [INT] Secondary stat [SPD]";
                break;
            case 3:
                this.backgroundText.htmlText = "<b>Entertainer:</b> Primary stat [SPD] Secondary stat [RP]";
                break;
            case 4:
                this.backgroundText.htmlText = "<b>Hero:</b> Primary stat [VIG] Secondary stat [HP]";
                break;
            case 5:
                this.backgroundText.htmlText = "<b>Artisan:</b> Primary stat [INT] Secondary stat [INT]";
                break;
            case 6:
                this.backgroundText.htmlText = "<b>Noble:</b> Primary stat [RP] Secondary stat [INT]";
                break;
            case 7:
                this.backgroundText.htmlText = "<b>Outlander:</b> Primary stat [DEX] Secondary stat [HP]";
                break;
            case 8:
                this.backgroundText.htmlText = "<b>Sage:</b> Primary stat [MP] Secondary stat [MP]";
                break;
            case 9:
                this.backgroundText.htmlText = "<b>Soldier:</b> Primary stat [DEX] Secondary stat [PHYS OR MAG](HIGHEST STAT)";
                break;
            case 10:
                this.backgroundText.htmlText = "<b>Urchin:</b> Primary stat [DEX] Secondary stat [SPD]";
                break;
            case 11:
                this.backgroundText.htmlText = "<b>Acolyte:</b> Primary stat [INT] Secondary stat [HP]";
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
