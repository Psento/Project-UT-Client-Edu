package svera.untiered.itemdata {

public class ActivateEffectsData {

    public var idx:int;
    public var Effect:String;

    public var ObjectId:String;
    public var Id:String;
    public var DungeonName:String;
    public var LockedName:String;
    public var SkinType:int;
    public var SkinType2:int;
    public var Size:int;
    public var CurrencyType:String;
    public var Gifts:Array;
    public var PetType:int;
    public var Chance:int;
    public var Explode:Boolean;

    public var Stats:int;
    public var Stats2:int;
    public var Stats3:int;
    public var Amount:int;
    public var Amount2:int;
    public var Amount3:int;
    public var Range:Number;
    public var IsPerc:Boolean;
    public var DurationMS:int;
    public var DurationSec:Number;
    public var ConditionEffect:String;
    public var CheckExistingEffect:String;
    public var EffectDuration:Number;
    public var Radius:Number;
    public var TotalDamage:int;
    public var ImpactDamage:int;
    public var ThrowTime:int;
    public var AngleOffset:int;
    public var MaxTargets:int;
    public var Color:int;
    public var NoStack:Boolean;
    public var UseWisMod:Boolean;
    public var UseWisMod2:Boolean;
    public var UseVitMod:Boolean;
    public var UseAtkMod:Boolean;
    public var Target:String;
    public var Center:String;
    public var VisualEffect:int;
    public var Players:Boolean;
    public var RandVals:Array;
    public var ObjType:int;
    public var NumShots:int;
    public var Stat:int;

    public function ActivateEffectsData(idx:int) {
        this.idx = idx;
    }

    public static function parseFromXml(xml:XML, idx:int): ActivateEffectsData {
        var ae:ActivateEffectsData = new ActivateEffectsData(idx);
        //ae.Effect = LinkUtils.parseElementString(xml, "Activate");
        ae.Effect = xml.toString(); //Bruh
        ae.ObjectId = LinkUtils.parseAttributeString(xml, "@objectId");
        ae.Id = LinkUtils.parseAttributeString(xml, "@id");
        ae.DungeonName = LinkUtils.parseAttributeString(xml, "@dungeonName");
        ae.LockedName = LinkUtils.parseAttributeString(xml, "@lockedName");
        ae.SkinType = LinkUtils.parseAttributeInt(xml, "@skinType");
        ae.SkinType2 = LinkUtils.parseAttributeInt(xml, "@skinType2");
        ae.Size = LinkUtils.parseAttributeInt(xml, "@size");
        ae.CurrencyType = LinkUtils.parseAttributeString(xml, "@currencyType");
        ae.Gifts = []; //Unused client side
        ae.PetType = LinkUtils.parseAttributeInt(xml, "@petType");
        ae.Chance = LinkUtils.parseAttributeInt(xml, "@chance");
        ae.Explode = LinkUtils.parseAttributeBool(xml, "@explode");
        ae.Stats = LinkUtils.parseAttributeInt(xml, "@stat");
        ae.Stats2 = LinkUtils.parseAttributeInt(xml, "@stat2");
        ae.Stats3 = LinkUtils.parseAttributeInt(xml, "@stat3");
        ae.Amount = LinkUtils.parseAttributeInt(xml, "@amount");
        ae.Amount2 = LinkUtils.parseAttributeInt(xml, "@amount2");
        ae.Amount3 = LinkUtils.parseAttributeInt(xml, "@amount3");
        ae.Range = LinkUtils.parseAttributeFloat(xml, "@range");
        ae.IsPerc = LinkUtils.parseAttributeBool(xml, "@isPerc");
        ae.DurationMS = int(LinkUtils.parseAttributeFloat(xml, "@duration") * 1000);
        ae.DurationSec = LinkUtils.parseAttributeFloat(xml, "@duration");
        ae.ConditionEffect = LinkUtils.parseAttributeString(xml, "@effect");
        ae.ConditionEffect = LinkUtils.parseAttributeString(xml, "@condEffect", ae.ConditionEffect);// Bruh
        ae.CheckExistingEffect = LinkUtils.parseAttributeString(xml, "@checkExistingEffect");
        ae.EffectDuration = LinkUtils.parseAttributeFloat(xml, "@condDuration");
        ae.Radius = LinkUtils.parseAttributeFloat(xml, "@radius");
        ae.TotalDamage = LinkUtils.parseAttributeInt(xml, "@totalDamage");
        ae.ImpactDamage = LinkUtils.parseAttributeInt(xml, "@impactDamage");
        ae.ThrowTime = LinkUtils.parseAttributeInt(xml, "@throwTime");
        ae.AngleOffset = LinkUtils.parseAttributeInt(xml, "@angleOffset");
        ae.MaxTargets = LinkUtils.parseAttributeInt(xml, "@maxTargets");
        ae.Color = LinkUtils.parseAttributeInt(xml, "@color");
        ae.NoStack = LinkUtils.parseAttributeBool(xml, "@noStack");
        ae.UseWisMod = LinkUtils.parseAttributeBool(xml, "@useWisMod");
        ae.UseWisMod2 = LinkUtils.parseAttributeBool(xml, "@useWisMod2", ae.UseWisMod);
        ae.UseVitMod = LinkUtils.parseAttributeBool(xml, "@useVitMod")
        ae.UseAtkMod = LinkUtils.parseAttributeBool(xml, "@useAtkMod");
        ae.Target = LinkUtils.parseAttributeString(xml, "@target");
        ae.Center = LinkUtils.parseAttributeString(xml, "@center");
        ae.VisualEffect = LinkUtils.parseAttributeInt(xml, "@visualEffect");
        ae.Players = LinkUtils.parseAttributeBool(xml, "@players");
        ae.RandVals = LinkUtils.parseAttributeString(xml, "@randVals").replace(" ", "").split(",");
        ae.ObjType = LinkUtils.parseAttributeInt(xml, "@objType");
        ae.NumShots = LinkUtils.parseAttributeInt(xml, "@numShots");
        ae.Stat = LinkUtils.parseAttributeInt(xml, "@stat");
        return ae;
    }
}
}
