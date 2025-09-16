package svera.untiered.classes.view {
import com.company.assembleegameclient.util.Currency;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;

import svera.untiered.assets.model.Animation;

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
        var count:int;
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

        view.setSkin(makeIcon(model));
        view.setModel(model);
        view.setLockIcon(AssetLibrary.getImageFromSet("lofiInterface2", 5));
        return view;
    }


    private function makeIcon(model:CharacterSkin):Animation {
        var data:Animation = characters.makeWalkingIcon(model.template, 100);
        return data;
    }
}
}
