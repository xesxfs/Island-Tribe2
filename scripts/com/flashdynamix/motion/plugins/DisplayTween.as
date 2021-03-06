package com.flashdynamix.motion.plugins
{
   import flash.display.DisplayObject;
   
   public class DisplayTween extends AbstractTween
   {
       
      
      private var _current:DisplayObject;
      
      protected var _to:DisplayTweenObject;
      
      protected var _from:DisplayTweenObject;
      
      public function DisplayTween()
      {
         super();
         this._to = new DisplayTweenObject();
         this._from = new DisplayTweenObject();
      }
      
      override public function construct(... rest) : void
      {
         super.construct();
         this._current = rest[0];
      }
      
      override protected function set to(param1:Object) : void
      {
         this._to = param1 as DisplayTweenObject;
      }
      
      override protected function get to() : Object
      {
         return this._to;
      }
      
      override protected function set from(param1:Object) : void
      {
         this._from = param1 as DisplayTweenObject;
      }
      
      override protected function get from() : Object
      {
         return this._from;
      }
      
      override public function get current() : Object
      {
         return this._current;
      }
      
      override public function match(param1:AbstractTween) : Boolean
      {
         return param1 is DisplayTween && super.match(param1);
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
            if(_loc3_ == "x")
            {
               this._current.x = this._from.x * _loc2_ + this._to.x * param1;
            }
            else if(_loc3_ == "y")
            {
               this._current.y = this._from.y * _loc2_ + this._to.y * param1;
            }
            else if(_loc3_ == "width")
            {
               this._current.width = this._from.width * _loc2_ + this._to.width * param1;
            }
            else if(_loc3_ == "height")
            {
               this._current.height = this._from.height * _loc2_ + this._to.height * param1;
            }
            else if(_loc3_ == "scaleX")
            {
               this._current.scaleX = this._from.scaleX * _loc2_ + this._to.scaleX * param1;
            }
            else if(_loc3_ == "scaleY")
            {
               this._current.scaleY = this._from.scaleY * _loc2_ + this._to.scaleY * param1;
            }
            else if(_loc3_ == "alpha")
            {
               this._current.alpha = this._from.alpha * _loc2_ + this._to.alpha * param1;
            }
            else if(_loc3_ == "rotation")
            {
               this._current.rotation = this._from.rotation * _loc2_ + this._to.rotation * param1;
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
      }
      
      override protected function translate(param1:String, param2:*) : Number
      {
         var _loc3_:Number = this._current[param1];
         var _loc4_:Number = super.translate(param1,param2);
         if(param1 == "rotation" && timeline.smartRotate)
         {
            _loc4_ = smartRotate(_loc3_,_loc4_);
         }
         return _loc4_;
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

dynamic class DisplayTweenObject
{
    
   
   public var x:Number;
   
   public var y:Number;
   
   public var alpha:Number;
   
   public var width:Number;
   
   public var height:Number;
   
   public var scaleX:Number;
   
   public var scaleY:Number;
   
   public var rotation:Number;
   
   function DisplayTweenObject()
   {
      super();
   }
}
