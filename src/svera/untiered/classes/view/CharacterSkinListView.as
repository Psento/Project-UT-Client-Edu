package svera.untiered.classes.view {
import flash.display.DisplayObject;
import flash.display.Sprite;

import starling.display.DisplayObject;

import svera.lib.ui.api.Size;
import svera.untiered.util.components.HorizontalScrollingList;

public class CharacterSkinListView extends Sprite {
    public static const PADDING:int = 5;
    public static const WIDTH:int = 442;
    public static const HEIGHT:int = 400;


    private const list:HorizontalScrollingList = makeList();
    private var items:Vector.<CharacterSkinListItem>;

    public function CharacterSkinListView() {
        super();
    }

    private function makeList():HorizontalScrollingList {
        var list:HorizontalScrollingList = new HorizontalScrollingList();
        list.setSize(new Size(WIDTH, HEIGHT));
        list.scrollStateChanged.add(this.onScrollStateChanged);
        list.setPadding(PADDING);
        addChild(list);
        return list;
    }

    public function setItems(items:Vector.<CharacterSkinListItem>):void {
        this.items = items;
        var displayObject:Vector.<DisplayObject> = new Vector.<DisplayObject>(items.length);
        for (var i:int = 0; i < items.length; i++) {
            displayObject[i] = items[i] as DisplayObject;
        }
        this.list.setItems(items);
        this.onScrollStateChanged(this.list.isScrollbarVisible());
    }

    private function onScrollStateChanged(isVisible:Boolean):void {
        var item:CharacterSkinListItem = null;
        var width:int = CharacterSkinListItem.WIDTH;
        if (!isVisible) {
            width = width + HorizontalScrollingList.SCROLLBAR_GUTTER;
        }
/*        for each(item in this.items) {
            item.setWidth(width);
        }*/
    }

    public function getListHeight():Number {
        return this.list.getListHeight();
    }
}
}
