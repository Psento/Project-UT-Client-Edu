package com.company.assembleegameclient.screens.charrects
{
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

import svera.untiered.assets.services.CharacterFactory;
import svera.untiered.classes.model.CharacterClass;
import svera.untiered.classes.model.CharacterSkin;
import svera.untiered.classes.model.ClassesModel;
import svera.untiered.core.StaticInjectorContext;
import svera.untiered.core.model.PlayerModel;

public class CharacterRectList extends Sprite
   {
      private var classes:ClassesModel;
      private var model:PlayerModel;
      private var assetFactory:CharacterFactory;
      public var newCharacter:Signal;
      public var buyCharacterSlot:Signal;
      
      public function CharacterRectList()
      {
         var savedChar:SavedCharacter = null;
         var buyRect:BuyCharacterRect = null;
         var charType:CharacterClass = null;
         var charStats:CharacterStats = null;
         var currCharBox:CurrentCharacterRect = null;
         var i:int = 0;
         var newCharRect:CreateNewCharacterRect = null;
         super();
         var injector:Injector = StaticInjectorContext.getInjector();
         this.classes = injector.getInstance(ClassesModel);
         this.model = injector.getInstance(PlayerModel);
         this.assetFactory = injector.getInstance(CharacterFactory);
         this.newCharacter = new Signal();
         this.buyCharacterSlot = new Signal();
         var charName:String = this.model.getName();
         var xOffset:int = 30;
         var savedChars:Vector.<SavedCharacter> = this.model.getSavedCharacters();
         for each(savedChar in savedChars)
         {
            charType = this.classes.getCharacterClass(savedChar.objectType());
            charStats = charType.getStats();
            currCharBox = new CurrentCharacterRect(charName,charType,savedChar,charStats);
            currCharBox.setIcon(this.getIcon(savedChar));
            currCharBox.x = xOffset;
            addChild(currCharBox);
            xOffset = xOffset + (CharacterRect.WIDTH + 30);
         }
         if(this.model.hasAvailableCharSlot())
         {
            var numCharSlots:int = this.model.getAvailableCharSlots();
            var numRows:int = Math.ceil(numCharSlots / 5);
            var rowHeight:int = CharacterRect.HEIGHT + 30; // assuming CharacterRect.HEIGHT includes any padding or margins
            var rowOffset:int = 0;
            for(i = 0; i < numCharSlots; i++)
            {
               if (i > 0 && i % 5 == 0) {
                  // move the xOffset down by the height of a row
                  xOffset = 0;
                  rowOffset += rowHeight;
               }
               newCharRect = new CreateNewCharacterRect(this.model);
               newCharRect.addEventListener(MouseEvent.MOUSE_DOWN,this.onNewChar);
               newCharRect.x = xOffset;
               newCharRect.y = rowOffset;
               addChild(newCharRect);
               xOffset = xOffset + (CharacterRect.WIDTH + 30);
            }
         }
         buyRect = new BuyCharacterRect(this.model);
         buyRect.addEventListener(MouseEvent.MOUSE_DOWN,this.onBuyCharSlot);
         buyRect.x = xOffset;
         addChild(buyRect);
      }
      
      private function getIcon(savedChar:SavedCharacter) : DisplayObject
      {
         var type:CharacterClass = this.classes.getCharacterClass(savedChar.objectType());
         var skin:CharacterSkin = type.skins.getSkin(savedChar.skinType()) || type.skins.getDefaultSkin();
         var data:BitmapData = this.assetFactory.makeIcon(skin.template,50,savedChar.tex1(),savedChar.tex2());
         return new Bitmap(data);
      }
      
      private function onNewChar(event:Event) : void
      {
         this.newCharacter.dispatch();
      }
      
      private function onBuyCharSlot(event:Event) : void
      {
         this.buyCharacterSlot.dispatch(Parameters.CHARACTER_SLOT_PRICE);
      }
   }
}
