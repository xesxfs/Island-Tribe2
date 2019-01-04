package com.flashdynamix.motion.guides
{
   public class Direction2D
   {
       
      
      public var item:Object;
      
      public var autoRotate:Boolean = false;
      
      private var sx:Number;
      
      private var sy:Number;
      
      private var _angle:Number;
      
      private var _distance:Number;
      
      private var _position:Number = 0;
      
      private var cosA:Number;
      
      private var sinA:Number;
      
      private var degreeRad:Number = 0.017453292519943295;
      
      private var radDegree:Number = 57.29577951308232;
      
      public function Direction2D(param1:Object, param2:*, param3:*, param4:* = 0, param5:Boolean = false)
      {
         super();
         this.item = param1;
         this._angle = this.translate(param2) * this.degreeRad;
         this._distance = this.translate(param3);
         this.cosA = Math.cos(this._angle);
         this.sinA = Math.sin(this._angle);
         var _loc6_:Number = this.translate(param4);
         param1.x = param1.x + this.cosA * _loc6_;
         param1.y = param1.y + this.sinA * _loc6_;
         this.sx = param1.x;
         this.sy = param1.y;
         if(param5)
         {
            param1.rotation = this._angle * this.radDegree;
         }
      }
      
      public function set position(param1:Number) : void
      {
         this._position = param1;
         this.update();
      }
      
      public function get position() : Number
      {
         return this._position;
      }
      
      public function set angle(param1:Number) : void
      {
         this._angle = param1 * this.degreeRad;
         this.cosA = Math.cos(this._angle);
         this.sinA = Math.sin(this._angle);
         if(this.autoRotate)
         {
            this.item.rotation = this._angle * this.radDegree;
         }
         this.update();
      }
      
      public function get angle() : Number
      {
         return this._angle * this.radDegree;
      }
      
      public function set distance(param1:Number) : void
      {
         this._distance = param1;
         this.update();
      }
      
      public function get endX() : Number
      {
         return this.sx + this.cosA * this.distance;
      }
      
      public function get endY() : Number
      {
         return this.sy + this.sinA * this.distance;
      }
      
      public function get distance() : Number
      {
         return this._distance;
      }
      
      private function translate(param1:*) : Number
      {
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1 is String)
         {
            _loc2_ = String(param1).split(",");
            if(_loc2_.length == 1)
            {
               return parseFloat(param1);
            }
            _loc3_ = parseFloat(_loc2_[0]);
            _loc4_ = parseFloat(_loc2_[1]);
            return _loc3_ + Math.random() * (_loc4_ - _loc3_);
         }
         return param1;
      }
      
      private function update() : void
      {
         var _loc1_:Number = this.distance * this._position;
         this.item.x = this.sx + this.cosA * _loc1_;
         this.item.y = this.sy + this.sinA * _loc1_;
      }
   }
}
