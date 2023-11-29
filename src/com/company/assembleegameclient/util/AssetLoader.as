package com.company.assembleegameclient.util
{
   import com.company.assembleegameclient.engine3d.Model3D;
   import com.company.assembleegameclient.map.GroundLibrary;
   import com.company.assembleegameclient.map.RegionLibrary;
   import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Wall;
import com.company.assembleegameclient.objects.particles.ParticleLibrary;
   import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.Music;
import com.company.assembleegameclient.sound.SFX;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.options.Options;
import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;

import svera.untiered.assets.EmbeddedAssets;
   import svera.untiered.assets.EmbeddedData;
import svera.untiered.assets.Environment.Overworld.Assets_Overworld_Environment_DroughtsPath16x16;
import svera.untiered.assets.Environment.Overworld.Assets_Overworld_Environment_DroughtsPath8x8;
import svera.untiered.assets.Environment.Overworld.Assets_Overworld_Environment_Nidavellir16x16;
import svera.untiered.assets.Environment.Overworld.Assets_Overworld_Environment_Nidavellir8x8;

public class AssetLoader
   {
       
      
      public function AssetLoader()
      {
         super();
      }
      
      public function load() : void
      {
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
      
      private function addImages() : void
      {
         // Svera System
         // Particles
         AssetLibrary.addImageSet("Assets_Player_Particles", new EmbeddedAssets.Assets_Player_ParticlesEmbed_().bitmapData, 16, 16);
         // Icons
         AssetLibrary.addImageSet("Assets_Currency_Icons8x8", new EmbeddedAssets.Assets_Currency_Icons8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Currency_Icons16x16", new EmbeddedAssets.Assets_Currency_Icons16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_StatusIcons16x16", new EmbeddedAssets.Assets_StatusIcons16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_StatusIcons18x18", new EmbeddedAssets.Assets_StatusIcons18x18Embed_().bitmapData, 16, 16);
         // Environment
         AssetLibrary.addImageSet("Assets_Foundry_Environment8x8", new EmbeddedAssets.Assets_Foundry_Environment8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Foundry_Environment16x16", new EmbeddedAssets.Assets_Foundry_Environment16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_Foundry_Environment32x32", new EmbeddedAssets.Assets_Foundry_Environment32x32Embed_().bitmapData, 32, 32);
         AssetLibrary.addImageSet("Assets_Tavern_Environment8x8", new EmbeddedAssets.Assets_Tavern_Environment8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Vault_Environment8x8", new EmbeddedAssets.Assets_Vault_Environment8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Overworld_NotSpecific_Environment8x8",new EmbeddedAssets.Assets_Overworld_Environment_NotSpecific8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_FearedShallows8x8",new EmbeddedAssets.Assets_Overworld_Environment_FearedShallows8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_FearedShallows16x16",new EmbeddedAssets.Assets_Overworld_Environment_FearedShallows16x16Embed_().bitmapData,16,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_FearedShallows32x32",new EmbeddedAssets.Assets_Overworld_Environment_FearedShallows16x16Embed_().bitmapData,32,32);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_GarnetWoods8x8",new EmbeddedAssets.Assets_Overworld_Environment_GarnetWoods8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_GarnetWoods8x16",new EmbeddedAssets.Assets_Overworld_Environment_GarnetWoods8x16Embed_().bitmapData,8,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_GarnetWoods16x16",new EmbeddedAssets.Assets_Overworld_Environment_GarnetWoods16x16Embed_().bitmapData,16,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_GarnetWoods32x32",new EmbeddedAssets.Assets_Overworld_Environment_GarnetWoods32x32Embed_().bitmapData,32,32);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_SandstoneValley8x8",new EmbeddedAssets.Assets_Overworld_Environment_SandstoneValley8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_SandstoneValley16x8",new EmbeddedAssets.Assets_Overworld_Environment_SandstoneValley16x8Embed_().bitmapData,16,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_SandstoneValley16x16",new EmbeddedAssets.Assets_Overworld_Environment_SandstoneValley16x16Embed_().bitmapData,16,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_SandstoneValley32x32",new EmbeddedAssets.Assets_Overworld_Environment_SandstoneValley32x32Embed_().bitmapData,32,32);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_Feltare8x8",new EmbeddedAssets.Assets_Overworld_Environment_Feltare8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_Feltare16x16",new EmbeddedAssets.Assets_Overworld_Environment_Feltare16x16Embed_().bitmapData,16,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_Feltare32x32",new EmbeddedAssets.Assets_Overworld_Environment_Feltare32x32Embed_().bitmapData,32,32);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_AshenValley8x8",new EmbeddedAssets.Assets_Overworld_Environment_AshenValley8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_AshenValley16x16",new EmbeddedAssets.Assets_Overworld_Environment_AshenValley16x16Embed_().bitmapData,16,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_DroughtsPath8x8",new EmbeddedAssets.Assets_Overworld_Environment_DroughtsPath8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_DroughtsPath16x16",new EmbeddedAssets.Assets_Overworld_Environment_DroughtsPath16x16Embed_().bitmapData,16,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_Nidavellir8x8",new EmbeddedAssets.Assets_Overworld_Environment_Nidavellir8x8Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_Nidavellir16x8",new EmbeddedAssets.Assets_Overworld_Environment_Nidavellir16x8Embed_().bitmapData,8,16);
         AssetLibrary.addImageSet("Assets_Overworld_Environment_Nidavellir16x16",new EmbeddedAssets.Assets_Overworld_Environment_Nidavellir16x16Embed_().bitmapData,16,16);
         // Equipment
         AssetLibrary.addImageSet("Assets_StarterGear", new EmbeddedAssets.Assets_StarterGearEmbed_().bitmapData, 8, 8);

         AssetLibrary.addImageSet("Assets_ArtifactAbilities", new EmbeddedAssets.Assets_ArtifactAbilitiesEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ArtifactAbilityEntities", new EmbeddedAssets.Assets_ArtifactAbilityEntitiesEmbed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_ArtifactAbilityEntities16x16", new EmbeddedAssets.Assets_ArtifactAbilityEntities16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_ArtifactAbilityProjectiles", new EmbeddedAssets.Assets_ArtifactAbilityProjectilesEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ArtifactAccessories", new EmbeddedAssets.Assets_ArtifactAccessoriesEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ArtifactArmor", new EmbeddedAssets.Assets_ArtifactArmorEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ArtifactWeapons", new EmbeddedAssets.Assets_ArtifactWeaponsEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ArtifactWeaponsProjectiles", new EmbeddedAssets.Assets_ArtifactWeaponsProjectilesEmbed_().bitmapData, 8, 8);

         AssetLibrary.addImageSet("Assets_ValiantAbilities", new EmbeddedAssets.Assets_ValiantAbilitiesEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ValiantAbilityEntities16x16", new EmbeddedAssets.Assets_ValiantAbilityEntities16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_ValiantAbilityProjectiles", new EmbeddedAssets.Assets_ValiantAbilityProjectilesEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ValiantAccessories", new EmbeddedAssets.Assets_ValiantAccessoriesEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ValiantArmor", new EmbeddedAssets.Assets_ValiantArmorEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ValiantWeapons", new EmbeddedAssets.Assets_ValiantWeaponsEmbed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_ValiantWeaponsProjectiles", new EmbeddedAssets.Assets_ValiantWeaponsProjectilesEmbed_().bitmapData, 8, 8);
         // Crafting, Consumables, Ingredients
         AssetLibrary.addImageSet("Assets_Consumables_Maxing8x8", new EmbeddedAssets.Assets_Consumables_Maxing8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Consumables_Tokens8x8", new EmbeddedAssets.Assets_Consumables_Tokens8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Consumables_Upgrades8x8", new EmbeddedAssets.Assets_Consumables_Upgrades8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Utilities_Artifact8x8", new EmbeddedAssets.Assets_Utilities_Artifact8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Utilities_PetStones8x8", new EmbeddedAssets.Assets_Utilities_PetStones8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Utilities_Valiant8x8", new EmbeddedAssets.Assets_Utilities_Valiant8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Crafting_Capsules8x8", new EmbeddedAssets.Assets_Crafting_Capsules8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Crafting_Ingredients8x8", new EmbeddedAssets.Assets_Crafting_Ingredients8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Crafting_LuckyDips", new EmbeddedAssets.Assets_Crafting_LuckyDipsEmbed_().bitmapData, 8, 8);
         // Interactables
         AssetLibrary.addImageSet("Assets_DroppedContainers8x8", new EmbeddedAssets.Assets_DroppedContainers8x8Embed_().bitmapData, 8, 8);
         AssetLibrary.addImageSet("Assets_Foundry_Containers16x16", new EmbeddedAssets.Assets_Foundry_Containers16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_Foundry_Portals16x16", new EmbeddedAssets.Assets_Foundry_Portals16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_Foundry_Portals32x32", new EmbeddedAssets.Assets_Foundry_Portals32x32Embed_().bitmapData, 32, 32);
         AssetLibrary.addImageSet("Assets_Foundry_Stations16x16", new EmbeddedAssets.Assets_Foundry_Stations16x16Embed_().bitmapData, 16, 16);
         AssetLibrary.addImageSet("Assets_Foundry_Stations32x32", new EmbeddedAssets.Assets_Foundry_Stations32x32Embed_().bitmapData, 32, 32);
         AssetLibrary.addImageSet("Assets_Marketplace_Stations16x16", new EmbeddedAssets.Assets_Marketplace_Stations16x16Embed_().bitmapData, 16, 16);
         // Old System
         AssetLibrary.addImageSet("lofiInterface",new EmbeddedAssets.lofiInterfaceEmbed_().bitmapData,8,8);
         AssetLibrary.addImageSet("lofiInterfaceBig",new EmbeddedAssets.lofiInterfaceBigEmbed_().bitmapData,16,16);
         AssetLibrary.addImageSet("lofiInterface2",new EmbeddedAssets.lofiInterface2Embed_().bitmapData,8,8);
         AssetLibrary.addImageSet("lofiParts",new EmbeddedAssets.lofiPartsEmbed_().bitmapData,8,8);
         AssetLibrary.addImageSet("stars",new EmbeddedAssets.starsEmbed_().bitmapData,5,5);
         AssetLibrary.addImageSet("textile4x4",new EmbeddedAssets.textile4x4Embed_().bitmapData,4,4);
         AssetLibrary.addImageSet("textile5x5",new EmbeddedAssets.textile5x5Embed_().bitmapData,5,5);
         AssetLibrary.addImageSet("textile8x8",new EmbeddedAssets.textile8x8Embed_().bitmapData,8,9);
         AssetLibrary.addImageSet("textile9x9",new EmbeddedAssets.textile9x9Embed_().bitmapData,9,9);
         AssetLibrary.addImageSet("textile10x10",new EmbeddedAssets.textile10x10Embed_().bitmapData,10,10);
         AssetLibrary.addImageSet("inner_mask",new EmbeddedAssets.innerMaskEmbed_().bitmapData,4,4);
         AssetLibrary.addImageSet("sides_mask",new EmbeddedAssets.sidesMaskEmbed_().bitmapData,4,4);
         AssetLibrary.addImageSet("outer_mask",new EmbeddedAssets.outerMaskEmbed_().bitmapData,4,4);
         AssetLibrary.addImageSet("innerP1_mask",new EmbeddedAssets.innerP1MaskEmbed_().bitmapData,4,4);
         AssetLibrary.addImageSet("innerP2_mask",new EmbeddedAssets.innerP2MaskEmbed_().bitmapData,4,4);
         AssetLibrary.addImageSet("invisible",new BitmapData(8,8,true,0),8,8);
         AssetLibrary.addImageSet("cursorsEmbed", new EmbeddedAssets.cursorsEmbed_().bitmapData, 32, 32);
      }
      
      private function addAnimatedCharacters() : void
      {
         AnimatedChars.add("players",new EmbeddedAssets.players().bitmapData,new EmbeddedAssets.playersMask().bitmapData,16,16,112,48,AnimatedChar.RIGHT);
         AnimatedChars.add("playerskins",new EmbeddedAssets.playersSkinsEmbed_().bitmapData,new EmbeddedAssets.playersSkinsMaskEmbed_().bitmapData,8,8,56,24,AnimatedChar.RIGHT);
         AnimatedChars.add("Assets_Pets16x16",new EmbeddedAssets.Assets_Pets16x16Embed_().bitmapData,null,16,16,112,304,AnimatedChar.DOWN);
      }
      
      private function addSoundEffects() : void
      {
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
      
      private function parse3DModels() : void
      {
         var name:* = null;
         var ba:ByteArray = null;
         var model:String = null;
         for(name in EmbeddedAssets.models_)
         {
            ba = EmbeddedAssets.models_[name];
            model = ba.readUTFBytes(ba.length);
            Model3D.parse3DOBJ(name, ba);
            Model3D.parseFromOBJ(name, model);
         }
      }
      
      private function parseParticleEffects() : void
      {
         var xml:XML = XML(new EmbeddedAssets.particlesEmbed());
         ParticleLibrary.parseFromXML(xml);
      }
      
      private function parseGroundFiles() : void
      {
         var groundObj:* = undefined;
         for each(groundObj in EmbeddedData.groundFiles)
         {
            GroundLibrary.parseFromXML(XML(groundObj));
         }
      }
      
      private function parseObjectFiles() : void
      {
         var objectObj:* = undefined;
         for each(objectObj in EmbeddedData.objectFiles)
         {
            ObjectLibrary.parseFromXML(XML(objectObj));
         }
      }
      
      private function parseRegionFiles() : void
      {
         var regionXML:* = undefined;
         for each(regionXML in EmbeddedData.regionFiles)
         {
            RegionLibrary.parseFromXML(XML(regionXML));
         }
      }
   }
}
