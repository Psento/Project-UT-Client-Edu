package com.company.assembleegameclient.util {
public class Currency {

    public static const INVALID:int = -1;

    public static const TSAVORITE:int = 0;
    public static const MEDALLIONS:int = 1;
    public static const HONOR:int = 2;

    public static const GUILD_FAME:int = 4;


    public function Currency() {
        super();
    }

    public static function typeToName(type:int):String {
        switch (type) {
            case TSAVORITE:
                return "Tsavorite";
            case MEDALLIONS:
                return "Medallions";
            case HONOR:
                return "Honor";
            case GUILD_FAME:
                return "Guild Honor";
            default:
                return "";
        }
    }
}
}
