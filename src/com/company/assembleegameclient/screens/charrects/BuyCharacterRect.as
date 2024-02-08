package com.company.assembleegameclient.screens.charrects
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.ui.SimpleText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.filters.DropShadowFilter;

import svera.untiered.account.core.Account;

import svera.untiered.assets.services.IconFactory;
import svera.untiered.assets.services.IconFactory;
   import svera.untiered.core.model.PlayerModel;
   
   public class BuyCharacterRect extends CharacterRect
   {
      [Inject]
      public var model:PlayerModel;

      private var classNameText_:SimpleText;
      private var priceText_:SimpleText;
      private var currencyIcon_:Bitmap;
      
      public function BuyCharacterRect(model:PlayerModel)
      {
         super(2039583,4342338);
         var icon:Shape = this.buildIcon();
         icon.x = this.width / 2 - icon.width / 2;
         icon.y = this.height / 2 - icon.height / 2;
         addChild(icon);
         makeContainer();
         this.classNameText_ = new SimpleText(12,16777215,false,0,0);
         this.classNameText_.setBold(true);
         this.classNameText_.text = this.getOrdinalString(model.getMaxCharacters() + 1) + " Slot";
         this.classNameText_.updateMetrics();
         this.classNameText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.classNameText_.x = this.x + this.width / 2 - this.classNameText_.width / 2;
         this.classNameText_.y = this.y + this.height + this.classNameText_.height;
         selectContainer.addChild(this.classNameText_);
         var currencyBD_:BitmapData = IconFactory.makeFame();
         this.currencyIcon_ = new Bitmap(currencyBD_);
         this.currencyIcon_.scaleX = this.currencyIcon_.scaleX * 0.5;
         this.currencyIcon_.scaleY = this.currencyIcon_.scaleY * 0.5;
         this.currencyIcon_.x = this.x;
         this.currencyIcon_.y = this.y;
         selectContainer.addChild(this.currencyIcon_);
         var hasFunds:Boolean = model.getHonor() >= Parameters.CHARACTER_SLOT_PRICE;
         this.priceText_ = new SimpleText(14,!hasFunds?15607334:0x5ed44c,false,0,0);
         this.priceText_.text = Parameters.CHARACTER_SLOT_PRICE.toString();
         this.priceText_.updateMetrics();
         this.priceText_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         this.priceText_.x = this.width / 2 - this.priceText_.width / 2;
         this.priceText_.y = this.currencyIcon_.y - 2;
         selectContainer.addChild(this.priceText_);
      }
      
      private function buildIcon() : Shape
      {
         var shape:Shape = new Shape();
         var g:Graphics = shape.graphics;
         g.beginFill(3880246);
         g.lineStyle(1,4603457);
         g.drawCircle(19,19,19);
         g.lineStyle();
         g.endFill();
         g.beginFill(2039583);
         g.drawRect(11,17,16,4);
         g.endFill();
         g.beginFill(2039583);
         g.drawRect(17,11,4,16);
         g.endFill();
         return shape;
      }
      
      private function getOrdinalString(num:int) : String
      {
         var str:String = num.toString();
         var ones:int = num % 10;
         var tens:int = int(num / 10) % 10;
         if(tens == 1)
         {
            str = str + "th";
         }
         else if(ones == 1)
         {
            str = str + "st";
         }
         else if(ones == 2)
         {
            str = str + "nd";
         }
         else if(ones == 3)
         {
            str = str + "rd";
         }
         else
         {
            str = str + "th";
         }
         return str;
      }
   }
}
