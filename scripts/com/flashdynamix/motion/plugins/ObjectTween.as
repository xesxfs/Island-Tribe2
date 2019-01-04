package com.flashdynamix.motion.plugins
{
   public class ObjectTween extends AbstractTween
   {
       
      
      private var _current:Object;
      
      protected var _to:Object;
      
      protected var _from:Object;
      
      public function ObjectTween()
      {
         super();
         this._to = {};
         this._from = {};
      }
      
      override public function construct(... rest) : void
      {
         super.construct();
         this._current = rest[0];
      }
      
      override protected function set to(param1:Object) : void
      {
         this._to = param1;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1;
      }
      
      override protected function get from() : Object
      {
         return this._from;
      }
      
      override public function get current() : Object
      {
         return this._current;
      }
      
      override public function get instance() : Object
      {
         return this._current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is ObjectTween && super.match(param1);
      }
      
      override public function update(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc2_:Number = 1 - param1;
         if(!inited && _propCount > 0)
         {
            for(_loc3_ in propNames)
            {
               this._from[_loc3_] = this._current[_loc3_];
            }
            inited = true;
         }
         for(_loc3_ in propNames)
         {
            this._current[_loc3_] = this.from[_loc3_] * _loc2_ + this.to[_loc3_] * param1;
            if(timeline.snapToClosest)
            {
               this._current[_loc3_] = Math.round(this._current[_loc3_]);
            }
         }
      }
      
      override public function dispose() : void
      {
         this._to = null;
         this._from = null;
         this._current = null;
         super.dispose();
      }
   }
}
