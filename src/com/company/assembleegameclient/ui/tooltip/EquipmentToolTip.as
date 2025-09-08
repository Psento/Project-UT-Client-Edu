package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.ui.SimpleText;
import com.company.util.BitmapUtil;
import com.company.util.KeyCodes;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.DropShadowFilter;
import flash.text.StyleSheet;
import flash.utils.Dictionary;

import svera.untiered.itemdata.LinkUtils;
import svera.untiered.itemdata.ProjectileData;

import svera.untiered.constants.ActivationType;
import svera.untiered.itemdata.NewItemData;
import svera.untiered.messaging.impl.data.StatData;

public class EquipmentToolTip extends ToolTip {
    private static const MAX_WIDTH:int = 230;
    private static const CSS_TEXT:String = ".in { margin-left:10px; text-indent: -10px; }";

    private var icon_:Bitmap;
    private var titleText_:SimpleText;
    private var tierText:SimpleText;
    private var descText_:SimpleText;
    private var line1_:LineBreakDesign;
    private var effectsText_:SimpleText;
    private var line2_:LineBreakDesign;
    private var restrictionsText_:SimpleText;
    private var player_:Player;
    private var item:NewItemData;
    private var isEquippable_:Boolean = false;
    private var objectXML_:XML = null;
    private var playerCanUse:Boolean;
    private var restrictions:Vector.<Restriction>;
    private var effects:Vector.<Effect>;
    private var itemSlotTypeId:int;
    private var invType:int;
    private var inventoryOwnerType:String;
    private var inventorySlotID:uint;
    private var isInventoryFull:Boolean;
    private var yOffset:int;
    private var currItem:NewItemData;

    private var uuidText:SimpleText;
    private var dateText:SimpleText;


    public function EquipmentToolTip(itemData:NewItemData, player:Player, invType:int, inventoryOwnerType:String, inventorySlotID:uint = 1.0) {
        this.player_ = player;
        this.item = itemData;
        this.inventoryOwnerType = inventoryOwnerType;
        this.inventorySlotID = inventorySlotID;
        this.isInventoryFull = Boolean(player) ? Boolean(player.isInventoryFull()) : Boolean(false);
        this.playerCanUse = player != null ? Boolean(ObjectLibrary.isUsableByPlayer(itemData.BaseItem.ObjectType, player)) : Boolean(false);
        var backgroundColor:uint = this.playerCanUse || this.player_ == null ? 0x363636 : 6036765;
        var outlineColor:uint = this.playerCanUse || player == null ? 0x9B9B9B : 10965039;
        super(backgroundColor, 1, outlineColor, 1, true);
        this.objectXML_ = ObjectLibrary.xmlLibrary_[itemData.BaseItem.ObjectType];
        var equipSlotIndex:int = Boolean(this.player_) ? int(ObjectLibrary.getMatchingSlotIndex(this.item, this.player_)) : int(-1);
        this.isEquippable_ = equipSlotIndex != -1;
        this.effects = new Vector.<Effect>();
        this.invType = invType;
        this.itemSlotTypeId = item.BaseItem.SlotType;
        var slot:int = player ? ObjectLibrary.getMatchingSlotIndex(item, player) : -1;
        if (player_ == null) {
            this.currItem = item;
        } else if (slot != -1 && player_.equipment_[slot] != null) {
            this.currItem = player_.equipment_[slot];
        }

        this.addIcon();
        this.addTitle();
        this.addTierText();
        this.addDescriptionText();
        //this.addNumProjectilesTagsToEffectsList();
        //this.addProjectileTagsToEffectsList();
        //this.addActivateTagsToEffectsList();
        //this.addActivateOnEquipTagsToEffectsList();
        //this.addCooldownTagToEffectsList();
        //this.addDoseTagsToEffectsList();
        //this.addMpCostTagToEffectsList();
        //this.addHonorBonusTagToEffectsList();
        //this.makeEffectsList();
        //this.makeRestrictionList();
        //this.makeRestrictionText();
        this.addTestItemDataText();
    }

    private function addTestItemDataText():void {
        this.uuidText = new SimpleText(14, 11776947, false, MAX_WIDTH, 0);
        this.uuidText.wordWrap = true;
        this.uuidText.text = this.item.Uuid;
        this.uuidText.updateMetrics();
        this.uuidText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.uuidText.x = 4;
        this.uuidText.y = this.yOffset;
        this.yOffset = this.uuidText.y + this.uuidText.height + 8;
        addChild(this.uuidText);

        this.dateText = new SimpleText(14, 11776947, false, MAX_WIDTH, 0);
        this.dateText.wordWrap = true;
        this.dateText.text = this.item.CreationTime.toLocaleString();
        this.dateText.updateMetrics();
        this.dateText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.dateText.x = 4;
        this.dateText.y = this.yOffset;
        this.yOffset = this.dateText.y + this.dateText.height + 8;
        addChild(this.dateText);
    }


    private static function BuildRestrictionsHTML(restrictions:Vector.<Restriction>):String {
        var restriction:Restriction = null;
        var line:String = null;
        var html:String = "";
        var first:Boolean = true;
        for each(restriction in restrictions) {
            if (!first) {
                html = html + "\n";
            } else {
                first = false;
            }
            line = "<font color=\"#" + restriction.color_.toString(16) + "\">" + restriction.text_ + "</font>";
            if (restriction.bold_) {
                line = "<b>" + line + "</b>";
            }
            html = html + line;
        }
        return html;
    }

    private function addIcon():void {
        var scaleValue:int = item.BaseItem.Scale;
        var texture:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.item.BaseItem.ObjectType, 60, true, true, scaleValue);
        texture = BitmapUtil.cropToBitmapData(texture, 4, 4, texture.width - 8, texture.height - 8);
        this.icon_ = new Bitmap(texture);
        addChild(this.icon_);
    }

    private function addTierText():void {
        this.tierText = new SimpleText(16, 16777215, false, 30, 0);
        this.tierText.setBold(true);
        this.tierText.y = this.icon_.height / 2 - this.titleText_.actualHeight_ / 2;
        this.tierText.x = MAX_WIDTH - 30;
        if (!this.objectXML_.hasOwnProperty("Consumable") && !this.isPet()) {
            if (this.objectXML_.hasOwnProperty("Tier")) {
                this.tierText.text = "T" + this.objectXML_.Tier;

            }
            else if (objectXML_.hasOwnProperty("TierType")) {
                switch (objectXML_.TierType) {
                    case "Celestial":
                        tierText.setColor(TooltipHelper.CELESTIAL_COLOR);
                        tierText.text = "CL";
                        break;
                    case "Exiled":
                        tierText.setColor(TooltipHelper.EXILED_COLOR);
                        tierText.text = "EX";
                        break;
                    case "Relic":
                        tierText.setColor(TooltipHelper.RELIC_COLOR);
                        tierText.text = "R";
                        break;
                    case "Valiant":
                        tierText.setColor(TooltipHelper.VALIANT_COLOR);
                        tierText.text = "VL";
                        break;
                    case "Ancestral":
                        tierText.setColor(TooltipHelper.ANCESTRAL_COLOR);
                        tierText.text = "AN";
                        break;
                    case "Artifact":
                        tierText.setColor(TooltipHelper.ARTIFACT_COLOR);
                        tierText.text = "A";
                        break;
                    case "Tarnished":
                        tierText.setColor(TooltipHelper.TARNISHED_COLOR);
                        tierText.text = "T";
                        break;
                    case "Uncommon":
                        tierText.setColor(TooltipHelper.UNCOMMON_COLOR);
                        tierText.text = "UC";
                        break;
                    case "Stat":
                        tierText.setColor(16777215);
                        tierText.text = "S";
                        break;
                    case "Common":
                        tierText.setColor(TooltipHelper.COMMON_COLOR);
                        tierText.text = "C";
                        break;
                }
            }
            else {
                this.tierText.setColor(9055202);
                this.tierText.text = "UT";
            }
            this.tierText.updateMetrics();
            addChild(this.tierText);
        }
    }

    private function isPet():Boolean {
        var activateTags:XMLList = null;
        activateTags = this.objectXML_.Activate.(text() == "PermaPet");
        return activateTags.length() >= 1;
    }

    private function addTitle():void {
        //var prefix:String = ItemData.getPrefix(this.itemData_);
        var color:int = this.playerCanUse || this.player_ == null ? int(16777215) : int(16549442);

        this.titleText_ = new SimpleText(16, color, false, MAX_WIDTH - this.icon_.width - 4 - 30, 0);
        this.titleText_.setBold(true);
        this.titleText_.wordWrap = true;
        this.titleText_.text = ObjectLibrary.typeToDisplayId_[this.item.BaseItem.ObjectType];
        this.titleText_.updateMetrics();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.titleText_.x = this.icon_.width + 4;
        this.titleText_.y = this.icon_.height / 2 - this.titleText_.actualHeight_ / 2;

        addChild(this.titleText_);
    }

    private function buildUniqueTooltipData():String {
        var effectDataList:XMLList = null;
        var uniqueEffectList:Vector.<Effect> = null;
        var effectDataXML:XML = null;
        if (this.objectXML_.hasOwnProperty("ExtraTooltipData")) {
            effectDataList = this.objectXML_.ExtraTooltipData.EffectInfo;
            uniqueEffectList = new Vector.<Effect>();
            for each(effectDataXML in effectDataList) {
                uniqueEffectList.push(new Effect(effectDataXML.attribute("name"), effectDataXML.attribute("description")));
            }
            return this.BuildEffectsHTML(uniqueEffectList) + "\n";
        }
        return "";
    }

    private function makeEffectsList():void {
        this.yOffset = this.descText_.y + this.descText_.height + 8;
        if (this.effects.length != 0 || this.objectXML_.hasOwnProperty("ExtraTooltipData")) {
            this.line1_ = new LineBreakDesign(MAX_WIDTH - 12, 0);
            this.line1_.x = 8;
            this.line1_.y = this.yOffset;
            addChild(this.line1_);
            this.effectsText_ = new SimpleText(14, 11776947, false, MAX_WIDTH - this.icon_.width - 4, 0);
            this.effectsText_.wordWrap = true;
            this.effectsText_.htmlText = this.buildUniqueTooltipData() + this.BuildEffectsHTML(this.effects);
            this.effectsText_.useTextDimensions();
            this.effectsText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            this.effectsText_.x = 4;
            this.effectsText_.y = this.line1_.y + 8;
            addChild(this.effectsText_);
            this.yOffset = this.effectsText_.y + this.effectsText_.height + 8;
        }
    }

    private function addNumProjectilesTagsToEffectsList():void {
        if (item.BaseItem.NumProjectiles) {
            this.effects.push(new Effect("Shots", item.BaseItem.NumProjectiles.toString()));
        }
        if (item.BaseItem.NumProjectiles1) {
            this.effects.push(new Effect("Shots", item.BaseItem.NumProjectiles1.toString()));
        }
        if (item.BaseItem.NumProjectiles2) {
            this.effects.push(new Effect("Shots", item.BaseItem.NumProjectiles2.toString()));
        }
    }

    private function addHonorBonusTagToEffectsList():void {
        if (this.item.BaseItem.HonorBonus == 0) return;

        var color:uint = this.playerCanUse ? TooltipHelper.BETTER_COLOR : TooltipHelper.NO_DIFF_COLOR;
        if (this.currItem != null && this.currItem.BaseItem.HonorBonus != 0) {
            color = TooltipHelper.getTextColor(item.BaseItem.HonorBonus - currItem.BaseItem.HonorBonus);
        }
        this.effects.push(new Effect("Honor Bonus",  this.item.BaseItem.HonorBonus + "%"));

    }

    private function addMpCostTagToEffectsList():void {
        if (this.objectXML_.hasOwnProperty("MpCost")) {
            this.effects.push(new Effect("MP Cost", this.objectXML_.MpCost));
        }
    }

    private function addCooldownTagToEffectsList():void {
        if (this.item.BaseItem.Cooldown != 500) {
            this.effects.push(new Effect("Cooldown: {cd}", this.item.BaseItem.Cooldown / 1000 + " seconds"));
        }
    }

    private function addDoseTagsToEffectsList():void {
        if (item.BaseItem.Doses) {
            this.effects.push(new Effect("Doses", item.BaseItem.Doses.toString()));
        }
    }

    private function addProjectileTagsToEffectsList():void {
        var projXML:XML = null;
        var range:Number = NaN;
        var condEffectXML:XML = null;
        if (this.objectXML_.hasOwnProperty("Projectile")) {
            var proj:ProjectileData = this.item.BaseItem.Projectiles[0];
            var minDmg:int = proj.MinDamage;
            var maxDmg:int = proj.MaxDamage;
            var dmg:int = proj.Damage;
            var dmgString:String = dmg > 0 ? dmg.toString() : minDmg == maxDmg ? minDmg.toString() : minDmg + " - " + maxDmg;
            this.effects.push(new Effect("Damage", dmgString));

            range = Number(projXML.Speed) * Number(projXML.LifetimeMS) / 10000;
            this.effects.push(new Effect("Range", TooltipHelper.getFormattedString(range)));
            if (this.objectXML_.Projectile.hasOwnProperty("MultiHit")) {
                this.effects.push(new Effect("", "Shots hit multiple targets"));
            }
            if (this.objectXML_.Projectile.hasOwnProperty("PassesCover")) {
                this.effects.push(new Effect("", "Shots pass through obstacles"));
            }

            if (this.item.BaseItem.RateOfFire != 1.0) {
                this.effects.push(new Effect("Rate of Fire", Math.round(this.item.BaseItem.RateOfFire * 100) + "%"));
            }

            for each(condEffectXML in projXML.ConditionEffect) {
                this.effects.push(new Effect("Shot Effect", this.objectXML_.Projectile.ConditionEffect + " for " + this.objectXML_.Projectile.ConditionEffect.@duration + " secs"));
            }
        }
    }

    private function addActivateTagsToEffectsList():void {
        var activateXML:XML = null;
        var val:String = null;
        var stat:int = 0;
        var amt:int = 0;
        var activationType:String = null;
        for each(activateXML in this.objectXML_.Activate) {
            activationType = activateXML.toString();
            switch (activationType) {
                case ActivationType.DYE:
                    this.effects.push(new Effect("", "Changes texture of your character"));
                    continue;
                case ActivationType.COND_EFFECT_AURA:
                    this.effects.push(new Effect("Party Effect", "Within " + activateXML.@range + " sqrs"));
                    this.effects.push(new Effect("", activateXML.@effect + " for " + activateXML.@duration + " secs"));
                    continue;
                case ActivationType.COND_EFFECT_SELF:
                    this.effects.push(new Effect("Effect on Self", ""));
                    this.effects.push(new Effect("", activateXML.@effect + " for " + activateXML.@duration + " secs"));
                    continue;
                case ActivationType.HEAL:
                    this.effects.push(new Effect("", "+" + activateXML.@amount + " HP"));
                    continue;
                case ActivationType.HEAL_NOVA:
                    this.effects.push(new Effect("Party Heal", activateXML.@amount + " HP at " + activateXML.@range + " sqrs"));
                    continue;
                case ActivationType.MAGIC:
                    this.effects.push(new Effect("", "+" + activateXML.@amount + " RP"));
                    continue;
                case ActivationType.MAGIC_NOVA:
                    this.effects.push(new Effect("Fill Party Magic", activateXML.@amount + " RP at " + activateXML.@range + " sqrs"));
                    continue;
                case ActivationType.TELEPORT:
                    this.effects.push(new Effect("", "Teleport to Target"));
                    continue;
                case ActivationType.VAMPIRE_BLAST:
                    this.effects.push(new Effect("Steal", activateXML.@totalDamage + " HP within " + activateXML.@radius + " sqrs"));
                    continue;
                case ActivationType.TRAP:
                    this.effects.push(new Effect("Trap", activateXML.@totalDamage + " HP within " + activateXML.@radius + " sqrs"));
                    this.effects.push(new Effect("", activateXML.@effect + " for " + activateXML.@duration + " secs"));
                    continue;
                case ActivationType.STASIS_BLAST:
                    this.effects.push(new Effect("Stasis on Group", activateXML.@duration + " secs"));
                    continue;
                case ActivationType.DECOY:
                    this.effects.push(new Effect("Decoy", activateXML.@duration + " secs"));
                    continue;
                case ActivationType.LIGHTNING:
                    this.effects.push(new Effect("Lightning", ""));
                    this.effects.push(new Effect("", activateXML.@totalDamage + " to " + activateXML.@maxTargets + " targets"));
                    continue;
                case ActivationType.POISON_GRENADE:
                    this.effects.push(new Effect("Poison Grenade", ""));
                    this.effects.push(new Effect("", activateXML.@totalDamage + " HP over " + activateXML.@duration + " secs within " + activateXML.@radius + " sqrs"));
                    continue;
                case ActivationType.REMOVE_NEG_COND:
                    this.effects.push(new Effect("", "Removes negative conditions"));
                    continue;
                case ActivationType.REMOVE_NEG_COND_SELF:
                    this.effects.push(new Effect("", "Removes negative conditions"));
                    continue;
                case ActivationType.BULLET_NOVA:
                    this.effects.push(new Effect("Shots", "20"));
                    continue;
                case ActivationType.SHURIKEN:
                    this.effects.push(new Effect("Shots", activateXML.@amount));
                    this.effects.push(new Effect("", "Stars seek nearby enemies"));
                    this.effects.push(new Effect("", "Dazes nearby enemies"));
                    continue;
                case ActivationType.INCREMENT_STAT:
                    stat = int(activateXML.@stat);
                    amt = int(activateXML.@amount);
                    if (stat != 0 && stat != 1) {
                        val = "Permanently increases " + LinkUtils.statIndexToName(stat);
                    } else {
                        val = "+" + amt + " " + LinkUtils.statIndexToName(stat);
                    }
                    this.effects.push(new Effect("", val));
            }
        }
    }

    private function formatStringForPluralValue(amount:uint, string:String):String {
        if (amount > 1) {
            string = string + "s";
        }
        return string;
    }

    private function addActivateOnEquipTagsToEffectsList():void {
        var activateXML:XML = null;
        var stats:Dictionary = new Dictionary();
        var datas:Dictionary = new Dictionary();
        for each(activateXML in this.objectXML_.ActivateOnEquip) {
            var stat:int = int(activateXML.@stat);
            var amount:int = int(activateXML.@amount);

            if (stats[stat] == null) {
                stats[stat] = 0;
            }
            stats[stat] = stats[stat] + amount;
        }

        if (this.item) {

        }

        var isEmpty:Boolean = true;
        var s:Object;
        for each (s in stats) {
            if (s != null) {
                isEmpty = false;
                break;
            }
        }

        if (!isEmpty) {
            this.effects.push(new Effect("On Equip", ""));

            for (s in stats) {
                var key:int = int(s);
                var value:int = stats[s];
                var data:int = datas[key] == null ? 0 : datas[key];

                this.effects.push(new Effect("", this.addIncrementStatTag(key, value, data)));
            }
        }
    }

    private function addIncrementStatTag(stat:int, amount:int, data:int):String {
        var amountString:String = null;
        var dataString:String = null;
        var textColor:String = TooltipHelper.DEFAULT_COLOR;
        if (amount > -1) {
            amountString = String("+" + amount);
        } else {
            amountString = String(amount);
            textColor = "#ff0000";
        }

        if (data > 0) {
            dataString = " (+" + data + ")";
        } else {
            dataString = "";
        }

        return TooltipHelper.wrapInFontTag(amountString + dataString + " " + LinkUtils.statIndexToName(stat), textColor);
    }

    private function addEquipmentItemRestrictions():void {
        this.restrictions.push(new Restriction("Must be equipped to use", 11776947, false));
        if (this.isInventoryFull || this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER) {
            this.restrictions.push(new Restriction("Double-Click to equip", 11776947, false));
        } else {
            this.restrictions.push(new Restriction("Double-Click to take", 11776947, false));
        }
    }

    private function addAbilityItemRestrictions():void {
        this.restrictions.push(new Restriction("Press [" + KeyCodes.CharCodeStrings[Parameters.data_.ability1] + "] in world to use", 16777215, false));
        this.restrictions.push(new Restriction("Press [" + KeyCodes.CharCodeStrings[Parameters.data_.ability2] + "] in world to use", 16777215, false));
        this.restrictions.push(new Restriction("Press [" + KeyCodes.CharCodeStrings[Parameters.data_.ability3] + "] in world to use", 16777215, false));
    }

    private function addConsumableItemRestrictions():void {
        this.restrictions.push(new Restriction("Consumed with use", 11776947, false));
        if (this.isInventoryFull || this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER) {
            this.restrictions.push(new Restriction("Double-Click or Shift-Click on item to use", 16777215, false));
        } else {
            this.restrictions.push(new Restriction("Double-Click to take & Shift-Click to use", 16777215, false));
        }
    }

    private function addReusableItemRestrictions():void {
        this.restrictions.push(new Restriction("Can be used multiple times", 11776947, false));
        this.restrictions.push(new Restriction("Double-Click or Shift-Click on item to use", 16777215, false));
    }

    private function makeRestrictionList():void {
        var reqXML:XML = null;
        var reqMet:Boolean = false;
        var stat:int = 0;
        var value:int = 0;
        this.restrictions = new Vector.<Restriction>();
        if (this.objectXML_.hasOwnProperty("Soulbound")) {
            this.restrictions.push(new Restriction("Soulbound", 9055202, false));
        }
        if (this.playerCanUse) {
            if (this.objectXML_.hasOwnProperty("Usable")) {
                this.addAbilityItemRestrictions();
                this.addEquipmentItemRestrictions();
            } else if (this.objectXML_.hasOwnProperty("Consumable")) {
                this.addConsumableItemRestrictions();
            } else if (this.objectXML_.hasOwnProperty("InvUse")) {
                this.addReusableItemRestrictions();
            } else {
                this.addEquipmentItemRestrictions();
            }
        } else if (this.player_ != null) {
            this.restrictions.push(new Restriction("Not usable by " + ObjectLibrary.typeToDisplayId_[this.player_.objectType_], 16549442, true));
        }
        var usable:Vector.<String> = ObjectLibrary.usableBy(this.item.BaseItem.ObjectType);
        if (usable != null) {
            this.restrictions.push(new Restriction("Usable by: " + usable.join(", "), 11776947, false));
        }
        for each(reqXML in this.objectXML_.EquipRequirement) {
            reqMet = ObjectLibrary.playerMeetsRequirement(reqXML, this.player_);
            if (reqXML.toString() == "Stat") {
                stat = int(reqXML.@stat);
                value = int(reqXML.@value);
                this.restrictions.push(new Restriction("Requires " + LinkUtils.statIndexToName(stat) + " of " + value, reqMet ? 11776947 : 16549442, reqMet ? Boolean(false) : Boolean(true)));
            }
        }
    }

    private function makeRestrictionText():void {
        var sheet:StyleSheet = null;
        if (this.restrictions.length != 0) {
            this.line2_ = new LineBreakDesign(MAX_WIDTH - 12, 0);
            this.line2_.x = 8;
            this.line2_.y = this.yOffset;
            addChild(this.line2_);
            sheet = new StyleSheet();
            sheet.parseCSS(CSS_TEXT);
            this.restrictionsText_ = new SimpleText(14, 11776947, false, MAX_WIDTH - 4, 0);
            this.restrictionsText_.styleSheet = sheet;
            this.restrictionsText_.wordWrap = true;
            this.restrictionsText_.htmlText = "<span class=\'in\'>" + BuildRestrictionsHTML(this.restrictions) + "</span>";
            this.restrictionsText_.useTextDimensions();
            this.restrictionsText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            this.restrictionsText_.x = 4;
            this.restrictionsText_.y = this.line2_.y + 8;
            addChild(this.restrictionsText_);
        }
    }

    private function addDescriptionText():void {
        this.descText_ = new SimpleText(14, 11776947, false, MAX_WIDTH, 0);
        this.descText_.wordWrap = true;
        this.descText_.text = String(this.objectXML_.Description);
        this.descText_.updateMetrics();
        this.descText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.descText_.x = 4;
        this.descText_.y = this.icon_.height + 2;
        this.yOffset = this.descText_.y + this.descText_.height + 8;
        addChild(this.descText_);
    }

    private function BuildEffectsHTML(effects:Vector.<Effect>):String {
        var effect:Effect = null;
        var textColor:String = null;
        var html:String = "";
        var first:Boolean = true;
        for each(effect in effects) {
            textColor = "#FFFF8F";
            if (!first) {
                html = html + "\n";
            } else {
                first = false;
            }
            if (effect.name_ != "") {
                html = html + (effect.name_ + ": ");
            }
            html = html + ("<font color=\"" + textColor + "\">" + effect.value_ + "</font>");
        }
        return html;
    }
}
}

class Effect {


    public var name_:String;

    public var value_:String;

    function Effect(name:String, value:String) {
        super();
        this.name_ = name;
        this.value_ = value;
    }

}

class Restriction {


    public var text_:String;

    public var color_:uint;

    public var bold_:Boolean;

    function Restriction(text:String, color:uint, bold:Boolean) {
        super();
        this.text_ = text;
        this.color_ = color;
        this.bold_ = bold;
    }
}
