package com.flashdynamix.motion.effects.core
{
   import com.flashdynamix.motion.effects.IEffect;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class DrawEffect implements IEffect
   {
       
      
      public var source:IBitmapDrawable;
      
      public var matrix:Matrix;
      
      public var colorTransform:ColorTransform;
      
      public var blendMode:String = "normal";
      
      public var rect:Rectangle;
      
      public var smoothing:Boolean = false;
      
      public function DrawEffect(param1:IBitmapDrawable, param2:Matrix = null, param3:Rectangle = null, param4:ColorTransform = null, param5:String = "normal", param6:Boolean = false)
      {
         super();
         this.source = param1;
         this.matrix = param2 == null?new Matrix():param2;
         this.colorTransform = param4 == null?new ColorTransform():param4;
         this.blendMode = param5;
         this.rect = param3;
         this.smoothing = param6;
      }
      
      public function render(param1:BitmapData) : void
      {
         param1.draw(this.source,this.matrix,this.colorTransform,this.blendMode,this.rect,this.smoothing);
      }
   }
}
