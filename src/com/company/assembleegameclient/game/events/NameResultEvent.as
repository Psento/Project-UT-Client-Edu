package com.company.assembleegameclient.game.events {
import flash.events.Event;

public class NameResultEvent extends Event {

    public static const NAMERESULTEVENT:String = "NAMERESULTEVENT";


    public var m_:NameResult;

    public function NameResultEvent(m:NameResult) {
        super(NAMERESULTEVENT);
        this.m_ = m;
    }
}
}
