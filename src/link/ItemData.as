package link {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.ConditionEffect;
import com.company.util.Base64Decoder;

import flash.utils.ByteArray;
import flash.utils.IDataInput;


import svera.untiered.ui.view.HUDView;


public class ItemData {

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
    public var HonorBonus:int;
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
    public var Projectiles:Vector.<ProjectileData>;
    public var ActivateEffects:Vector.<ActivateEffectsData>;
    public var Steal:Array;
    public var EffectEquip:Array;

    public var TierType:String;
    public var ContainerType:String;

    public var ExiledEffect:String;
    public var ValiantEffect:String;

    public var Transmog:int;
    public var HasKillTracker:Boolean;
    public var KillTracker:uint;

    //Client Specific Stuff
    public var Scale:int;
    public var SetName:String;
    public var RT:Boolean;
    public var FablenToken:Boolean;
    public var Origin:String;
    public var QuestItem:Boolean;
    public var ExtraToolTipData:Array;
    public var TransmogData:Object;

    public function ItemData(oType:int = -1) {
        Projectiles = new <ProjectileData>[];
        ActivateEffects = new <ActivateEffectsData>[];
        Transmog = -1;
        if (oType <= 0) return;
        this.loadFromItem(oType);
    }

    public static function loadFromData(data:IDataInput): ItemData {
        var item:ItemData = new ItemData();
        item.updateData(data);
        return item;
    }

    public function clear(): void {
        ObjectType = -1;
        Id = "NO ITEM";
        Transmog = -1;
        Projectiles.length = 0;
        ActivateEffects.length = 0;
    }

    public function updateData(data:IDataInput, slot:int = -1): void {
        var oType:Number = data.readUnsignedShort();
        if (oType == 0) {
            this.clear();
            if (slot != -1)
                //HUDView.redrawSlotSignal.dispatch(slot);
            return;
        }
        this.loadFromItem(oType);
        this.parseData(data, slot);
    }

    private function loadFromItem(oType:int): void {
        var item:Item = ObjectLibrary.baseItems[oType];

        ObjectType = item.ObjectType;
        Id = item.Id;
        DisplayId = item.DisplayId;
        SlotType = item.SlotType;
        Tier = item.Tier;
        Description = item.Description;
        RateOfFire = item.RateOfFire;
        Usable = item.Usable;
        MpCost = item.MpCost;
        HpCost = item.HpCost;
        Fabled = item.Fabled;
        Legendary = item.Legendary;
        Godly = item.Godly;
        GodSlayer = item.GodSlayer;
        TierType = item.TierType;
        ContainerType = item.ContainerType;
        Valuable = item.Valuable;
        Tarnished = item.Tarnished;
        Artifact = item.Artifact;
        Ancestral = item.Ancestral;
        Valiant = item.Valiant;
        Relic = item.Relic;
        Exiled = item.Exiled;
        Celestial = item.Celestial;
        Shard = item.Shard;
        Fragment = item.Fragment;
        Ascended = item.Ascended;
        MultiPhase = item.MultiPhase;
        HonorBonus = item.HonorBonus;
        NumProjectiles = item.NumProjectiles1;
        HalfHPArmored = item.HalfHPArmored;
        ArcGap = item.ArcGap;
        ArcGap1 = item.ArcGap1;
        ArcGap2 = item.ArcGap2;
        NumProjectiles1 = item.NumProjectiles1;
        NumProjectiles2 = item.NumProjectiles2;
        DualShooting = item.DualShooting;
        Consumable = item.Consumable;
        InvUse = item.InvUse;
        ReUse = item.ReUse;
        Potion = item.Potion;
        Doses = item.Doses;
        SuccessorId = item.SuccessorId;
        Soulbound = item.Soulbound;
        Undead = item.Undead;
        PUndead = item.PUndead;
        SUndead = item.SUndead;
        Secret = item.Secret;
        Cooldown = item.Cooldown;
        Resurrects = item.Resurrects;
        Texture1 = item.Texture1;
        Texture2 = item.Texture2;
        StatBoosts = item.StatBoosts.slice();
        StatBoostsPerc = item.StatBoostsPerc.slice();

        Projectiles.length = item.Projectiles.length;
        for (var i:int = 0; i < item.Projectiles.length; i++)
            Projectiles[i] = item.Projectiles[i].clone();

        ActivateEffects.length = item.ActivateEffects.length;
        for (var a:int = 0; a < item.ActivateEffects.length; a++)
            ActivateEffects[a] = item.ActivateEffects[a].clone();

        Steal = item.Steal.slice();
        EffectEquip = item.EffectEquip;

        ContainerType = item.ContainerType;
        TierType = item.TierType;

        ExiledEffect = item.ExiledEffect;
        ValiantEffect = item.ValiantEffect;

        //Client Specific Stuff
        Scale = item.Scale;
        SetName = item.SetName;
        RT = item.RT;
        FablenToken = item.FablenToken;
        Origin = item.Origin;
        QuestItem = item.QuestItem;
        ExtraToolTipData = item.ExtraToolTipData;
        TransmogData = item.TransmogData;
    }

    private function parseData(data:IDataInput, slot:int): void {
        var count:int = data.readUnsignedByte();
        if(count == 0) return;

        for (var i:int = 0; i < count; i++) {
            var id:int = data.readUnsignedByte();
            var len:int;
            var idx:int;
            switch (id) {
                case 0:
                    RateOfFire = data.readFloat();
                    break;
                case 1:
                    MpCost = data.readShort();
                    break;
                case 2:
                    HpCost = data.readShort();
                    break;
                case 3:
                    HonorBonus = data.readByte();
                    break;
                case 4:
                    NumProjectiles = data.readUnsignedByte();
                    break;
                case 5:
                    ArcGap = data.readFloat();
                    break;
                case 6:
                    ArcGap1 = data.readFloat();
                    break;
                case 7:
                    ArcGap2 = data.readFloat();
                    break;
                case 8:
                    NumProjectiles1 = data.readUnsignedByte();
                    break;
                case 9:
                    NumProjectiles2 = data.readUnsignedByte();
                    break;
                case 10:
                    Soulbound = data.readBoolean();
                    break;
                case 11:
                    Resurrects = data.readBoolean();
                    break;
                case 12:
                    Cooldown = data.readInt();
                    break;
                case 13:
                    Doses = data.readUnsignedByte();
                    break;
                case 14:
                    idx = data.readByte();
                    StatBoosts[idx] = data.readShort();
                    break;
                case 15:
                    idx = data.readByte();
                    StatBoostsPerc[idx] = data.readShort();
                    break;
                //Projectiles
                case 16:
                    idx = data.readByte();
                    Projectiles[idx].LifetimeMS = data.readInt();
                    break;
                case 17:
                    idx = data.readByte();
                    Projectiles[idx].Speed = data.readInt();
                    break;
                case 18:
                    idx = data.readByte();
                    Projectiles[idx].Size = data.readShort();
                    break;
                case 19:
                    idx = data.readByte();
                    Projectiles[idx].MinDamage = data.readUnsignedShort();
                    break;
                case 20:
                    idx = data.readByte();
                    Projectiles[idx].MaxDamage = data.readUnsignedShort();
                    break;
                case 21:
                    idx = data.readByte();
                    var proj:ProjectileData = Projectiles[idx];
                    len = data.readUnsignedByte();
                    proj.Effects = [];
                    proj.EffectsId = [];
                    for (var e:int = 0; e < len; e++) {
                        var effId:int = data.readUnsignedByte();
                        proj.EffectsId[e] = effId;
                        proj.Effects[e] = {"Effect": ConditionEffect.effects_[effId].name_, "Duration": data.readInt() / 1000};
                    }
                    break;
                case 22:
                    idx = data.readByte();
                    len = data.readUnsignedByte();
                    Projectiles[idx].ChanceEffects = [];
                    for (var ce:int = 0; ce < len; ce++) {
                        Projectiles[idx].ChanceEffects[ce] = {"Effect": ConditionEffect.effects_[data.readUnsignedByte()].name_, "Duration": data.readInt() / 1000, "Chance": data.readFloat()};
                    }
                    break;
                case 23:
                    idx = data.readByte();
                    Projectiles[idx].MultiHit = data.readBoolean();
                    break;
                case 24:
                    idx = data.readByte();
                    Projectiles[idx].PassesCover = data.readBoolean();
                    break;
                case 25:
                    idx = data.readByte();
                    Projectiles[idx].ArmorPiercing = data.readBoolean();
                    break;
                case 26:
                    idx = data.readByte();
                    Projectiles[idx].Wavy = data.readBoolean();
                    break;
                case 27:
                    idx = data.readByte();
                    Projectiles[idx].Parametric = data.readBoolean();
                    break;
                case 28:
                    idx = data.readByte();
                    Projectiles[idx].Boomerang = data.readBoolean();
                    break;
                case 29:
                    idx = data.readByte();
                    Projectiles[idx].Amplitude = data.readFloat();
                    break;
                case 30:
                    idx = data.readByte();
                    Projectiles[idx].Frequency = data.readFloat();
                    break;
                case 31:
                    idx = data.readByte();
                    Projectiles[idx].Magnitude = data.readFloat();
                    break;
                case 32:
                    idx = data.readByte();
                    Steal[idx] = data.readUnsignedByte();
                    break;
                case 33:
                    ContainerType = LinkUtils.getContainerType(data.readUnsignedByte());
                    break;
                case 34:
                    TierType = LinkUtils.getTierType(data.readUnsignedByte());
                    break;
                //AE
                case 35:
                    idx = data.readByte();
                    ActivateEffects[idx].Stats = data.readInt();
                    break;
                case 36:
                    idx = data.readByte();
                    ActivateEffects[idx].Stats2 = data.readInt();
                    break;
                case 37:
                    idx = data.readByte();
                    ActivateEffects[idx].Stats3 = data.readInt();
                    break;
                case 38:
                    idx = data.readByte();
                    ActivateEffects[idx].Amount = data.readInt();
                    break;
                case 39:
                    idx = data.readByte();
                    ActivateEffects[idx].Amount2 = data.readInt();
                    break;
                case 40:
                    idx = data.readByte();
                    ActivateEffects[idx].Amount3 = data.readInt();
                    break;
                case 41:
                    idx = data.readByte();
                    ActivateEffects[idx].Range = data.readFloat();
                    break;
                case 42:
                    idx = data.readByte();
                    ActivateEffects[idx].IsPerc = data.readBoolean();
                    break;
                case 43:
                    idx = data.readByte();
                    ActivateEffects[idx].DurationMS = data.readInt();
                    ActivateEffects[idx].DurationSec = ActivateEffects[idx].DurationMS / 1000;
                    break;
                case 44:
                    idx = data.readByte();
                    ActivateEffects[idx].ConditionEffect = ConditionEffect.effects_[data.readUnsignedByte()].name_;
                    break;
                case 45:
                    idx = data.readByte();
                    ActivateEffects[idx].CheckExistingEffect = ConditionEffect.effects_[data.readUnsignedByte()].name_;
                    break;
                case 46:
                    idx = data.readByte();
                    ActivateEffects[idx].EffectDuration = data.readFloat();
                    break;
                case 47:
                    idx = data.readByte();
                    ActivateEffects[idx].Radius = data.readFloat();
                    break;
                case 48:
                    idx = data.readByte();
                    ActivateEffects[idx].TotalDamage = data.readInt();
                    break;
                case 49:
                    idx = data.readByte();
                    ActivateEffects[idx].ImpactDamage = data.readInt();
                    break;
                case 50:
                    idx = data.readByte();
                    ActivateEffects[idx].ThrowTime = data.readInt();
                    break;
                case 51:
                    idx = data.readByte();
                    ActivateEffects[idx].AngleOffset = data.readInt();
                    break;
                case 52:
                    idx = data.readByte();
                    ActivateEffects[idx].MaxTargets = data.readUnsignedByte();
                    break;
                case 53:
                    idx = data.readByte();
                    ActivateEffects[idx].Color = data.readUnsignedShort();
                    break;
                case 54:
                    idx = data.readByte();
                    ActivateEffects[idx].NoStack = data.readBoolean();
                    break;
                case 55:
                    idx = data.readByte();
                    ActivateEffects[idx].UseWisMod = data.readBoolean();
                    break;
                case 56:
                    idx = data.readByte();
                    ActivateEffects[idx].UseWisMod2 = data.readBoolean();
                    break;
                case 57:
                    idx = data.readByte();
                    ActivateEffects[idx].UseVitMod = data.readBoolean();
                    break;
                case 58:
                    idx = data.readByte();
                    ActivateEffects[idx].UseAtkMod = data.readBoolean();
                    break;
                case 59:
                    idx = data.readByte();
                    ActivateEffects[idx].Target = LinkUtils.getTargetingType(data.readUnsignedByte());
                    break;
                case 60:
                    idx = data.readByte();
                    ActivateEffects[idx].Center = LinkUtils.getTargetingType(data.readUnsignedByte());
                    break;
                case 61:
                    idx = data.readByte();
                    ActivateEffects[idx].VisualEffect = data.readInt();
                    break;
                case 62:
                    idx = data.readByte();
                    ActivateEffects[idx].Players = data.readBoolean();
                    break;
                case 63:
                    idx = data.readByte();
                    ActivateEffects[idx].RandVals.length = data.readUnsignedByte();
                    for (var j:int = 0; j < ActivateEffects[idx].RandVals.length; j++)
                        ActivateEffects[idx].RandVals[j] = ConditionEffect.effects_[data.readUnsignedByte()].name_;
                    break;
                case 64:
                    idx = data.readByte();
                    ActivateEffects[idx].ObjType = data.readUnsignedShort();
                    break;
                case 65://PLACEHOLDER: Explode
                    break;
                case 66:
                    idx = data.readByte();
                    ActivateEffects[idx].NumShots = data.readUnsignedByte();
                    break;
                case 67:
                    Transmog = data.readShort();
                    if (slot != -1)
                        //HUDView.instance..dispatch(slot); //TODO: fix
                    break;
                    break;
                case 68:
                    HasKillTracker = true;
                    KillTracker = data.readUnsignedInt();
                    break;
                case 69:
                    break;
                case 70:
                    break;
                default:
                    trace("[ItemData] Unable to parse ItemDataStat: ", id);
                    break;
            }
        }
    }

    public static function fromPlayerXML(obj:Object) : Vector.<ItemData> {
        var equipment:Vector.<ItemData> = new Vector.<ItemData>();
        var data:Array = obj.toString().split(", ");
        var bytes:ByteArray;
        var decoder:Base64Decoder = new Base64Decoder();
        equipment.length = data.length;
        var i:Number = 0;
/*        while(i < equipment.length) {
            decoder.decode(data[i])
            bytes = decoder.toByteArray()
            bytes.position = 0;
            bytes.endian = "littleEndian"
            equipment[i] = ItemData.loadFromData(bytes);
            i++;
        }*/ //TODO: Not sure about this
        return equipment;
    }
}
}
