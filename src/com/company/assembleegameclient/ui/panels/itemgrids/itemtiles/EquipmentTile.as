package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.util.AssetLibrary;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.ColorMatrixFilter;

import svera.untiered.constants.ItemConstants;

public class EquipmentTile extends InteractiveItemTile {

    private static const greyColorFilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(3552822));


    public var backgroundDetail:Bitmap;

    public var itemType:int;

    private var minResourceUsage:int;

    public function EquipmentTile(id:int, parentGrid:ItemGrid, isInteractive:Boolean) {
        super(id, parentGrid, isInteractive);
    }

    override public function canHoldItem(type:int):Boolean {
        return type <= 0 || this.itemType == ObjectLibrary.getSlotTypeFromType(type);
    }

    public function setType(itemType_:int):void {
        var bd:BitmapData = null;
        var dx:int = 0;
        var dy:int = 0;
        switch (itemType_) {
            case ItemConstants.ALL_TYPE:
                break;
            case ItemConstants.SWORD_AXE_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x42);
                break;
            case ItemConstants.DAGGER_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x04);
                break;
            case ItemConstants.BOW_CROSSBOW_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x91);
                break;
            case ItemConstants.MACE_LANCE_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x05);
                break;
            case ItemConstants.SHIELD_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x19);
                break;
            case ItemConstants.LEATHER_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0xae);
                break;
            case ItemConstants.PLATE_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0xaf);
                break;
            case ItemConstants.STAFF_WAND_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x61);
                break;
            case ItemConstants.RING_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x9f);
                break;
            case ItemConstants.SPELL_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x28);
                break;
            case ItemConstants.SEAL_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x1b);
                break;
            case ItemConstants.CLOAK_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x0a);
                break;
            case ItemConstants.ROBE_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0xad);
                break;
            case ItemConstants.GUN_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x90);
                break;
            case ItemConstants.HELM_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x18);
                break;
            case ItemConstants.CLAWS_GAUNTLET_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0);
                break;
            case ItemConstants.POISON_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x0c);
                break;
            case ItemConstants.SKULL_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x2a);
                break;
            case ItemConstants.TRAP_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x39);
                break;
            case ItemConstants.DUAL_WIELD_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 2);
                break;
            case ItemConstants.PRISM_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x0b);
                break;
            case ItemConstants.SCEPTER_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x3c);
                break;
            case ItemConstants.KATANA_SCYTHE_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x06);
                break;
            case ItemConstants.CHAKRAM_TYPE:
                bd = AssetLibrary.getImageFromSet("StarterGear", 0x1d);
                break;
        }
        if (bd != null) {
            this.backgroundDetail = new Bitmap(bd);
            this.backgroundDetail.x = BORDER;
            this.backgroundDetail.y = BORDER;
            this.backgroundDetail.scaleX = 4;
            this.backgroundDetail.scaleY = 4;
            this.backgroundDetail.filters = [greyColorFilter];
            addChildAt(this.backgroundDetail, 0);
        }
        this.itemType = itemType_;
    }

    override public function setItem(itemId:int, itemData:int):Boolean {
        var itemChanged:Boolean = super.setItem(itemId, itemData);
        if (itemChanged) {
            backgroundDetail && (backgroundDetail.visible = itemSprite.itemId <= 0);
            this.updateMinMana();
        }
        return itemChanged;
    }

    private function updateMinMana():void {
        var itemDataXML:XML = null;
        if (itemSprite.itemId > 0) {
            itemDataXML = ObjectLibrary.xmlLibrary_[itemSprite.itemId];
            if (itemDataXML && itemDataXML.hasOwnProperty("Usable")) {
                if (itemDataXML.hasOwnProperty("MultiPhase")) {
                    this.minResourceUsage = itemDataXML.rpEndCost;
                } else {
                    this.minResourceUsage = itemDataXML.rpCost;
                }
            } else {
                this.minResourceUsage = 0;
            }
        } else {
            this.minResourceUsage = 0;
        }
    }

    public function updateDim(player:Player):void {
        itemSprite.setDim(player && player.rp_ < this.minResourceUsage);
    }

    override protected function beginDragCallback():void {
        this.backgroundDetail.visible = true;
    }

    override protected function endDragCallback():void {
        this.backgroundDetail.visible = itemSprite.itemId <= 0;
    }

    override protected function getBackgroundColor():int {
        return 0x131126;
    }
}
}
