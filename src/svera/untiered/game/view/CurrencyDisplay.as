package svera.untiered.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.ui.SimpleText;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;

public class CurrencyDisplay extends Sprite {

    private static const FONT_SIZE:int = 18;


    private var tsavoriteText_:SimpleText;

    private var medallionsText_:SimpleText;

    private var honorText_:SimpleText;

    private var fameText_:SimpleText;

    private var tsavoriteIcon_:Bitmap;

    private var medallionsIcon_:Bitmap;

    private var honorIcon_:Bitmap;

    private var fameIcon_:Bitmap;

    private var tsavorite_:int = -1;

    private var medallions_:int = -1;

    private var honor_:int = -1;

    private var fame_:int = -1;

    private var gs:GameSprite;

    public function CurrencyDisplay(gs:GameSprite = null) {
        super();
        this.gs = gs;
        this.tsavoriteText_ = new SimpleText(FONT_SIZE, 16777215, false, 0, 0);
        this.tsavoriteText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        addChild(this.tsavoriteText_);
        var tsavoriteBD:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 2);
        tsavoriteBD = TextureRedrawer.redraw(tsavoriteBD, 40, true, 0);
        this.tsavoriteIcon_ = new Bitmap(tsavoriteBD);
        addChild(this.tsavoriteIcon_);
        this.medallionsText_ = new SimpleText(FONT_SIZE, 16777215, false, 0, 0);
        this.medallionsText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        addChild(this.medallionsText_);
        var medallionsBD:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 1);
        medallionsBD = TextureRedrawer.redraw(medallionsBD, 40, true, 0);
        this.medallionsIcon_ = new Bitmap(medallionsBD);
        addChild(this.medallionsIcon_);
        this.honorText_ = new SimpleText(FONT_SIZE, 16777215, false, 0, 0);
        this.honorText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        addChild(this.honorText_);
        var honorBD:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 0);
        honorBD = TextureRedrawer.redraw(honorBD, 40, true, 0);
        this.honorIcon_ = new Bitmap(honorBD);
        addChild(this.honorIcon_);
        this.fameText_ = new SimpleText(FONT_SIZE, 16777215, false, 0, 0);
        this.fameText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        addChild(this.fameText_);
        var fameBD:BitmapData = AssetLibrary.getImageFromSet("Assets_Currency_Icons16x16", 3);
        fameBD = TextureRedrawer.redraw(fameBD, 40, true, 0);
        this.fameIcon_ = new Bitmap(fameBD);
        addChild(this.fameIcon_);
        this.draw(0, 0, 0, 0);
        mouseEnabled = false;
        doubleClickEnabled = false;
    }

    public function draw(tsavorite:int, medallions:int, honor:int, fame:int, compact:Boolean = false):void {
        if (tsavorite == this.tsavorite_ && medallions == this.medallions_ && honor == this.honor_ && fame == this.fame_) {
            return;
        }
        this.tsavorite_ = tsavorite;
        this.tsavoriteIcon_.x = -this.tsavoriteIcon_.width;
        this.tsavoriteText_.text = this.tsavorite_.toString();
        this.tsavoriteText_.updateMetrics();
        this.tsavoriteText_.x = this.tsavoriteIcon_.x - this.tsavoriteText_.width + 8;
        this.tsavoriteText_.y = this.tsavoriteIcon_.height / 2 - this.tsavoriteText_.height / 2;
        this.medallions_ = medallions;
        this.medallionsIcon_.x = this.tsavoriteText_.x - medallionsIcon_.width;
        this.medallionsText_.text = this.medallions_.toString();
        this.medallionsText_.updateMetrics();
        this.medallionsText_.x = this.medallionsIcon_.x - this.medallionsText_.width + 8;
        this.medallionsText_.y = this.medallionsIcon_.height / 2 - this.medallionsText_.height / 2;
        if (compact) {
            this.honor_ = honor;
            this.honorText_.text = this.honor_.toString();
            this.honorText_.updateMetrics();
            this.honorIcon_.x = this.tsavoriteText_.x - honorIcon_.width;
            this.honorText_.x = this.tsavoriteText_.x;
            this.honorText_.y = this.honorIcon_.height / 2 - this.honorText_.height / 2 + this.honorIcon_.height;

            this.fame_ = fame;
            this.fameText_.text = this.fame_.toString();
            this.fameText_.updateMetrics();
            this.fameIcon_.x = this.medallionsText_.x - this.fameIcon_.width;
            this.fameText_.x = this.fameIcon_.x - this.fameText_.width + 8;
            this.fameText_.y = this.fameIcon_.height / 2 - this.fameText_.height / 2 + this.fameIcon_.height;
        } else {
            this.honor_ = honor;
            this.honorText_.text = this.honor_.toString();
            this.honorText_.updateMetrics();
            this.honorIcon_.x = this.medallionsText_.x - honorIcon_.width;
            this.honorText_.x = this.honorIcon_.x - this.honorText_.width + 8;
            this.honorText_.y = this.honorIcon_.height / 2 - this.honorText_.height / 2;

            this.fame_ = fame;
            this.fameText_.text = this.fame_.toString();
            this.fameText_.updateMetrics();
            this.fameIcon_.x = this.honorText_.x - this.fameIcon_.width;
            this.fameText_.x = this.fameIcon_.x - this.fameText_.width + 8;
            this.fameText_.y = this.fameIcon_.height / 2 - this.fameText_.height / 2;
        }
    }
}
}
