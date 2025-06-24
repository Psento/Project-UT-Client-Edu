package com.company.assembleegameclient.appengine {
import com.company.assembleegameclient.util.HonorUtil;

public class CharacterStats {


    public var charStatsXML_:XML;

    public function CharacterStats(charStatsXML:XML) {
        super();
        this.charStatsXML_ = charStatsXML;
    }

    public function bestLevel():int {
        return this.charStatsXML_.BestLevel;
    }

    public function bestHonor():int {
        return this.charStatsXML_.BestHonor;
    }

    public function numStars():int {
        return HonorUtil.numStars(int(this.charStatsXML_.BestHonor));
    }
}
}
