package com.flashdynamix.motion.effects.core
{
   import com.flashdynamix.motion.effects.IEffect;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public class ColorEffect extends Proxy implements IEffect
   {
       
      
      public var colorTransform:ColorTransform;
      
      public function ColorEffect(param1:ColorTransform)
      {
         super();
         this.colorTransform = param1;
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         this.colorTransform[param1] = param2;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this.colorTransform[param1];
      }
      
      public function render(param1:BitmapData) : void
      {
         param1.colorTransform(param1.rect,this.colorTransform);
      }
   }
}
