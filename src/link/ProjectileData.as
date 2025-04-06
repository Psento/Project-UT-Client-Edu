package link {
import com.company.assembleegameclient.util.ConditionEffect;

public class ProjectileData {

    public var BulletType:int;
    public var ObjectId:String
    public var LifetimeMS:int;
    public var Speed:Number;
    public var Size:int;
    public var MinDamage:int;
    public var MaxDamage:int;
    public var Damage:int;
    public var MultiHit:Boolean;
    public var PassesCover:Boolean;
    public var ArmorPiercing:Boolean;
    public var ParticleTrail:Boolean;
    public var ParticleTrailIntensity:int;
    public var ParticleTrailLifetimeMS:int;
    public var ParticleTrailColor:int;
    public var Wavy:Boolean;
    public var Parametric:Boolean;
    public var Boomerang:Boolean;
    public var Amplitude:Number;
    public var Frequency:Number;
    public var Magnitude:Number;
    public var FaceDir:Boolean;
    public var NoRotation:Boolean;

    public var Effects:Array;
    public var EffectsId:Array;
    public var ChanceEffects:Array;

    public function ProjectileData() {}

    public static function parseFromXml(xml:XML): ProjectileData {
        var proj:ProjectileData = new ProjectileData();
        proj.BulletType = LinkUtils.parseAttributeInt(xml, "@id");
        proj.ObjectId = LinkUtils.parseElementString(xml, "ObjectId");
        proj.LifetimeMS = LinkUtils.parseElementInt(xml, "LifetimeMS");
        proj.Speed = LinkUtils.parseElementInt(xml, "Speed");
        proj.Size = LinkUtils.parseElementInt(xml, "Size", -1);

        if (xml.hasOwnProperty("Damage")) {
            proj.MinDamage = proj.MaxDamage = LinkUtils.parseElementInt(xml, "Damage");
        }
        else
        {
            proj.MinDamage = LinkUtils.parseElementInt(xml, "MinDamage");
            proj.MaxDamage = LinkUtils.parseElementInt(xml, "MaxDamage");
        }

        proj.MultiHit = LinkUtils.parseElementBool(xml, "MultiHit");
        proj.PassesCover = LinkUtils.parseElementBool(xml, "PassesCover");
        proj.ArmorPiercing = LinkUtils.parseElementBool(xml, "ArmorPiercing");

        proj.ParticleTrail = LinkUtils.parseElementBool(xml, "ParticleTrail");
        if (proj.ParticleTrail) {
            var elem:XML = xml.elements("ParticleTrail")[0];
            proj.ParticleTrailIntensity = LinkUtils.parseAttributeInt(elem, "@intensity") * 100;
            proj.ParticleTrailLifetimeMS = LinkUtils.parseAttributeInt(elem, "@lifetimeMS");
            proj.ParticleTrailColor = LinkUtils.parseElementFloat(elem, "ParticleTrail", 0xFF00FF);
            if (proj.ParticleTrailColor == 0) proj.ParticleTrailColor = 0xFF00FF;
        }

        proj.Wavy = LinkUtils.parseElementBool(xml, "Wavy");
        proj.Parametric = LinkUtils.parseElementBool(xml, "Parametric");
        proj.Boomerang = LinkUtils.parseElementBool(xml, "Boomerang");
        proj.Amplitude = LinkUtils.parseElementFloat(xml, "Amplitude");
        proj.Frequency = LinkUtils.parseElementFloat(xml, "Frequency", 1);
        proj.Magnitude = LinkUtils.parseElementFloat(xml, "Magnitude", 3);
        proj.FaceDir = LinkUtils.parseElementBool(xml, "FaceDir");
        proj.NoRotation = LinkUtils.parseElementBool(xml, "NoRotation");

        proj.Effects = [];//Tooltips
        proj.EffectsId = [];//GameObject.damage()
        for each (elem in xml.elements("ConditionEffect")) {
            proj.Effects.push({"Effect": elem, "Duration": LinkUtils.parseAttributeFloat(elem, "@duration")});
            proj.EffectsId.push(ConditionEffect.getConditionEffectFromName(LinkUtils.parseElementString(elem, "ConditionEffect")));
        }

        proj.ChanceEffects = [];
        for each (elem in xml.elements("CondChance")) {
            proj.ChanceEffects.push({"Effect": LinkUtils.parseAttributeString(elem, "@effect"), "Duration": LinkUtils.parseAttributeFloat(elem, "@duration"), "Chance": LinkUtils.parseAttributeFloat(elem, "@chance")});
        }

        return proj;
    }

    public function clone(): ProjectileData {
        var proj:ProjectileData = new ProjectileData();
        proj.BulletType = BulletType;
        proj.ObjectId = ObjectId;
        proj.LifetimeMS = LifetimeMS;
        proj.Speed = Speed;
        proj.Size = Size;
        proj.MinDamage = MinDamage;
        proj.MaxDamage = MaxDamage;
        proj.MultiHit = MultiHit;
        proj.PassesCover = PassesCover;
        proj.ArmorPiercing = ArmorPiercing;
        proj.ParticleTrail = ParticleTrail;
        proj.ParticleTrailIntensity = ParticleTrailIntensity;
        proj.ParticleTrailLifetimeMS = ParticleTrailLifetimeMS;
        proj.ParticleTrailColor = ParticleTrailColor;
        proj.Wavy = Wavy;
        proj.Parametric = Parametric;
        proj.Boomerang = Boomerang;
        proj.Amplitude = Amplitude;
        proj.Frequency = Frequency;
        proj.Magnitude = Magnitude;
        proj.FaceDir = FaceDir;
        proj.NoRotation = NoRotation;
        proj.Effects = Effects;// Shallow Copy
        proj.EffectsId = EffectsId;// Shallow Copy
        proj.ChanceEffects = ChanceEffects;// Shallow Copy
        return proj;
    }
}
}
