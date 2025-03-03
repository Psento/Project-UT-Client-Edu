package svera.untiered.storage.components {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.ui.SimpleText;
import com.company.util.MoreColorUtil;
import com.company.util.SpriteUtil;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;

import svera.untiered.util.components.LegacyBuyButton;

public class VaultUpgradeButton extends Sprite {

    private static const CAPACITY_INCREMENT:int = 8;

    private static const WIDTH:int = 120;
    private static const HEIGHT:int = 40;

    private var statusText_:SimpleText;
    private var purchaseText_:SimpleText;

    private var currencyIcon_:Bitmap;

    public function VaultUpgradeButton() {
        super();

        this.statusText_ = new SimpleText(14, 0xFFFFFF);
        this.statusText_.setBold(true);
        this.purchaseText_ = new SimpleText(14, 0xFFFFFF);

        this.currencyIcon_ = new Bitmap(LegacyBuyButton.tsavorite);
        this.currencyIcon_.scaleX = 0.75;
        this.currencyIcon_.scaleY = 0.75;
        addChild(this.currencyIcon_);

        graphics.clear();
        graphics.beginFill(0x161616);
        graphics.drawRect(0, 20, WIDTH, HEIGHT);
        graphics.endFill();

        this.addEventListener(MouseEvent.ROLL_OVER, this.rollOver);
        this.addEventListener(MouseEvent.ROLL_OUT, this.rollOut);
    }

    public function setPurchaseInfo(curCapacity:int):void {
        this.statusText_.setText(curCapacity + " > " + (curCapacity + CAPACITY_INCREMENT));
        this.purchaseText_.setText("Upgrade " + Parameters.VAULT_SLOT_PRICE);

        this.statusText_.updateMetrics();
        this.purchaseText_.updateMetrics();

        this.statusText_.x = (WIDTH - this.statusText_.actualWidth_) / 2;
        this.statusText_.y = 0;
        this.purchaseText_.x = (WIDTH - this.purchaseText_.actualWidth_) / 2 - 15;
        this.purchaseText_.y = 28;

        this.currencyIcon_.x = this.purchaseText_.actualWidth_ + this.purchaseText_.x;
        this.currencyIcon_.y = 25;

        SpriteUtil.safeAddChild(this, this.statusText_);
        SpriteUtil.safeAddChild(this, this.purchaseText_);
    }

    private function rollOver(e:MouseEvent):void {
        this.transform.colorTransform = MoreColorUtil.darkCT;
    }

    private function rollOut(e:MouseEvent):void {
        this.transform.colorTransform = MoreColorUtil.identity;
    }
}
}
