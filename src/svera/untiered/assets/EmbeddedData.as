package svera.untiered.assets
{
   public class EmbeddedData
   {
      // Svera System
      private static const Environment_Ground:Class = XML_Environment_Ground;
      private static const Environment_Objects:Class = XML_Environment_Objects;
      // Old System
      public static const PlayersCXML:Class = XML_Players;
      public static const groundFiles:Array = [new Environment_Ground()];
      private static const SkinsCXML:Class = EmbeddedData_SkinsCXML;
      private static const DyesCXML:Class = EmbeddedData_DyesCXML;
      private static const TextilesCXML:Class = EmbeddedData_TextilesCXML;
      private static const TutorialObjectsCXML:Class = EmbeddedData_TutorialObjectsCXML;

      public static const skinsXML:XML = XML(new SkinsCXML());
      public static const objectFiles:Array = [new Environment_Objects(),new DyesCXML(),new TextilesCXML(),new PlayersCXML(),new TutorialObjectsCXML()];
      private static const RegionsCXML:Class = EmbeddedData_RegionsCXML;
      public static const regionFiles:Array = [new RegionsCXML()];
      private static const TutorialScriptCXML:Class = EmbeddedData_TutorialScriptCXML;
      public static const tutorialXML:XML = XML(new TutorialScriptCXML());
       
      
      public function EmbeddedData()
      {
         super();
      }
   }
}
