package com.company.assembleegameclient.util {
import com.company.assembleegameclient.engine3d.Model3D;
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.particles.ParticleLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.options.Options;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.utils.ByteArray;

import svera.untiered.assets.EmbeddedAssets;
import svera.untiered.assets.EmbeddedData;

public class AssetLoader {


    public function AssetLoader() {
        super();
    }

    public function load():void {
        this.addImages();
        this.addAnimatedCharacters();
        this.addSoundEffects();
        this.parse3DModels();
        this.parseParticleEffects();
        this.parseGroundFiles();
        this.parseObjectFiles();
        this.parseRegionFiles();
        Parameters.load();
        Options.refreshCursor();
    }

    private function addImages():void {
        // Svera System
        // Particles
        AssetLibrary.addImageSet("Player_Particles", new EmbeddedAssets.Player_Particles().bitmapData, 16, 16);
        // Icons
        AssetLibrary.addImageSet("Currency_Icons8x8", new EmbeddedAssets.Currency_Icons8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Currency_Icons16x16", new EmbeddedAssets.Currency_Icons16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("StatusIcons16x16", new EmbeddedAssets.StatusIcons16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("StatusIcons18x18", new EmbeddedAssets.StatusIcons18x18().bitmapData, 16, 16);
        // Environment
        AssetLibrary.addImageSet("cobj16x16", new EmbeddedAssets.customobjects16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Foundry_Environment8x8", new EmbeddedAssets.Foundry_Environment8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Foundry_Environment16x16", new EmbeddedAssets.Foundry_Environment16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Foundry_Environment32x32", new EmbeddedAssets.Foundry_Environment32x32().bitmapData, 32, 32);
        AssetLibrary.addImageSet("Tavern_Environment8x8", new EmbeddedAssets.Tavern_Environment8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Vault_Environment8x8", new EmbeddedAssets.Vault_Environment8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_NotSpecific8x8", new EmbeddedAssets.Overworld_Environment_NotSpecific8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_FearedShallows8x8", new EmbeddedAssets.Overworld_Environment_FearedShallows8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_FearedShallows16x16", new EmbeddedAssets.Overworld_Environment_FearedShallows16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Overworld_Environment_FearedShallows32x32", new EmbeddedAssets.Overworld_Environment_FearedShallows16x16().bitmapData, 32, 32);
        AssetLibrary.addImageSet("Overworld_Environment_GarnetWoods8x8", new EmbeddedAssets.Overworld_Environment_GarnetWoods8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_GarnetWoods8x16", new EmbeddedAssets.Overworld_Environment_GarnetWoods8x16().bitmapData, 8, 16);
        AssetLibrary.addImageSet("Overworld_Environment_GarnetWoods16x16", new EmbeddedAssets.Overworld_Environment_GarnetWoods16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Overworld_Environment_GarnetWoods32x32", new EmbeddedAssets.Overworld_Environment_GarnetWoods32x32().bitmapData, 32, 32);
        AssetLibrary.addImageSet("Overworld_Environment_SandstoneValley8x8", new EmbeddedAssets.Overworld_Environment_SandstoneValley8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_SandstoneValley16x8", new EmbeddedAssets.Overworld_Environment_SandstoneValley16x8().bitmapData, 16, 8);
        AssetLibrary.addImageSet("Overworld_Environment_SandstoneValley16x16", new EmbeddedAssets.Overworld_Environment_SandstoneValley16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Overworld_Environment_SandstoneValley32x32", new EmbeddedAssets.Overworld_Environment_SandstoneValley32x32().bitmapData, 32, 32);
        AssetLibrary.addImageSet("Overworld_Environment_Feltare8x8", new EmbeddedAssets.Overworld_Environment_Feltare8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_Feltare16x16", new EmbeddedAssets.Overworld_Environment_Feltare16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Overworld_Environment_Feltare32x32", new EmbeddedAssets.Overworld_Environment_Feltare32x32().bitmapData, 32, 32);
        AssetLibrary.addImageSet("Overworld_Environment_AshenValley8x8", new EmbeddedAssets.Overworld_Environment_AshenValley8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_AshenValley16x16", new EmbeddedAssets.Overworld_Environment_AshenValley16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Overworld_Environment_DroughtsPath8x8", new EmbeddedAssets.Overworld_Environment_DroughtsPath8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_DroughtsPath16x16", new EmbeddedAssets.Overworld_Environment_DroughtsPath16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Overworld_Environment_Nidavellir8x8", new EmbeddedAssets.Overworld_Environment_Nidavellir8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Overworld_Environment_Nidavellir16x8", new EmbeddedAssets.Overworld_Environment_Nidavellir16x8().bitmapData, 8, 16);
        AssetLibrary.addImageSet("Overworld_Environment_Nidavellir16x16", new EmbeddedAssets.Overworld_Environment_Nidavellir16x16().bitmapData, 16, 16);
        // Equipment
        AssetLibrary.addImageSet("lofiGodSlayerAccessories", new EmbeddedAssets.GodSlayerAccessories().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodSlayerArmor", new EmbeddedAssets.GodSlayerArmor().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodSlayerAbilities", new EmbeddedAssets.GodSlayerAbilities().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodSlayerProjectiles", new EmbeddedAssets.GodSlayerProjectiles().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodSlayerWeapons", new EmbeddedAssets.GodSlayerWeapons().bitmapData, 8, 8);

        AssetLibrary.addImageSet("lofiGodlyAccessories", new EmbeddedAssets.GodlyAccessories().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodlyArmor", new EmbeddedAssets.GodlyArmor().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodlyAbilities", new EmbeddedAssets.GodlyAbilities().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodlyProjectiles", new EmbeddedAssets.GodlyProjectiles().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodlyWeapons", new EmbeddedAssets.GodlyWeapons().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiGodlyMiscellaneous", new EmbeddedAssets.GodlyMiscellaneous().bitmapData, 8, 8);

        AssetLibrary.addImageSet("lofiLegendaryAccessories", new EmbeddedAssets.LegendaryAccessories().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiLegendaryArmor", new EmbeddedAssets.LegendaryArmor().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiLegendaryAbilities", new EmbeddedAssets.LegendaryAbilities().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiLegendaryProjectiles", new EmbeddedAssets.LegendaryProjectiles().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiLegendaryWeapons", new EmbeddedAssets.LegendaryWeapons().bitmapData, 8, 8);

        AssetLibrary.addImageSet("lofiSacredAccessories", new EmbeddedAssets.SacredAccessories().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiSacredArmor", new EmbeddedAssets.SacredArmor().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiSacredAbilities", new EmbeddedAssets.SacredAbilities().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiSacredProjectiles", new EmbeddedAssets.SacredProjectiles().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiSacredWeapons", new EmbeddedAssets.SacredWeapons().bitmapData, 8, 8);

        AssetLibrary.addImageSet("StarterGear", new EmbeddedAssets.StarterGear().bitmapData, 8, 8);

        AssetLibrary.addImageSet("ArtifactAbilities", new EmbeddedAssets.ArtifactAbilities().bitmapData, 8, 8);

        AssetLibrary.addImageSet("ArtifactAbilityEntities", new EmbeddedAssets.ArtifactAbilityEntities().bitmapData, 16, 16);
        AssetLibrary.addImageSet("ArtifactAbilityEntities16x16", new EmbeddedAssets.ArtifactAbilityEntities16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("ArtifactAbilityProjectiles", new EmbeddedAssets.ArtifactAbilityProjectiles().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ArtifactAccessories", new EmbeddedAssets.ArtifactAccessories().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ArtifactArmor", new EmbeddedAssets.ArtifactArmor().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ArtifactWeapons", new EmbeddedAssets.ArtifactWeapons().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ArtifactWeaponsProjectiles", new EmbeddedAssets.ArtifactWeaponsProjectiles().bitmapData, 8, 8);

        AssetLibrary.addImageSet("ValiantAbilities", new EmbeddedAssets.ValiantAbilities().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ValiantAbilityEntities16x16", new EmbeddedAssets.ValiantAbilityEntities16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("ValiantAbilityProjectiles", new EmbeddedAssets.ValiantAbilityProjectiles().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ValiantAccessories", new EmbeddedAssets.ValiantAccessories().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ValiantArmor", new EmbeddedAssets.ValiantArmor().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ValiantWeapons", new EmbeddedAssets.ValiantWeapons().bitmapData, 8, 8);
        AssetLibrary.addImageSet("ValiantWeaponsProjectiles", new EmbeddedAssets.ValiantWeaponsProjectiles().bitmapData, 8, 8);
        // Crafting, Consumables, Ingredients
        AssetLibrary.addImageSet("Consumables_Maxing8x8", new EmbeddedAssets.Consumables_Maxing8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Consumables_Tokens8x8", new EmbeddedAssets.Consumables_Tokens8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Consumables_Upgrades8x8", new EmbeddedAssets.Consumables_Upgrades8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Utilities_Artifact8x8", new EmbeddedAssets.Utilities_Artifact8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Utilities_PetStones8x8", new EmbeddedAssets.Utilities_PetStones8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Utilities_Valiant8x8", new EmbeddedAssets.Utilities_Valiant8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Crafting_Capsules8x8", new EmbeddedAssets.Crafting_Capsules8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Crafting_Ingredients8x8", new EmbeddedAssets.Crafting_Ingredients8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Crafting_LuckyDips", new EmbeddedAssets.Crafting_LuckyDips().bitmapData, 8, 8);
        // Interactables
        AssetLibrary.addImageSet("DroppedContainers8x8", new EmbeddedAssets.DroppedContainers8x8().bitmapData, 8, 8);
        AssetLibrary.addImageSet("Foundry_Containers16x16", new EmbeddedAssets.Foundry_Containers16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Foundry_Portals16x16", new EmbeddedAssets.Foundry_Portals16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Foundry_Portals32x32", new EmbeddedAssets.Foundry_Portals32x32().bitmapData, 32, 32);
        AssetLibrary.addImageSet("Foundry_Stations16x16", new EmbeddedAssets.Foundry_Stations16x16().bitmapData, 16, 16);
        AssetLibrary.addImageSet("Foundry_Stations32x32", new EmbeddedAssets.Foundry_Stations32x32().bitmapData, 32, 32);
        AssetLibrary.addImageSet("Marketplace_Stations16x16", new EmbeddedAssets.Marketplace_Stations16x16().bitmapData, 16, 16);
        // Textiles
        AssetLibrary.addImageSet("Textiles8x8", new EmbeddedAssets.Textiles8x8().bitmapData, 8, 8);
        // Old System
        AssetLibrary.addImageSet("lofiInterface", new EmbeddedAssets.lofiInterface().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiInterfaceBig", new EmbeddedAssets.lofiInterfaceBig().bitmapData, 16, 16);
        AssetLibrary.addImageSet("lofiInterface2", new EmbeddedAssets.lofiInterface2().bitmapData, 8, 8);
        AssetLibrary.addImageSet("lofiParts", new EmbeddedAssets.lofiParts().bitmapData, 8, 8);
        AssetLibrary.addImageSet("stars", new EmbeddedAssets.stars().bitmapData, 5, 5);
        AssetLibrary.addImageSet("textile4x4", new EmbeddedAssets.textile4x4().bitmapData, 4, 4);
        AssetLibrary.addImageSet("textile5x5", new EmbeddedAssets.textile5x5().bitmapData, 5, 5);
        AssetLibrary.addImageSet("textile9x9", new EmbeddedAssets.textile9x9().bitmapData, 9, 9);
        AssetLibrary.addImageSet("textile10x10", new EmbeddedAssets.textile10x10().bitmapData, 10, 10);
        AssetLibrary.addImageSet("inner_mask", new EmbeddedAssets.innerMask().bitmapData, 4, 4);
        AssetLibrary.addImageSet("sides_mask", new EmbeddedAssets.sidesMask().bitmapData, 4, 4);
        AssetLibrary.addImageSet("outer_mask", new EmbeddedAssets.outerMask().bitmapData, 4, 4);
        AssetLibrary.addImageSet("innerP1_mask", new EmbeddedAssets.innerP1Mask().bitmapData, 4, 4);
        AssetLibrary.addImageSet("innerP2_mask", new EmbeddedAssets.innerP2Mask().bitmapData, 4, 4);
        AssetLibrary.addImageSet("invisible", new BitmapData(8, 8, true, 0), 8, 8);
        AssetLibrary.addImageSet("cursorsEmbed", new EmbeddedAssets.cursors().bitmapData, 32, 32);
    }

    private function addAnimatedCharacters():void {
        AnimatedChars.add("players", new EmbeddedAssets.Players().bitmapData, new EmbeddedAssets.playersMask().bitmapData, 16, 16, 112, 48, AnimatedChar.RIGHT);
        AnimatedChars.add("playerskins", new EmbeddedAssets.playersSkins().bitmapData, new EmbeddedAssets.playersSkinsMask().bitmapData, 8, 8, 56, 24, AnimatedChar.RIGHT);
        AnimatedChars.add("Pets16x16", new EmbeddedAssets.Pets16x16().bitmapData, null, 16, 16, 112, 16, AnimatedChar.DOWN);
        AnimatedChars.add("ValiantAbilityCharacters", new EmbeddedAssets.ValiantAbilityCharacters().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
        AnimatedChars.add("ArtifactAbilityCharacters8x8", new EmbeddedAssets.ArtifactAbilityCharacters8x8().bitmapData, null, 8, 8, 56, 8, AnimatedChar.RIGHT);
        AnimatedChars.add("ArtifactAbilityCharacters16x16", new EmbeddedAssets.ArtifactAbilityCharacters16x16().bitmapData, null, 16, 16, 112, 16, AnimatedChar.RIGHT);
    }

    private function addSoundEffects():void {
        SoundEffectLibrary.load("button_click");
        SoundEffectLibrary.load("enter_realm");
        SoundEffectLibrary.load("error");
        SoundEffectLibrary.load("inventory_move_item");
        SoundEffectLibrary.load("level_up");
        SoundEffectLibrary.load("loot_appears");
        SoundEffectLibrary.load("no_mana");
        SoundEffectLibrary.load("use_key");
        SoundEffectLibrary.load("use_potion");
    }

    private function parse3DModels():void {
        var name:* = null;
        var ba:ByteArray = null;
        var model:String = null;
        for (name in EmbeddedAssets.models_) {
            ba = EmbeddedAssets.models_[name];
            model = ba.readUTFBytes(ba.length);
            Model3D.parse3DOBJ(name, ba);
            Model3D.parseFromOBJ(name, model);
        }
    }

    private function parseParticleEffects():void {
        var xml:XML = XML(new EmbeddedAssets.particles());
        ParticleLibrary.parseFromXML(xml);
    }

    private function parseGroundFiles():void {
        var groundObj:* = undefined;
        for each(groundObj in EmbeddedData.groundFiles) {
            GroundLibrary.parseFromXML(XML(groundObj));
        }
    }

    private function parseObjectFiles():void {
        var objectObj:* = undefined;
        for each(objectObj in EmbeddedData.objectFiles) {
            ObjectLibrary.parseFromXML(XML(objectObj));
        }
    }

    private function parseRegionFiles():void {
        var regionXML:* = undefined;
        for each(regionXML in EmbeddedData.regionFiles) {
            RegionLibrary.parseFromXML(XML(regionXML));
        }
    }
}
}
