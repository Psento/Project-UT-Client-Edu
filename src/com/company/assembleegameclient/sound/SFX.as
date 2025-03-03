package com.company.assembleegameclient.sound {
import com.company.assembleegameclient.parameters.Parameters;

public class SFX {
    public function SFX() {
        super();
    }

    public static function setPlaySFX(playSFX:Boolean):void {
        Parameters.data_.playSFX = playSFX;
        Parameters.save();
    }
}
}
