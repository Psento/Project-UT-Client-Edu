package svera.untiered.legends.view {
import com.company.assembleegameclient.ui.Slot;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.ui.SimpleText;
import com.company.util.AssetLibrary;
import com.company.util.IIterator;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import org.osflash.signals.Signal;

import robotlegs.bender.framework.api.ILogger;

import svera.untiered.legends.model.Legend;

public class LegendListItem extends Sprite {

    public static const WIDTH:int = 756;

    public static const HEIGHT:int = 56;


    public const selected:Signal = new Signal(Legend);

    private var legend:Legend;

    private var placeText:SimpleText;

    private var characterBitmap:Bitmap;

    private var nameText:SimpleText;

    private var inventoryGrid:EquippedGrid;

    private var totalHonorText:SimpleText;

    private var honorIcon:Bitmap;

    private var isOver:Boolean;

    [inject]
    public var logger:ILogger;

    public function LegendListItem(legend:Legend) {
        super();
        this.legend = legend;
        this.makePlaceText();
        this.makeCharacterBitmap();
        this.makeNameText();
        this.makeInventory();
        this.makeTotalHonor();
        this.makeHonorIcon();
        this.addMouseListeners();
        this.draw();
    }

    public function getLegend():Legend {
        return this.legend;
    }

    private function makePlaceText():void {
        this.placeText = new SimpleText(22, this.getTextColor(), false, 0, 0);
        this.placeText.setBold(this.legend.place != -1);
        this.placeText.text = this.legend.place == -1 ? "---" : this.legend.place.toString() + ".";
        this.placeText.useTextDimensions();
        this.placeText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.placeText.x = 82 - this.placeText.width;
        this.placeText.y = HEIGHT / 2 - this.placeText.height / 2;
        addChild(this.placeText);
    }

    private function makeCharacterBitmap():void {
        this.characterBitmap = new Bitmap(this.legend.character);
        this.characterBitmap.x = 104;
        this.characterBitmap.y = HEIGHT / 2 - this.characterBitmap.height / 2 - 2;
        addChild(this.characterBitmap);
    }

    private function makeNameText():void {
        this.nameText = new SimpleText(22, this.getTextColor(), false, 0, 0);
        this.nameText.setBold(true);
        this.nameText.text = this.legend.name;
        this.nameText.useTextDimensions();
        this.nameText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.nameText.x = 170;
        this.nameText.y = HEIGHT / 2 - this.nameText.height / 2;
        addChild(this.nameText);
    }

    private function makeInventory():void {
        var interactiveItemTileIterator:InteractiveItemTile = null;
        this.inventoryGrid = new EquippedGrid(null, this.legend.equipmentSlots, null);
        var iterator:IIterator = this.inventoryGrid.createInteractiveItemTileIterator();
        while (iterator.hasNext()) {
            interactiveItemTileIterator = InteractiveItemTile(iterator.next());
            interactiveItemTileIterator.setInteractive(false);
        }
        this.inventoryGrid.setItems(this.legend.equipment, this.legend.equipment.length);
        this.inventoryGrid.x = 400;
        this.inventoryGrid.y = HEIGHT / 2 - Slot.HEIGHT / 2;
        addChild(this.inventoryGrid);
    }

    private function makeTotalHonor():void {
        this.totalHonorText = new SimpleText(22, this.getTextColor(), false, 0, 0);
        this.totalHonorText.setBold(true);
        this.totalHonorText.text = this.legend.totalHonor.toString();
        this.totalHonorText.useTextDimensions();
        this.totalHonorText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.totalHonorText.x = 660 - this.totalHonorText.width;
        this.totalHonorText.y = HEIGHT / 2 - this.totalHonorText.height / 2;
        addChild(this.totalHonorText);
    }

    private function makeHonorIcon():void {
        var honorBD:BitmapData = AssetLibrary.getImageFromSet("Currency_Icons16x16", 0);
        this.honorIcon = new Bitmap(TextureRedrawer.redraw(honorBD, 40, true, 0));
        this.honorIcon.x = 652;
        this.honorIcon.y = HEIGHT / 2 - this.honorIcon.height / 2;
        addChild(this.honorIcon);
    }

    private function getTextColor():uint {
        var textColor:uint;
        if (this.legend.isOwnLegend) {
            textColor = 16564761;
        } else if (this.legend.place == 1) {
            textColor = 16646031;
        } else {
            textColor = 16777215;
        }
        return textColor;
    }

    private function addMouseListeners():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
        addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
    }

    private function onMouseOver(event:MouseEvent):void {
        this.isOver = true;
        this.draw();
    }

    private function onRollOut(event:MouseEvent):void {
        this.isOver = false;
        this.draw();
    }

    private function onClick(event:MouseEvent):void {
        this.selected.dispatch(this.legend);
    }

    private function draw():void {
        graphics.clear();
        graphics.beginFill(0, this.isOver ? 0.4 : 0.001);
        graphics.drawRect(0, 0, WIDTH, HEIGHT);
        graphics.endFill();
    }
}
}
