package svera.untiered.assets {
public class EmbeddedData {
    // Svera System
    [Embed(source="Xmls/Tiles_Shared.xml", mimeType="application/octet-stream")]
    private static const Environment_Ground:Class;
    [Embed(source="Xmls/Objects_Shared.xml", mimeType="application/octet-stream")]
    private static const Environment_Objects:Class;
    [Embed(source="Xmls/Objects_Tavern.xml", mimeType="application/octet-stream")]
    private static const Tavern_Objects:Class;
    [Embed(source="Xmls/Objects_Foundry.xml", mimeType="application/octet-stream")]
    private static const Objects_Foundry:Class;
    [Embed(source="Xmls/Tiles_Foundry.xml", mimeType="application/octet-stream")]
    private static const Tiles_Foundry:Class;
    [Embed(source="Xmls/Tiles_Tavern.xml", mimeType="application/octet-stream")]
    private static const Tiles_Tavern:Class;
    [Embed(source="Xmls/Containers.xml", mimeType="application/octet-stream")]
    private static const Containers:Class;

    [Embed(source="Xmls/Consumables_Artifact.xml", mimeType="application/octet-stream")]
    private static const Consumables_Artifact:Class;
    [Embed(source="Xmls/Consumables_Exiled.xml", mimeType="application/octet-stream")]
    private static const Consumables_Exiled:Class;
    [Embed(source="Xmls/Consumables_Valiant.xml", mimeType="application/octet-stream")]
    private static const Consumables_Valiant:Class;
    [Embed(source="Xmls/Consumables_StatMaxing.xml", mimeType="application/octet-stream")]
    private static const Consumables_StatMaxing:Class;

    [Embed(source="Xmls/Crafting_LuckyDips.xml", mimeType="application/octet-stream")]
    private static const Crafting_LuckyDips:Class;

    [Embed(source="Xmls/Equipment_Starter.xml", mimeType="application/octet-stream")]
    private static const Equipment_Starter:Class;
    [Embed(source="Xmls/Equipment_Artifact.xml", mimeType="application/octet-stream")]
    private static const Equipment_Artifact:Class;
    [Embed(source="Xmls/Equipment_Exiled.xml", mimeType="application/octet-stream")]
    private static const Equipment_Exiled:Class;
    [Embed(source="Xmls/Equipment_Valiant.xml", mimeType="application/octet-stream")]
    private static const Equipment_Valiant:Class;

    [Embed(source="Xmls/Utilities_PetStones.xml", mimeType="application/octet-stream")]
    private static const Utilities_PetStones:Class;
    [Embed(source="Xmls/Utilities_Valiant.xml", mimeType="application/octet-stream")]
    private static const Utilities_Valiant:Class;

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


    public static const groundFiles:Array = [
        new Environment_Ground(),
        new Tiles_Foundry(),
        new Tiles_Tavern()
    ];
    public static const skinsXML:XML = XML(new Skins());
    public static const objectFiles:Array = [
        new Environment_Objects(),
        new Dyes(),
        new Textiles(),
        new Players(),
        new Objects_Foundry(),
        new Tavern_Objects(),
        new Containers(),
        new Equipment_Artifact(),
        new Equipment_Exiled(),
        new Equipment_Starter(),
        new Equipment_Valiant(),
        new Consumables_Artifact(),
        new Consumables_Exiled(),
        new Consumables_StatMaxing(),
        new Consumables_Valiant(),
        new Utilities_PetStones(),
        new Utilities_Valiant(),
        new Crafting_LuckyDips()
    ];
    public static const regionFiles:Array = [new Regions()];


    public function EmbeddedData() {
        super();
    }
}
}
