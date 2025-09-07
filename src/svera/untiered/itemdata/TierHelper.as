package svera.untiered.itemdata {
import com.company.ui.SimpleText;

public class TierHelper {

    // Untiered Tiers
    public static const COMMON_COLOR:uint = 0x69747a;

    public static const UNCOMMON_COLOR:uint = 0x177e2b;

    public static const TARNISHED_COLOR:uint = 0x224a98;

    public static const ARTIFACT_COLOR:uint = 0x45c3ff;

    public static const ANCESTRAL_COLOR:uint = 0xbc4a9b;

    public static const VALIANT_COLOR:uint = 0xffd647;

    public static const RELIC_COLOR:uint = 0x73172D;

    public static const EXILED_COLOR:uint = 0xeb015f;

    public static const CELESTIAL_COLOR:uint = 0xd1d3ea;

    public static function setTierText(text:SimpleText, tier:String): Boolean {
        switch (tier) {
            case "Celestial":
                text.setColor(CELESTIAL_COLOR);
                text.text = "CL";
                return true;
            case "Exiled":
                text.setColor(EXILED_COLOR);
                text.text = "EX";
                return true;
            case "Relic":
                text.setColor(RELIC_COLOR);
                text.text = "R";
                return true;
            case "Valiant":
                text.setColor(VALIANT_COLOR);
                text.text = "VL";
                return true;
            case "Ancestral":
                text.setColor(ANCESTRAL_COLOR);
                text.text = "AN";
                return true;
            case "Artifact":
                text.setColor(ARTIFACT_COLOR);
                text.text = "A";
                return true;
            case "Tarnished":
                text.setColor(TARNISHED_COLOR);
                text.text = "T";
                return true;
            case "Uncommon":
                text.setColor(UNCOMMON_COLOR);
                text.text = "UC";
                return true;
            case "Stat":
                text.setColor(16777215);
                text.text = "S";
                return true;
            case "Common":
                text.setColor(COMMON_COLOR);
                text.text = "C";
                return true;
            default:
                return false;
        }
    }
}
}
