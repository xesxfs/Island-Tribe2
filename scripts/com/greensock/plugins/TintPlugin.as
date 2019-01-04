package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Transform;
   
   public class TintPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
       
      
      protected var _transform:Transform;
      
      protected var _ct:ColorTransform;
      
      protected var _ignoreAlpha:Boolean;
      
      public function TintPlugin()
      {
         super();
         this.propName = "tint";
         this.overwriteProps = ["tint"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is DisplayObject))
         {
            return false;
         }
         var _loc4_:ColorTransform = new ColorTransform();
         if(param2 != null && param3.vars.removeTint != true)
         {
            _loc4_.color = uint(param2);
         }
         this._ignoreAlpha = true;
         this._transform = DisplayObject(param1).transform;
         this.init(this._transform.colorTransform,_loc4_);
         return true;
      }
      
      public function init(param1:ColorTransform, param2:ColorTransform) : void
      {
         var _loc4_:String = null;
         this._ct = param1;
         var _loc3_:int = _props.length;
         var _loc5_:int = _tweens.length;
         while(_loc3_--)
         {
            _loc4_ = _props[_loc3_];
            if(this._ct[_loc4_] != param2[_loc4_])
            {
               _tweens[_loc5_++] = new PropTween(this._ct,_loc4_,this._ct[_loc4_],param2[_loc4_] - this._ct[_loc4_],"tint",false);
            }
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:ColorTransform = null;
         updateTweens(param1);
         if(this._transform)
         {
            if(this._ignoreAlpha)
            {
               _loc2_ = this._transform.colorTransform;
               this._ct.alphaMultiplier = _loc2_.alphaMultiplier;
               this._ct.alphaOffset = _loc2_.alphaOffset;
            }
            this._transform.colorTransform = this._ct;
         }
      }
   }
}
