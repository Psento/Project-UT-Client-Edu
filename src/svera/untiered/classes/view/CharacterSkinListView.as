package svera.untiered.classes.view {
import com.company.assembleegameclient.util.Currency;

import flash.display.Sprite;

import svera.untiered.classes.model.CharacterSkin;

import svera.untiered.classes.model.CharacterSkinState;
import svera.untiered.util.components.LegacyBuyButton;
import svera.untiered.util.components.api.BuyButton;

public class CharacterSkinListView extends Sprite {
    public static const PADDING:int = 5;
    public static const WIDTH:int = 442;
    public static const HEIGHT:int = 400;

    public var skinsContainer:Sprite;
    public var items:Vector.<CharacterSkinListItem>;
    public var buyButton:BuyButton;

    public function CharacterSkinListView() {
        super();
    }

    private function makeList():Sprite {
        skinsContainer = new Sprite();


    }

    public function setItems(items_:Vector.<CharacterSkinListItem>):void {
        this.items = items_;
        for each(var item:CharacterSkinListItem in items_){
            item.model.changed.add(setBuyButton);
        }
    }

    private function makeBuyButtonContainer():Sprite {
        var container:Sprite = new Sprite();
        container.x = width / 2;
        container.y = 0;
        addChild(container);
        return container;
    }

    public function setBuyButton(skin:CharacterSkin):void {
        var button:LegacyBuyButton = new LegacyBuyButton("", 16, 0, Currency.TSAVORITE);
        button.setWidth(40);
        this.buyButton = button;

        this.buyButton.x = -this.buyButton.width / 2;
        this.buyButton.y = this.buyButton.height - 2;
        this.buyButton.visible = skin.getState() == CharacterSkinState.PURCHASABLE;
    }

}
}
