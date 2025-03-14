package svera.untiered.assets {
public class EmbeddedData {
    // Svera System
    [Embed(source="Xmls/Environment_Ground.xml", mimeType="application/octet-stream")]
    private static const Environment_Ground:Class;
    [Embed(source="Xmls/Environment_Objects.xml", mimeType="application/octet-stream")]
    private static const Environment_Objects:Class;
    // Old System
    [Embed(source="Xmls/Players.xml", mimeType="application/octet-stream")]
    public static const Players:Class;
    [Embed(source="Xmls/Skins.xml", mimeType="application/octet-stream")]
    private static const Skins:Class;
    [Embed(source="Xmls/Dyes.xml", mimeType="application/octet-stream")]
    private static const Dyes:Class;
    [Embed(source="Xmls/Textiles.xml", mimeType="application/octet-stream")]
    private static const Textiles:Class;
    [Embed(source="Xmls/Regions.xml", mimeType="application/octet-stream")]
    private static const Regions:Class;


    public static const groundFiles:Array = [new Environment_Ground()];
    public static const skinsXML:XML = XML(new Skins());
    public static const objectFiles:Array = [new Environment_Objects(), new Dyes(), new Textiles(), new Players()];
    public static const regionFiles:Array = [new Regions()];


    public function EmbeddedData() {
        super();
    }
}
}
