package svera.untiered.itemdata {


public class Item {

    private var _objectType:int;
    public final function get ObjectType():int { return _objectType; }

    private var _id:String = "NO ITEM";
    public final function get Id():String { return _id; }

    private var _displayId:String;
    public final function get DisplayId():String { return _displayId; }

    private var _slotType:int;
    public final function get SlotType():int { return _slotType; }

    private var _tier:int;
    public final function get Tier():int { return _tier; }

    private var _description:String;
    public final function get Description():String { return _description; }

    private var _rateOfFire:Number;
    public final function get RateOfFire():Number { return _rateOfFire; }

    private var _usable:Boolean;
    public final function get Usable():Boolean { return _usable; }

    private var _mpCost:int;
    public final function get MpCost():int { return _mpCost; }

    private var _hpCost:int;
    public final function get HpCost():int { return _hpCost; }

    private var _fabled:Boolean;
    public final function get Fabled():Boolean { return _fabled; }

    private var _legendary:Boolean;
    public final function get Legendary():Boolean { return _legendary; }

    private var _godly:Boolean;
    public final function get Godly():Boolean { return _godly; }

    private var _godSlayer:Boolean;
    public final function get GodSlayer():Boolean { return _godSlayer; }

    private var _tierType:String;
    public final function get TierType():String { return _tierType; }

    private var _containerType:String;
    public final function get ContainerType():String { return _containerType; }

    private var _valuable:Boolean;
    public final function get Valuable():Boolean { return _valuable; }

    private var _tarnished:Boolean;
    public final function get Tarnished():Boolean { return _tarnished; }

    private var _artifact:Boolean;
    public final function get Artifact():Boolean { return _artifact; }

    private var _ancestral:Boolean;
    public final function get Ancestral():Boolean { return _ancestral; }

    private var _valiant:Boolean;
    public final function get Valiant():Boolean { return _valiant; }

    private var _relic:Boolean;
    public final function get Relic():Boolean { return _relic; }

    private var _exiled:Boolean;
    public final function get Exiled():Boolean { return _exiled; }

    private var _celestial:Boolean;
    public final function get Celestial():Boolean { return _celestial; }

    private var _shard:Boolean;
    public final function get Shard():Boolean { return _shard; }

    private var _fragment:Boolean;
    public final function get Fragment():Boolean { return _fragment; }

    private var _ascended:Boolean;
    public final function get Ascended():Boolean { return _ascended; }

    private var _multiPhase:Boolean;
    public final function get MultiPhase():Boolean { return _multiPhase; }

    private var _honorBonus:int;
    public final function get HonorBonus():int { return _honorBonus; }

    private var _numProjectiles:int;
    public final function get NumProjectiles():int { return _numProjectiles; }

    private var _halfHPArmored:Boolean;
    public final function get HalfHPArmored():Boolean { return _halfHPArmored; }

    private var _arcGap:Number;
    public final function get ArcGap():Number { return _arcGap; }

    private var _arcGap1:Number;
    public final function get ArcGap1():Number { return _arcGap1; }

    private var _arcGap2:Number;
    public final function get ArcGap2():Number { return _arcGap2; }

    private var _numProjectiles1:int;
    public final function get NumProjectiles1():int { return _numProjectiles1; }

    private var _numProjectiles2:int;
    public final function get NumProjectiles2():int { return _numProjectiles2; }

    private var _dualShooting:Boolean;
    public final function get DualShooting():Boolean { return _dualShooting; }

    private var _consumable:Boolean;
    public final function get Consumable():Boolean { return _consumable; }

    private var _invUse:Boolean;
    public final function get InvUse():Boolean { return _invUse; }

    private var _reUse:Boolean;
    public final function get ReUse():Boolean { return _reUse; }

    private var _potion:Boolean;
    public final function get Potion():Boolean { return _potion; }

    private var _doses:int;
    public final function get Doses():int { return _doses; }

    private var _successorId:String;
    public final function get SuccessorId():String { return _successorId; }

    private var _soulbound:Boolean;
    public function get Soulbound():Boolean { return _soulbound; }

    private var _undead:Boolean;
    public final function get Undead():Boolean { return _undead; }

    private var _pUndead:Boolean;
    public final function get PUndead():Boolean { return _pUndead; }

    private var _sUndead:Boolean;
    public final function get SUndead():Boolean { return _sUndead; }

    private var _secret:Boolean;
    public final function get Secret():Boolean { return _secret; }

    private var _cooldown:Number;
    public final function get Cooldown():Number { return _cooldown; }

    private var _resurrects:Boolean;
    public final function get Resurrects():Boolean { return _resurrects; }

    private var _texture1:int;
    public final function get Texture1():int { return _texture1; }

    private var _texture2:int;
    public final function get Texture2():int { return _texture2; }

    private var _statBoosts:Array;
    public final function get StatBoosts():Array { return _statBoosts; }

    private var _statBoostsPerc:Array;
    public final function get StatBoostsPerc():Array { return _statBoostsPerc; }

    private var _projectiles:Array;
    public final function get Projectiles():Array { return _projectiles; }

    private var _activateEffects:Array;
    public final function get ActivateEffects():Array { return _activateEffects; }

    private var _steal:Array;
    public final function get Steal():Array { return _steal; }

    private var _effectEquip:Array;
    public final function get EffectEquip():Array { return _effectEquip; }

    private var _exiledEffect:String;
    public final function get ExiledEffect():String { return _exiledEffect; }

    private var _valiantEffect:String;
    public final function get ValiantEffect():String { return _valiantEffect; }

    private var _scale:int;
    public final function get Scale():int { return _scale; }

    private var _setName:String;
    public final function get SetName():String { return _setName; }

    private var _rt:Boolean;
    public final function get RT():Boolean { return _rt; }

    private var _fabledToken:Boolean;
    public final function get FabledToken():Boolean { return _fabledToken; }

    private var _origin:String;
    public final function get Origin():String { return _origin; }

    private var _questItem:Boolean;
    public final function get QuestItem():Boolean { return _questItem; }

    private var _extraToolTipData:Array;
    public final function get ExtraToolTipData():Array { return _extraToolTipData; }

    private var _transmogData:Object;
    public final function get TransmogData():Object { return _transmogData; }

    public function Item(item:Item) {
        if (item == null) return;

        _objectType = item._objectType;
        _id = item._id;
        _displayId = item._displayId;
        _slotType = item._slotType;
        _tier = item._tier;
        _description = item._description;
        _rateOfFire = item._rateOfFire;
        _usable = item._usable;
        _mpCost = item._mpCost;
        _hpCost = item._hpCost;
        _fabled = item._fabled;
        _legendary = item._legendary;
        _godly = item._godly;
        _godSlayer = item._godSlayer;
        _tierType = item._tierType;
        _containerType = item._containerType;
        _valuable = item._valuable;
        _tarnished = item._tarnished;
        _artifact = item._artifact;
        _ancestral = item._ancestral;
        _valiant = item._valiant;
        _relic = item._relic;
        _exiled = item._exiled;
        _celestial = item._celestial;
        _shard = item._shard;
        _fragment = item._fragment;
        _ascended = item._ascended;
        _multiPhase = item._multiPhase;
        _honorBonus = item._honorBonus;
        _numProjectiles = item._numProjectiles;
        _halfHPArmored = item._halfHPArmored;
        _arcGap = item._arcGap;
        _arcGap1 = item._arcGap1;
        _arcGap2 = item._arcGap2;
        _numProjectiles1 = item._numProjectiles1;
        _numProjectiles2 = item._numProjectiles2;
        _dualShooting = item._dualShooting;
        _consumable = item._consumable;
        _invUse = item._invUse;
        _reUse = item._reUse;
        _potion = item._potion;
        _doses = item._doses;
        _successorId = item._successorId;
        _soulbound = item._soulbound;
        _undead = item._undead;
        _pUndead = item._pUndead;
        _sUndead = item._sUndead;
        _secret = item._secret;
        _cooldown = item._cooldown;
        _resurrects = item._resurrects;
        _texture1 = item._texture1;
        _texture2 = item._texture2;

        _statBoosts = item._statBoosts;
        _statBoostsPerc = item._statBoostsPerc;

        _projectiles = item._projectiles;
        _activateEffects = item._activateEffects;
        _steal = item._steal;
        _effectEquip = item._effectEquip;

        _exiledEffect = item._exiledEffect;
        _valiantEffect = item._valiantEffect;

        _scale = item._scale;
        _setName = item._setName;
        _rt = item._rt;
        _fabledToken = item._fabledToken;
        _origin = item._origin;
        _questItem = item._questItem;

        _extraToolTipData = item._extraToolTipData;

        _transmogData = item._transmogData;
    }

    public static function parseFromXml(xml:XML):Item {
        var item:Item = new Item(null);
        var elem:XML;
        item._objectType = int(xml.@type);
        item._id = String(xml.@id);
        item._displayId = LinkUtils.parseElementString(xml, "DisplayId", item._id);
        item._slotType = LinkUtils.parseElementInt(xml, "SlotType", -1);
        item._tier = LinkUtils.parseElementInt(xml, "Tier", -1);
        item._description = LinkUtils.parseElementString(xml, "Description");
        item._rateOfFire = LinkUtils.parseElementFloat(xml, "RateOfFire", 1.0);
        item._usable = LinkUtils.parseElementBool(xml, "Usable");
        item._mpCost = LinkUtils.parseElementInt(xml, "MpCost");
        item._hpCost = LinkUtils.parseElementInt(xml, "HpCost");
        item._fabled = LinkUtils.parseElementBool(xml, "Fabled");
        item._legendary = LinkUtils.parseElementBool(xml, "Legendary");
        item._godly = LinkUtils.parseElementBool(xml, "Godly");
        item._godSlayer = LinkUtils.parseElementBool(xml, "GodSlayer");
        item._tierType = LinkUtils.parseElementString(xml, "TierType");
        item._containerType = LinkUtils.parseElementString(xml, "ContainerType");
        item._valuable = LinkUtils.parseElementBool(xml, "Valuable");
        item._tarnished = LinkUtils.parseElementBool(xml, "Tarnished");
        item._artifact = LinkUtils.parseElementBool(xml, "Artifact");
        item._ancestral = LinkUtils.parseElementBool(xml, "Ancestral");
        item._valiant = LinkUtils.parseElementBool(xml, "Valiant");
        item._relic = LinkUtils.parseElementBool(xml, "Relic");
        item._exiled = LinkUtils.parseElementBool(xml, "Exiled");
        item._celestial = LinkUtils.parseElementBool(xml, "Celestial");
        item._shard = LinkUtils.parseElementBool(xml, "Shard");
        item._fragment = LinkUtils.parseElementBool(xml, "Fragment");
        item._ascended = LinkUtils.parseElementBool(xml, "Ascended");
        item._multiPhase = LinkUtils.parseElementBool(xml, "MultiPhase");
        item._honorBonus = LinkUtils.parseElementInt(xml, "HonorBonus");
        item._numProjectiles = LinkUtils.parseElementInt(xml, "NumProjectiles", 1);
        item._halfHPArmored = LinkUtils.parseElementBool(xml, "HalfHPArmored");
        item._arcGap = LinkUtils.parseElementFloat(xml, "ArcGap", 11.25);
        item._arcGap1 = LinkUtils.parseElementFloat(xml, "ArcGap1", 11.25);
        item. _arcGap2 = LinkUtils.parseElementFloat(xml, "ArcGap2", 11.25);
        item._numProjectiles1 = LinkUtils.parseElementInt(xml, "NumProjectiles1", 1);
        item._numProjectiles2 = LinkUtils.parseElementInt(xml, "NumProjectiles2", 1);
        item._dualShooting = LinkUtils.parseElementBool(xml, "DualShooting");
        item._consumable = LinkUtils.parseElementBool(xml, "Consumable");
        item._invUse = LinkUtils.parseElementBool(xml, "InvUse");
        item._reUse = LinkUtils.parseElementBool(xml, "ReUse");
        item._potion = LinkUtils.parseElementBool(xml, "Potion");
        item._doses = LinkUtils.parseElementInt(xml, "Doses");
        item._successorId = LinkUtils.parseElementString(xml, "SuccessorId");
        item._soulbound = LinkUtils.parseElementBool(xml, "Soulbound");
        item._undead = LinkUtils.parseElementBool(xml, "Undead");
        item._pUndead = LinkUtils.parseElementBool(xml, "PUndead");
        item._sUndead = LinkUtils.parseElementBool(xml, "SUndead");
        item._secret = LinkUtils.parseElementBool(xml, "Secret");
        item._cooldown = LinkUtils.parseElementFloat(xml, "Cooldown", 0.5) * 1000;
        item._resurrects = LinkUtils.parseElementBool(xml, "Resurrects");
        item._texture1 = LinkUtils.parseElementInt(xml, "Tex1", 0, 16);
        item._texture2 = LinkUtils.parseElementInt(xml, "Tex2", 0, 16);

        item._statBoosts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        item._statBoostsPerc = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        for each (elem in xml.elements("ActivateOnEquip")) {
            var statIndex:int = LinkUtils.getStatIndex(LinkUtils.parseAttributeInt(elem, "@stat"));
            var amount:int = LinkUtils.parseAttributeInt(elem, "@amount");
            if (LinkUtils.parseAttributeBool(elem, "@isPerc")) {
                item._statBoostsPerc[statIndex] = amount;
            } else {
                item._statBoosts[statIndex] = amount;
            }
        }

        item._projectiles = [];
        for each (elem in xml.elements("Projectile")) {
            var proj:ProjectileData = ProjectileData.parseFromXml(elem);
            item._projectiles[proj.BulletType] = proj;
        }

        item._activateEffects = [];
        var index:int = 0;
        for each (elem in xml.elements("Activate")) {
            item._activateEffects[index] = ActivateEffectsData.parseFromXml(elem, index);
            index++;
        }

        item._steal = [0, 0];
        for each (elem in xml.elements("Steal")) {
            var idx:int = LinkUtils.parseAttributeString(elem, "@type") == "life" ? 0 : 1;
            item._steal[idx] = LinkUtils.parseAttributeInt(elem, "@amount");
        }

        item._effectEquip = [];
        for each (elem in xml.elements("EffectEquip")) {
            item._effectEquip.push({
                "Effect": LinkUtils.parseAttributeString(elem, "@effect"),
                "Delay": LinkUtils.parseAttributeInt(elem, "@delay")
            });
        }

        item._exiledEffect = LinkUtils.parseAttributeFromElementString(xml, "Exiled", "@id");
        item._valiantEffect = LinkUtils.parseAttributeFromElementString(xml, "Valiant", "@id");

        // Client specific
        item._scale = LinkUtils.parseElementInt(xml, "ScaleValue", 5);
        item._setName = LinkUtils.parseAttributeString(xml, "@setName");
        item._rt = LinkUtils.parseElementBool(xml, "RT");
        item. _fabledToken = LinkUtils.parseElementBool(xml, "FabledToken");
        item._origin = LinkUtils.parseElementString(xml, "Origin");
        item._questItem = LinkUtils.parseElementBool(xml, "QuestItem");

        item._extraToolTipData = [];
        if (xml.hasOwnProperty("ExtraTooltipData")) {
            var subXml:XMLList = xml.child("ExtraTooltipData");
            for each (elem in subXml.elements("EffectInfo")) {
                item._extraToolTipData.push({
                    "Name": LinkUtils.parseAttributeString(elem, "@name"),
                    "Description": LinkUtils.parseAttributeString(elem, "@description")
                });
            }
        }

        if (xml.hasOwnProperty("TransmogData")) {
            var mog:XML = xml.elements("TransmogData")[0];
            item._transmogData = {
                "Id": LinkUtils.parseAttributeInt(mog, "@id", -1, 16),
                "Slot": LinkUtils.parseAttributeInt(mog, "@slot", -1),
                "ObjType": LinkUtils.parseAttributeInt(mog, "@type", -1, 16),
                "Tier": LinkUtils.parseAttributeString(mog, "@tier")
            };
        }

        return item;
    }
}
}