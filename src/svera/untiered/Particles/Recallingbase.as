package svera.untiered.Particles {
import svera.lib.util.GIF;

import mx.core.*;

import mx.core.BitmapAsset;

public class Recallingbase extends GIF {
    [Embed(source="Recallingbase_0.png")]
    private const Recallingbase_0:Class;
    [Embed(source="Recallingbase_1.png")]
    private const Recallingbase_1:Class;
    [Embed(source="Recallingbase_2.png")]
    private const Recallingbase_2:Class;
    [Embed(source="Recallingbase_3.png")]
    private const Recallingbase_3:Class;
    [Embed(source="Recallingbase_00.png")]
    private const Recallingbase_00:Class;
    [Embed(source="Recallingbase_11.png")]
    private const Recallingbase_11:Class;
    [Embed(source="Recallingbase_22.png")]
    private const Recallingbase_22:Class;
    [Embed(source="Recallingbase_33.png")]
    private const Recallingbase_33:Class;

    public function Recallingbase() {
        super(100, new <BitmapAsset>[
            new this.Recallingbase_0 as BitmapAsset,
            new this.Recallingbase_1 as BitmapAsset,
            new this.Recallingbase_2 as BitmapAsset,
            new this.Recallingbase_3 as BitmapAsset,
            new this.Recallingbase_00 as BitmapAsset,
            new this.Recallingbase_11 as BitmapAsset,
            new this.Recallingbase_22 as BitmapAsset,
            new this.Recallingbase_33 as BitmapAsset
        ]);
    }
}
}