package link {

public class Item {

    public var ObjectType:int = -1;
    public var Id:String = "NO ITEM";
    public var DisplayId:String;

    public var SlotType:int;
    public var Tier:int;
    public var Description:String;
    public var RateOfFire:Number;
    public var Usable:Boolean;
    public var MpCost:int;
    public var HpCost:int;
    public var Fabled:Boolean;
    public var Legendary:Boolean;
    public var Godly:Boolean;
    public var GodSlayer:Boolean;
    public var TierType:String;
    public var ContainerType:String;
    public var Valuable:Boolean;
    public var Tarnished:Boolean;
    public var Artifact:Boolean;
    public var Ancestral:Boolean;
    public var Valiant:Boolean;
    public var Relic:Boolean;
    public var Exiled:Boolean;
    public var Celestial:Boolean;
    public var Shard:Boolean;
    public var Fragment:Boolean;
    public var Ascended:Boolean;
    public var MultiPhase:Boolean;
    public var FameBonus:int;
    public var NumProjectiles:int;
    public var HalfHPArmored:Boolean;
    public var ArcGap:Number;
    public var ArcGap1:Number;
    public var ArcGap2:Number;
    public var NumProjectiles1:int;
    public var NumProjectiles2:int;
    public var DualShooting:Boolean;
    public var Consumable:Boolean;
    public var InvUse:Boolean;
    public var ReUse:Boolean;
    public var Potion:Boolean;
    public var Doses:int;
    public var SuccessorId:String;
    public var Soulbound:Boolean;
    public var Undead:Boolean;
    public var PUndead:Boolean;
    public var SUndead:Boolean;
    public var Secret:Boolean;
    public var Cooldown:Number
    public var Resurrects:Boolean;
    public var Texture1:int;
    public var Texture2:int;

    public var StatBoosts:Array;
    public var StatBoostsPerc:Array;
    public var Projectiles:Array;
    public var ActivateEffects:Array;
    public var Steal:Array;
    public var EffectEquip:Array;

    public var ExiledEffect:String;
    public var ValiantEffect:String;


    //Client Specific Stuff
    public var Scale:int;
    public var SetName:String;
    public var RT:Boolean;
    public var FablenToken:Boolean;
    public var Origin:String;
    public var QuestItem:Boolean;
    public var ExtraToolTipData:Array;
    public var TransmogData:Object;

    public function Item() {}

    public static function parseFromXml(xml:XML): Item {
        var item:Item = new Item();
        var elem:XML;
        item.ObjectType = int(xml.@type);
        item.Id = String(xml.@id);

        item.DisplayId = LinkUtils.parseElementString(xml, "DisplayId", item.Id);
        item.SlotType = LinkUtils.parseElementInt(xml, "SlotType");
        item.Tier = LinkUtils.parseElementInt(xml, "Tier", -1)
        item.Description = LinkUtils.parseElementString(xml, "Description");
        item.RateOfFire = LinkUtils.parseElementFloat(xml, "RateOfFire", 1.0);
        item.Usable = LinkUtils.parseElementBool(xml, "Usable");
        item.MpCost = LinkUtils.parseElementInt(xml, "MpCost");
        item.HpCost = LinkUtils.parseElementInt(xml, "HpCost");
        item.Fabled = LinkUtils.parseElementBool(xml, "Fabled");
        item.Legendary = LinkUtils.parseElementBool(xml, "Legendary");
        item.Godly = LinkUtils.parseElementBool(xml, "Godly");
        item.GodSlayer = LinkUtils.parseElementBool(xml, "GodSlayer");
        item.TierType = LinkUtils.parseElementString(xml, "TierType");
        item.ContainerType = LinkUtils.parseElementString(xml, "ContainerType");
        item.Valuable = LinkUtils.parseElementBool(xml, "Valuable");
        item.Tarnished = LinkUtils.parseElementBool(xml, "Tarnished");
        item.Artifact = LinkUtils.parseElementBool(xml, "Artifact");
        item.Ancestral = LinkUtils.parseElementBool(xml, "Ancestral");
        item.Valiant = LinkUtils.parseElementBool(xml, "Valiant");
        item.Relic = LinkUtils.parseElementBool(xml, "Relic");
        item.Exiled = LinkUtils.parseElementBool(xml, "Exiled");
        item.Celestial = LinkUtils.parseElementBool(xml, "Celestial");
        item.Shard = LinkUtils.parseElementBool(xml, "Shard");
        item.Fragment = LinkUtils.parseElementBool(xml, "Fragment");
        item.Ascended = LinkUtils.parseElementBool(xml, "Ascended");
        item.MultiPhase = LinkUtils.parseElementBool(xml, "MultiPhase");
        item.FameBonus = LinkUtils.parseElementInt(xml, "FameBonus");
        item.NumProjectiles = LinkUtils.parseElementInt(xml, "NumProjectiles", 1);
        item.HalfHPArmored = LinkUtils.parseElementBool(xml, "HalfHPArmored");
        item.ArcGap = LinkUtils.parseElementFloat(xml, "ArcGap", 11.25);
        item.ArcGap1 = LinkUtils.parseElementFloat(xml, "ArcGap1", 11.25);
        item.ArcGap2 = LinkUtils.parseElementFloat(xml, "ArcGap2", 11.25);
        item.NumProjectiles1 = LinkUtils.parseElementInt(xml, "NumProjectiles1", 1);
        item.NumProjectiles2 = LinkUtils.parseElementInt(xml, "NumProjectiles2", 1);
        item.DualShooting = LinkUtils.parseElementBool(xml, "DualShooting");
        item.Consumable = LinkUtils.parseElementBool(xml, "Consumable");
        item.InvUse = LinkUtils.parseElementBool(xml, "InvUse");
        item.ReUse = LinkUtils.parseElementBool(xml, "ReUse");
        item.Potion = LinkUtils.parseElementBool(xml, "Potion");
        item.Doses = LinkUtils.parseElementInt(xml, "Doses");
        item.SuccessorId = LinkUtils.parseElementString(xml, "SuccessorId");
        item.Soulbound = LinkUtils.parseElementBool(xml, "Soulbound");
        item.Undead = LinkUtils.parseElementBool(xml, "Undead");
        item.PUndead = LinkUtils.parseElementBool(xml, "PUndead");
        item.SUndead = LinkUtils.parseElementBool(xml, "SUndead");
        item.Secret = LinkUtils.parseElementBool(xml, "Secret");
        item.Cooldown = LinkUtils.parseElementFloat(xml, "Cooldown", 0.5) * 1000;
        item.Resurrects = LinkUtils.parseElementBool(xml, "Resurrects");
        item.Texture1 = LinkUtils.parseElementInt(xml, "Tex1", 0, 16);
        item.Texture2 = LinkUtils.parseElementInt(xml, "Tex2", 0, 16);

        item.StatBoosts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        item.StatBoostsPerc = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        for each (elem in xml.elements("ActivateOnEquip"))
            (LinkUtils.parseAttributeBool(elem, "@isPerc") ? item.StatBoostsPerc : item.StatBoosts)[LinkUtils.getStatIndex(LinkUtils.parseAttributeInt(elem, "@stat"))] = LinkUtils.parseAttributeInt(elem, "@amount");

        item.Projectiles = [];
        for each (elem in xml.elements("Projectile")) {
            var proj:ProjectileData = ProjectileData.parseFromXml(elem);
            item.Projectiles[proj.BulletType] = proj;
        }

        item.ActivateEffects = [];
        var index:int = 0;
        for each (elem in xml.elements("Activate")) {
            item.ActivateEffects[index] = ActivateEffectsData.parseFromXml(elem, index);
            index++;
        }

        item.Steal = [0, 0];
        for each (elem in xml.elements("Steal")) {
            var idx:int = LinkUtils.parseAttributeString(elem, "@type") == "life" ? 0 : 1;
            item.Steal[idx] = LinkUtils.parseAttributeInt(elem, "@amount");
        }

        item.EffectEquip = []
        for each (elem in xml.elements("EffectEquip")) {
            item.EffectEquip.push({"Effect": LinkUtils.parseAttributeString(elem, "@effect"), "Delay": LinkUtils.parseAttributeInt(elem, "@delay")})
        }

        item.ExiledEffect = LinkUtils.parseAttributeFromElementString(xml, "Exiled", "@id");
        item.ValiantEffect = LinkUtils.parseAttributeFromElementString(xml, "Valiant", "@id");

        //Client Specific Stuff
        item.Scale = LinkUtils.parseElementInt(xml, "ScaleValue", 5);
        item.SetName = LinkUtils.parseAttributeString(xml, "@setName");
        item.RT = LinkUtils.parseElementBool(xml, "RT");
        item.FablenToken = LinkUtils.parseElementBool(xml, "FabledToken");
        item.Origin = LinkUtils.parseElementString(xml, "Origin");
        item.QuestItem = LinkUtils.parseElementBool(xml, "QuestItem");
        item.ExtraToolTipData = [];
        if (xml.hasOwnProperty("ExtraTooltipData")) {
            var subXml:XMLList = xml.child("ExtraTooltipData");
            for each (elem in subXml.elements("EffectInfo"))
                item.ExtraToolTipData.push({"Name": LinkUtils.parseAttributeString(elem, "@name"), "Description": LinkUtils.parseAttributeString(elem, "@description")});
        }

        if (xml.hasOwnProperty("TransmogData")) {
            var mog:XML = xml.elements("TransmogData")[0];
            item.TransmogData = {
                "Id": LinkUtils.parseAttributeInt(mog,"@id", -1, 16),
                "Slot": LinkUtils.parseAttributeInt(mog,"@slot", -1),
                "ObjType": LinkUtils.parseAttributeInt(mog,"@type", -1, 16),
                "Tier": LinkUtils.parseAttributeString(mog,"@tier")
            };
        }

        return item;
    }
}
}