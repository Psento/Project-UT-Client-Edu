package svera.untiered.lootBoxes {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.IconButton;
import com.company.assembleegameclient.ui.TextButton;
import com.company.assembleegameclient.util.Currency;
import com.company.ui.SimpleText;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;

import svera.untiered.account.core.view.EmptyFrame;
import svera.untiered.core.StaticInjectorContext;
import svera.untiered.dialogs.control.CloseDialogsSignal;
import svera.untiered.game.model.GameModel;
import svera.untiered.game.view.LootboxesDisplay;
import svera.untiered.messaging.impl.incoming.Text;
import svera.untiered.util.components.LegacyBuyButton;

public class LootboxModal extends EmptyFrame {
    public static const MODAL_WIDTH:int = 490;
    public static const MODAL_HEIGHT:int = 540;
    private static const OVER_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));
    private static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0, 0, 0);
    private static const GLOW_FILTER:GlowFilter = new GlowFilter(0xFF0000, 1, 11, 5);
    private static const filterWithGlow:Array = [DROP_SHADOW_FILTER, GLOW_FILTER];
    private static const filterNoGlow:Array = [DROP_SHADOW_FILTER];

    [Embed(source="LootboxBackground_ImageEmbed.png")]
    public static var backgroundImageEmbed:Class;
    public static var modalWidth:int = MODAL_WIDTH;//440
    public static var modalHeight:int = MODAL_HEIGHT;//400

    private var triggeredOnStartup:Boolean;
    public var lootboxDisplay_:LootboxesDisplay;
    [Embed(source="LockerLootbox_ImageEmbed.png")]
    private var LockerLootbox_ImageEmbed:Class;
    private var Lootbox_Image1:Bitmap;
    [Embed(source="EventLootbox_ImageEmbed.png")]
    private var EventLootbox_ImageEmbed:Class;
    private var Lootbox_Image2:Bitmap;
    [Embed(source="GoldLootbox_ImageEmbed.png")]
    private var GoldLootbox_ImageEmbed:Class;
    private var Lootbox_Image3:Bitmap;
    [Embed(source="EliteLootbox_ImageEmbed.png")]
    private var EliteLootbox_ImageEmbed:Class;
    private var Lootbox_Image4:Bitmap;
    [Embed(source="PremiumLootbox_ImageEmbed.png")]
    private var PremiumLootbox_ImageEmbed:Class;
    private var Lootbox_Image5:Bitmap;

    private var Lootbox1Title:SimpleText;
    private var Lootbox2Title:SimpleText;
    private var Lootbox3Title:SimpleText;
    private var Lootbox4Title:SimpleText;
    private var Lootbox5Title:SimpleText;

    public var Lootbox1Amount:LegacyBuyButton;
    public var Lootbox2Amount:TextButton;
    public var Lootbox3Amount:TextButton;
    public var Lootbox4Amount:LegacyBuyButton;
    public var Lootbox5Amount:LegacyBuyButton;

    public function LootboxModal(_arg1:Boolean = false) {
        this.triggeredOnStartup = _arg1;
        modalWidth = MODAL_WIDTH;
        modalHeight = MODAL_HEIGHT;
        super(modalWidth, modalHeight);
        this.setCloseButton(true);
        this.setTitle("Lootboxes", true);
        addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        addEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
        closeButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
    }

    public function onCloseButtonClicked():void {
        var _local1:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseButtonClicked);
        if (this.triggeredOnStartup) {
            _local1.dispatch();
        }
    }

    private function onAdded(_arg1:Event):void {
    }


    private function destroy(_arg1:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
    }

    private function onArrowHover(_arg1:MouseEvent):void {
        _arg1.currentTarget.transform.colorTransform = OVER_COLOR_TRANSFORM;
    }

    private function onArrowHoverOut(_arg1:MouseEvent):void {
        _arg1.currentTarget.transform.colorTransform = MoreColorUtil.identity;
    }


    override protected function makeModalBackground():Sprite {
        var _local1:Sprite = new Sprite();
        var _local2:DisplayObject = new backgroundImageEmbed();
        _local2.width = (modalWidth + 1);
        _local2.height = (modalHeight - 25);
        _local2.y = 27;
        _local2.alpha = 1.00;
        var additive:int = 89;
        this.Lootbox_Image1 = new LockerLootbox_ImageEmbed().bitmapData;
        this.Lootbox_Image1.y = 100;
        this.Lootbox_Image1.x = 22;
        Lootbox_Image1.width = 21 * 4;
        Lootbox_Image1.height = 18 * 4;
        Lootbox_Image1.filters = [new DropShadowFilter(0, 0, 0xFF0044, 1, 12, 12, 1.5)]; // Locker LootBox
        this.Lootbox_Image2 = new EventLootbox_ImageEmbed().bitmapData;
        this.Lootbox_Image2.y = 100;
        this.Lootbox_Image2.x = this.Lootbox_Image1.x + additive;
        Lootbox_Image2.width = 21 * 4;
        Lootbox_Image2.height = 18 * 4;
        Lootbox_Image2.filters = [new DropShadowFilter(0, 0, 0x00FF21, 1, 12, 12, 1.5)]; // Event LootBox
        this.Lootbox_Image3 = new GoldLootbox_ImageEmbed().bitmapData;
        this.Lootbox_Image3.y = 100;
        this.Lootbox_Image3.x = this.Lootbox_Image2.x + additive;
        Lootbox_Image3.width = 21 * 4;
        Lootbox_Image3.height = 18 * 4;
        Lootbox_Image3.filters = [new DropShadowFilter(0, 0, 0xF7AA22, 1, 12, 12, 1.5)]; // Gold LootBox
        this.Lootbox_Image4 = new EliteLootbox_ImageEmbed().bitmapData;
        this.Lootbox_Image4.y = 100;
        this.Lootbox_Image4.x = this.Lootbox_Image3.x + additive;
        Lootbox_Image4.width = 21 * 4;
        Lootbox_Image4.height = 18 * 4;
        Lootbox_Image4.filters = [new DropShadowFilter(0, 0, 0xA80013, 1, 12, 12, 1.5)]; // Elite LootBox
        this.Lootbox_Image5 = new PremiumLootbox_ImageEmbed().bitmapData;
        this.Lootbox_Image5.y = 100;
        this.Lootbox_Image5.x = this.Lootbox_Image4.x + additive;
        Lootbox_Image5.width = 21 * 4;
        Lootbox_Image5.height = 18 * 4;
        Lootbox_Image5.filters = [new DropShadowFilter(0, 0, 0x00FFF6, 1, 12, 12, 1.5)]; // Premium LootBox

        this.Lootbox1Title = new SimpleText(10,0xFF0044, false, 20).setBold(true);
        this.Lootbox1Title.setText("Legendary Box");
        this.Lootbox1Title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.Lootbox1Title.x = this.Lootbox_Image1.x + 2;
        this.Lootbox1Title.y = this.Lootbox_Image1.y - 20;

        this.Lootbox1Amount = new LegacyBuyButton("", 12, 750000, Currency.HONOR);
        this.Lootbox1Amount.x = this.Lootbox_Image1.x + 8;
        this.Lootbox1Amount.y = this.Lootbox_Image1.y + 80;
        this.Lootbox1Amount.setEnabled(true);

        this.Lootbox2Title = new SimpleText(10,0x00FF21,false, 20).setBold(true);
        this.Lootbox2Title.setText("Event Lootbox");
        this.Lootbox2Title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.Lootbox2Title.x = this.Lootbox_Image2.x + 5;
        this.Lootbox2Title.y = this.Lootbox_Image2.y - 20;

        this.Lootbox2Amount = new TextButton(12, "Unbox");
        this.Lootbox2Amount.x = this.Lootbox_Image2.x + 17;
        this.Lootbox2Amount.y = this.Lootbox1Amount.y;
        this.Lootbox2Amount.setEnabled(true);

        this.Lootbox3Title = new SimpleText(10,0xF7AA22,false, 20).setBold(true);
        this.Lootbox3Title.setText("Gold Lootbox");
        this.Lootbox3Title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.Lootbox3Title.x = this.Lootbox_Image3.x + 6;
        this.Lootbox3Title.y = this.Lootbox_Image3.y - 20;

        this.Lootbox3Amount = new TextButton(12, "Unbox");
        this.Lootbox3Amount.x = this.Lootbox_Image3.x + 15;
        this.Lootbox3Amount.y = this.Lootbox1Amount.y;
        this.Lootbox3Amount.setEnabled(true);

        this.Lootbox4Title = new SimpleText(10, 0xA80013,false, 20).setBold(true);
        this.Lootbox4Title.setText("Elite Lootbox");
        this.Lootbox4Title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.Lootbox4Title.x = this.Lootbox_Image4.x + 8;
        this.Lootbox4Title.y = this.Lootbox_Image4.y - 20;

        this.Lootbox4Amount = new LegacyBuyButton("", 12, 5000, Currency.HONOR);
        this.Lootbox4Amount.x = this.Lootbox_Image4.x + 10;
        this.Lootbox4Amount.y = this.Lootbox1Amount.y;
        this.Lootbox4Amount.setEnabled(true);

        this.Lootbox5Title = new SimpleText(10,0x00FFF6, false ,20).setBold(true);
        this.Lootbox5Title.setText("Premium Lootbox");
        this.Lootbox5Title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.Lootbox5Title.x = this.Lootbox_Image5.x - 3;
        this.Lootbox5Title.y = this.Lootbox_Image5.y - 20;

        this.Lootbox5Amount = new LegacyBuyButton("", 12, 5000, Currency.TSAVORITE);
        this.Lootbox5Amount.x = this.Lootbox_Image5.x + 15;
        this.Lootbox5Amount.y = this.Lootbox_Image5.y + 80;
        this.Lootbox5Amount.setEnabled(true);

        var _local4:PopupWindowBackground = new PopupWindowBackground();
        _local4.draw(modalWidth, modalHeight, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
        _local1.addChild(_local2);
        _local1.addChild(_local4);
        _local1.addChild(this.Lootbox_Image1);
        _local1.addChild(this.Lootbox_Image2);
        _local1.addChild(this.Lootbox_Image3);
        _local1.addChild(this.Lootbox_Image4);
        _local1.addChild(this.Lootbox_Image5);
        _local1.addChild(this.Lootbox1Title);
        _local1.addChild(this.Lootbox2Title);
        _local1.addChild(this.Lootbox3Title);
        _local1.addChild(this.Lootbox4Title);
        _local1.addChild(this.Lootbox5Title);
        _local1.addChild(this.Lootbox1Amount);
        _local1.addChild(this.Lootbox2Amount);
        _local1.addChild(this.Lootbox3Amount);
        _local1.addChild(this.Lootbox4Amount);
        _local1.addChild(this.Lootbox5Amount);
        this.lootboxDisplay_ = new LootboxesDisplay(null);


        this.lootboxDisplay_.lootbox2Icon.x = Lootbox_Image2.x + 2;
        this.lootboxDisplay_.lootbox2Icon.y = Lootbox_Image2.y + 100;
        this.lootboxDisplay_.lootbox2Text.x = Lootbox_Image2.x + 33;
        this.lootboxDisplay_.lootbox2Text.y = Lootbox_Image2.y + 110;

        this.lootboxDisplay_.lootbox3Icon.x = Lootbox_Image3.x + 2;
        this.lootboxDisplay_.lootbox3Icon.y = this.lootboxDisplay_.lootbox2Icon.y;
        this.lootboxDisplay_.lootbox3Text.x = Lootbox_Image3.x + 33;
        this.lootboxDisplay_.lootbox3Text.y = this.lootboxDisplay_.lootbox2Text.y;

        this.lootboxDisplay_.lootbox4Icon.x = Lootbox_Image4.x + 2;
        this.lootboxDisplay_.lootbox4Icon.y = this.lootboxDisplay_.lootbox2Icon.y;
        this.lootboxDisplay_.lootbox4Text.x = Lootbox_Image4.x + 33;
        this.lootboxDisplay_.lootbox4Text.y = this.lootboxDisplay_.lootbox2Text.y;

        _local1.addChild(this.lootboxDisplay_);
        var _local_3:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
        if (_local_3 != null) {
            this.lootboxDisplay_.draw(_local_3.eventLootbox_, _local_3.goldLootbox_, _local_3.eliteLootbox_);
        }
        //_local1.addChild(_local5);
        return (_local1);
    }

    private function onMouseClick(e:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
    }

    override public function onCloseClick(_arg1:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
    }


}
}
