package com.flashdynamix.motion.effects.core
{
   import com.flashdynamix.motion.effects.IEffect;
   import flash.display.BitmapData;
   import flash.filters.BitmapFilter;
   import flash.geom.Point;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public class FilterEffect extends Proxy implements IEffect
   {
       
      
      public var filter:BitmapFilter;
      
      public var pt:Point;
      
      public function FilterEffect(param1:BitmapFilter)
      {
         this.pt = new Point();
         super();
         this.filter = param1;
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         this.filter[param1] = param2;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this.filter[param1];
      }
      
      public function render(param1:BitmapData) : void
      {
         param1.applyFilter(param1,param1.rect,this.pt,this.filter);
      }
   }
}
