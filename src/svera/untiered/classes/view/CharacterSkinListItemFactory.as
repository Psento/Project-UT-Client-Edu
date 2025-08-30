package svera.untiered.classes.view {
import com.company.assembleegameclient.util.Currency;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;

import svera.untiered.assets.services.CharacterFactory;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.CharacterSkins;
import svera.untiered.util.components.LegacyBuyButton;

public class CharacterSkinListItemFactory {
    [Inject]
    public var characters:CharacterFactory;

    public function CharacterSkinListItemFactory() {
        super();
    }

    public function make(skins:CharacterSkins):Vector.<CharacterSkinListItem> {
        var count:int = 0;
        count = skins.getCount();
        var items:Vector.<CharacterSkinListItem> = new Vector.<CharacterSkinListItem>(count, true);
        for (var i:int = 0; i < count; i++) {
            var charSkinTile:CharacterSkinListItem = makeCharacterSkinTile(skins.getSkinAt(i));
            items[i] = charSkinTile;
            charSkinTile.index = i;
        }
        return items;
    }

    private function makeCharacterSkinTile(model:CharacterSkin):CharacterSkinListItem {
        var view:CharacterSkinListItem = new CharacterSkinListItem();
        view.setSkin(this.makeIcon(model));
        view.setModel(model);
        view.setLockIcon(AssetLibrary.getImageFromSet("lofiInterface2", 5));
        view.setBuyButton(this.makeBuyButton());
        return view;
    }

    private function makeBuyButton():LegacyBuyButton {
        var button:LegacyBuyButton = new LegacyBuyButton("", 16, 0, Currency.TSAVORITE);
        button.setWidth(40);
        return button;
    }

    private function makeIcon(model:CharacterSkin):Bitmap {
        var data:BitmapData = this.characters.makeIcon(model.template, 100);
        return new Bitmap(data);
    }
}
}
