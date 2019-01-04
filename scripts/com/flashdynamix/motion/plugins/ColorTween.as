package com.flashdynamix.motion.plugins
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public class ColorTween extends AbstractTween
   {
       
      
      private var _current:ColorTransform;
      
      protected var _to:ColorTransform;
      
      protected var _from:ColorTransform;
      
      var displayObject:DisplayObject;
      
      public function ColorTween()
      {
         super();
         this._to = new ColorTransform();
         this._from = new ColorTransform();
      }
      
      override public function construct(... rest) : void
      {
         super.construct();
         this._current = rest[0];
         this.displayObject = rest[1];
         this.apply();
      }
      
      override protected function set to(param1:Object) : void
      {
         this._to = param1 as ColorTransform;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1 as ColorTransform;
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
         return !!this.displayObject?this.displayObject:this.current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is ColorTween && (this.current == param1.current || (param1 as ColorTween).displayObject != null && this.displayObject == (param1 as ColorTween).displayObject);
      }
      
      override public function toTarget(param1:Object) : void
      {
         var _loc2_:ColorTransform = null;
         if(param1 is ColorTransform)
         {
            _loc2_ = param1 as ColorTransform;
            add("redOffset",_loc2_.redOffset,false);
            add("blueOffset",_loc2_.blueOffset,false);
            add("greenOffset",_loc2_.greenOffset,false);
            add("alphaOffset",_loc2_.alphaOffset,false);
            add("redMultiplier",_loc2_.redMultiplier,false);
            add("blueMultiplier",_loc2_.blueMultiplier,false);
            add("greenMultiplier",_loc2_.greenMultiplier,false);
            add("alphaMultiplier",_loc2_.alphaMultiplier,false);
         }
         else
         {
            super.toTarget(param1);
         }
      }
      
      override public function fromTarget(param1:Object) : void
      {
         var _loc2_:ColorTransform = null;
         if(param1 is ColorTransform)
         {
            _loc2_ = param1 as ColorTransform;
            add("redOffset",_loc2_.redOffset,true);
            add("blueOffset",_loc2_.blueOffset,true);
            add("greenOffset",_loc2_.greenOffset,true);
            add("alphaOffset",_loc2_.alphaOffset,true);
            add("redMultiplier",_loc2_.redMultiplier,true);
            add("blueMultiplier",_loc2_.blueMultiplier,true);
            add("greenMultiplier",_loc2_.greenMultiplier,true);
            add("alphaMultiplier",_loc2_.alphaMultiplier,true);
         }
         else
         {
            super.toTarget(param1);
         }
      }
      
      override public function update(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc2_:Number = 1 - param1;
         if(!inited && _propCount > 0)
         {
            if(this.displayObject)
            {
               this._current = this.displayObject.transform.colorTransform;
               this._from = this.displayObject.transform.colorTransform;
            }
            else
            {
               for(_loc3_ in propNames)
               {
                  this._from[_loc3_] = this._current[_loc3_];
               }
            }
            inited = true;
         }
         for(_loc3_ in propNames)
         {
            if(_loc3_ == "redOffset")
            {
               this._current.redOffset = this._from.redOffset * _loc2_ + this._to.redOffset * param1;
            }
            else if(_loc3_ == "redMultiplier")
            {
               this._current.redMultiplier = this._from.redMultiplier * _loc2_ + this._to.redMultiplier * param1;
            }
            else if(_loc3_ == "greenOffset")
            {
               this._current.greenOffset = this._from.greenOffset * _loc2_ + this._to.greenOffset * param1;
            }
            else if(_loc3_ == "greenMultiplier")
            {
               this._current.greenMultiplier = this._from.greenMultiplier * _loc2_ + this._to.greenMultiplier * param1;
            }
            else if(_loc3_ == "blueOffset")
            {
               this._current.blueOffset = this._from.blueOffset * _loc2_ + this._to.blueOffset * param1;
            }
            else if(_loc3_ == "blueMultiplier")
            {
               this._current.blueMultiplier = this._from.blueMultiplier * _loc2_ + this._to.blueMultiplier * param1;
            }
            else if(_loc3_ == "alphaOffset")
            {
               this._current.alphaOffset = this._from.alphaOffset * _loc2_ + this._to.alphaOffset * param1;
            }
            else if(_loc3_ == "alphaMultiplier")
            {
               this._current.alphaMultiplier = this._from.alphaMultiplier * _loc2_ + this._to.alphaMultiplier * param1;
            }
            else
            {
               this._current[_loc3_] = this._from[_loc3_] * _loc2_ + this._to[_loc3_] * param1;
            }
            if(timeline.snapToClosest)
            {
               this._current[_loc3_] = Math.round(this._current[_loc3_]);
            }
         }
         this.apply();
      }
      
      override public function apply() : void
      {
         if(this.displayObject == null)
         {
            return;
         }
         this.displayObject.transform.colorTransform = this._current;
      }
      
      override public function dispose() : void
      {
         this._to = null;
         this._from = null;
         this.displayObject = null;
         this._current = null;
         super.dispose();
      }
   }
}
