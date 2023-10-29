package svera.untiered.legends.model
{
   import com.company.util.ConversionUtil;
   import svera.untiered.assets.services.CharacterFactory;
   import svera.untiered.classes.model.CharacterClass;
   import svera.untiered.classes.model.CharacterSkin;
   import svera.untiered.classes.model.ClassesModel;
   import svera.untiered.core.model.PlayerModel;
   
   public class LegendFactory
   {
       
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var classesModel:ClassesModel;
      
      [Inject]
      public var factory:CharacterFactory;
      
      private var ownAccountId:int;
      
      private var legends:Vector.<Legend>;
      
      public function LegendFactory()
      {
         super();
      }
      
      public function makeLegends(xml:XML) : Vector.<Legend>
      {
         this.ownAccountId = this.playerModel.getAccountId();
         this.legends = new Vector.<Legend>(0);
         this.makeLegendsFromList(xml.FameListElem,false);
         //this.makeLegendsFromList(xml.MyFameListElem,true);
         return this.legends;
      }
      
      private function makeLegendsFromList(list:XMLList, isFocus:Boolean) : void
      {
         var node:XML = null;
         var legend:Legend = null;
         for each(node in list)
         {
            if(!this.legendsContains(node))
            {
               legend = this.makeLegend(node);
               legend.isOwnLegend = node.@accountId == this.ownAccountId;
               legend.isFocus = isFocus;
               this.legends.push(legend);
            }
         }
      }
      
      private function legendsContains(node:XML) : Boolean
      {
         var legend:Legend = null;
         for each(legend in this.legends)
         {
            if(legend.accountId == node.@accountId && legend.charId == node.@charId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function makeLegend(xml:XML) : Legend
      {
         var type:int = xml.ObjectType;
         var skinType:int = xml.Texture;
         var character:CharacterClass = this.classesModel.getCharacterClass(type);
         var skin:CharacterSkin = character.skins.getSkin(skinType);
         var texture1:int = Boolean(xml.hasOwnProperty("Tex1"))?int(xml.Tex1):int(0);
         var texture2:int = Boolean(xml.hasOwnProperty("Tex2"))?int(xml.Tex2):int(0);
         var legend:Legend = new Legend();
         legend.accountId = xml.@accountId;
         legend.charId = xml.@charId;
         legend.name = xml.Name;
         legend.totalFame = xml.TotalFame;
         legend.character = this.factory.makeIcon(skin.template,100,texture1,texture2);
         legend.equipmentSlots = character.slotTypes;
         legend.equipment = ConversionUtil.toIntVector(xml.Equipment);
         legend.itemDatas = ConversionUtil.toIntVector(xml.ItemDatas);
         return legend;
      }
   }
}
