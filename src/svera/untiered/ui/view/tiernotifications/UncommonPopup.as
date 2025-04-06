package svera.untiered.ui.view.tiernotifications {

import mx.core.*;

import mx.core.BitmapAsset;

import svera.lib.util.GIF;

public class UncommonPopup extends GIF {
    [Embed(source="uncommon/Uncommon_Frame_1.png")]
    private const Uncommon_frame_1:Class;
    [Embed(source="uncommon/Uncommon_Frame_2.png")]
    private const Uncommon_frame_2:Class;
    [Embed(source="uncommon/Uncommon_Frame_3.png")]
    private const Uncommon_frame_3:Class;
    [Embed(source="uncommon/Uncommon_Frame_4.png")]
    private const Uncommon_frame_4:Class;
    [Embed(source="uncommon/Uncommon_Frame_5.png")]
    private const Uncommon_frame_5:Class;
    [Embed(source="uncommon/Uncommon_Frame_6.png")]
    private const Uncommon_frame_6:Class;
    [Embed(source="uncommon/Uncommon_Frame_7.png")]
    private const Uncommon_frame_7:Class;
    [Embed(source="uncommon/Uncommon_Frame_8.png")]
    private const Uncommon_frame_8:Class;
    [Embed(source="uncommon/Uncommon_Frame_9.png")]
    private const Uncommon_frame_9:Class;
    [Embed(source="uncommon/Uncommon_Frame_10.png")]
    private const Uncommon_frame_10:Class;
    [Embed(source="uncommon/Uncommon_Frame_11.png")]
    private const Uncommon_frame_11:Class;
    [Embed(source="uncommon/Uncommon_Frame_12.png")]
    private const Uncommon_frame_12:Class;
    [Embed(source="uncommon/Uncommon_Frame_13.png")]
    private const Uncommon_frame_13:Class;
    [Embed(source="uncommon/Uncommon_Frame_14.png")]
    private const Uncommon_frame_14:Class;
    [Embed(source="uncommon/Uncommon_Frame_15.png")]
    private const Uncommon_frame_15:Class;
    [Embed(source="uncommon/Uncommon_Frame_16.png")]
    private const Uncommon_frame_16:Class;

    public function UncommonPopup() {
        super(100, new <BitmapAsset>[
            new this.Uncommon_frame_1 as BitmapAsset,
            new this.Uncommon_frame_2 as BitmapAsset,
            new this.Uncommon_frame_3 as BitmapAsset,
            new this.Uncommon_frame_4 as BitmapAsset,
            new this.Uncommon_frame_5 as BitmapAsset,
            new this.Uncommon_frame_6 as BitmapAsset,
            new this.Uncommon_frame_7 as BitmapAsset,
            new this.Uncommon_frame_8 as BitmapAsset,
            new this.Uncommon_frame_9 as BitmapAsset,
            new this.Uncommon_frame_10 as BitmapAsset,
            new this.Uncommon_frame_11 as BitmapAsset,
            new this.Uncommon_frame_12 as BitmapAsset,
            new this.Uncommon_frame_13 as BitmapAsset,
            new this.Uncommon_frame_14 as BitmapAsset,
            new this.Uncommon_frame_15 as BitmapAsset,
            new this.Uncommon_frame_16 as BitmapAsset
        ]);
    }
}
}