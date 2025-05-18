package com.company.assembleegameclient.map {
import com.company.util.GraphicsUtil;

import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.IGraphicsData;
import flash.display.Shape;

public class HurtOverlay extends Shape {


    private const s:Number = 600 / Math.sin(Math.PI / 4);

    private const gradientFill_:GraphicsGradientFill = new GraphicsGradientFill(GradientType.RADIAL, [16777215, 16777215, 16777215], [0, 0, 0.92], [0, 155, 255], GraphicsUtil.getGradientMatrix(s, s, 0, (600 - s) / 2, (600 - s) / 2));

    public function HurtOverlay() {
        super();
        graphics.drawGraphicsData(new <IGraphicsData>[gradientFill_, GraphicsUtil.getRectPath(0, 0, 600, GameClient.StageHeight), GraphicsUtil.END_FILL]);
        visible = false;
    }
}
}
