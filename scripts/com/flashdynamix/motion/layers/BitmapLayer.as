package com.flashdynamix.motion.layers
{
   import com.flashdynamix.motion.effects.IEffect;
   import com.flashdynamix.motion.effects.core.DrawEffect;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.display.PixelSnapping;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class BitmapLayer extends Bitmap
   {
       
      
      public var list:Array;
      
      public var clearOnRender:Boolean = false;
      
      public var bgColor:uint;
      
      public var transparent:Boolean = false;
      
      private var running:Boolean = false;
      
      private var _scale:Number = 1;
      
      public function BitmapLayer(param1:Number = 500, param2:Number = 500, param3:Number = 1, param4:uint = 16777215, param5:Boolean = true, param6:Boolean = false)
      {
         this.list = [];
         super(new BitmapData(param1 / param3,param2 / param3,param5,param4),PixelSnapping.AUTO,param6);
         this.bgColor = param4;
         this.transparent = param5;
         this._scale = param3;
         super.scaleY = super.scaleX = this._scale;
         this.startRender();
      }
      
      override public function set smoothing(param1:Boolean) : void
      {
         super.smoothing = param1;
         this.updateEffects();
      }
      
      override public function get smoothing() : Boolean
      {
         return super.smoothing;
      }
      
      public function set scale(param1:Number) : void
      {
         var _loc2_:Number = this._scale / 1;
         super.scaleY = super.scaleX = param1;
         this._scale = param1;
         bitmapData = new BitmapData(bitmapData.width * _loc2_ / this._scale,bitmapData.height * _loc2_ / this._scale,this.transparent,this.bgColor);
         this.updateEffects();
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function set layerWidth(param1:int) : void
      {
         bitmapData = new BitmapData(param1 / this._scale,bitmapData.height,this.transparent,this.bgColor);
         this.updateEffects();
      }
      
      public function get layerWidth() : int
      {
         return bitmapData.width;
      }
      
      public function set layerHeight(param1:int) : void
      {
         bitmapData = new BitmapData(bitmapData.width,param1 / this._scale,this.transparent,this.bgColor);
         this.updateEffects();
      }
      
      public function get layerHeight() : int
      {
         return bitmapData.height;
      }
      
      public function get length() : int
      {
         return this.list.length;
      }
      
      public function add(param1:IEffect) : IEffect
      {
         this.list.push(param1);
         return param1;
      }
      
      public function remove(param1:IEffect) : Boolean
      {
         var _loc2_:int = this.list.indexOf(param1);
         if(_loc2_ == -1)
         {
            return false;
         }
         this.list.splice(_loc2_,1);
         return true;
      }
      
      public function clear() : void
      {
         this.list.length = 0;
      }
      
      public function item(param1:int) : IEffect
      {
         return this.list[param1];
      }
      
      public function draw(param1:IBitmapDrawable, param2:Matrix = null, param3:Rectangle = null, param4:ColorTransform = null, param5:String = "normal") : DrawEffect
      {
         if(param3 == null)
         {
            param3 = this.bitmapData.rect;
         }
         if(param2 == null)
         {
            param2 = new Matrix();
            param2.scale(1 / this._scale,1 / this._scale);
         }
         var _loc6_:DrawEffect = new DrawEffect(param1,param2,param3,param4,param5,this.smoothing);
         this.add(_loc6_);
         return _loc6_;
      }
      
      public function startRender() : void
      {
         if(this.running)
         {
            return;
         }
         this.running = true;
         this.addEvent(this,Event.ENTER_FRAME,this.render);
      }
      
      public function stopRender() : void
      {
         if(!this.running)
         {
            return;
         }
         this.running = false;
         this.removeEvent(this,Event.ENTER_FRAME,this.render);
      }
      
      public function render(param1:Event = null) : void
      {
         var _loc3_:int = 0;
         bitmapData.lock();
         if(this.clearOnRender)
         {
            bitmapData.fillRect(bitmapData.rect,this.bgColor);
         }
         var _loc2_:int = this.list.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            IEffect(this.list[_loc3_]).render(bitmapData);
            _loc3_++;
         }
         bitmapData.unlock();
      }
      
      protected function addEvent(param1:EventDispatcher, param2:String, param3:Function, param4:int = 0, param5:Boolean = true) : void
      {
         param1.addEventListener(param2,param3,false,param4,param5);
      }
      
      protected function removeEvent(param1:EventDispatcher, param2:String, param3:Function) : void
      {
         param1.removeEventListener(param2,param3);
      }
      
      protected function updateEffects() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DrawEffect = null;
         var _loc1_:int = this.list.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.list[_loc2_] as DrawEffect;
            if(_loc3_)
            {
               _loc3_.rect = bitmapData.rect;
               _loc3_.matrix.d = _loc3_.matrix.a = 1 / this._scale;
               _loc3_.smoothing = this.smoothing;
            }
            _loc2_++;
         }
         this.render();
      }
      
      public function dispose() : void
      {
         this.stopRender();
         this.list = null;
      }
      
      override public function toString() : String
      {
         return "BitmapLayer {length:" + this.length + "}";
      }
   }
}
