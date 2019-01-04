package com.flashdynamix.motion.extras
{
   import com.flashdynamix.motion.TweensyGroup;
   import com.flashdynamix.motion.TweensyTimeline;
   import com.flashdynamix.motion.guides.Direction2D;
   import com.flashdynamix.utils.MultiTypeObjectPool;
   import fl.motion.easing.Linear;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   
   public class Emitter extends Sprite
   {
       
      
      public var startDistance:Number = 0;
      
      public var angle;
      
      public var distance;
      
      public var speed:Number;
      
      public var frequency:int;
      
      public var random:Number;
      
      public var target:Object;
      
      public var ease:Function;
      
      public var delay:Number = 0;
      
      public var endColor:ColorTransform;
      
      public var running:Boolean = false;
      
      public var holder:Sprite;
      
      private var tween:TweensyGroup;
      
      private var pool:MultiTypeObjectPool;
      
      private var Particle:Class;
      
      public function Emitter(param1:Class, param2:Object = null, param3:int = 5, param4:Number = 1, param5:* = "0,360", param6:* = 20, param7:Number = 1, param8:String = "normal")
      {
         this.ease = Linear.easeNone;
         super();
         this.Particle = param1;
         this.target = param2;
         this.frequency = param3;
         this.random = param4;
         this.angle = param5;
         this.distance = param6;
         this.speed = param7;
         this.blendMode = param8;
         this.holder = new Sprite();
         this.tween = new TweensyGroup(false,true);
         this.pool = new MultiTypeObjectPool(TweensyTimeline,param1);
         this.start();
      }
      
      public function set scale(param1:Number) : void
      {
         this.scaleY = this.scaleX = param1;
      }
      
      public function get scale() : Number
      {
         return this.scaleY;
      }
      
      public function set secondsPerFrame(param1:Number) : void
      {
         this.tween.secondsPerFrame = param1;
      }
      
      public function get secondsPerFrame() : Number
      {
         return this.tween.secondsPerFrame;
      }
      
      public function set refreshType(param1:String) : void
      {
         this.tween.refreshType = param1;
      }
      
      public function get refreshType() : String
      {
         return this.tween.refreshType;
      }
      
      public function pause() : void
      {
         this.tween.pause();
      }
      
      public function resume() : void
      {
         this.tween.resume();
      }
      
      public function start() : void
      {
         if(this.running)
         {
            return;
         }
         this.running = true;
         this.addEvent(this,Event.ENTER_FRAME,this.draw);
      }
      
      public function stop() : void
      {
         if(!this.running)
         {
            return;
         }
         this.running = false;
         this.removeEvent(this,Event.ENTER_FRAME,this.draw);
      }
      
      public function clone() : Emitter
      {
         return new Emitter(this.Particle,this.target,this.frequency,this.random,this.angle,this.distance,this.speed,blendMode);
      }
      
      private function draw(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         if(this.random < Math.random() || this.tween.paused)
         {
            return;
         }
         var _loc2_:TweensyTimeline = this.pool.checkOut(TweensyTimeline);
         _loc2_.duration = this.speed;
         _loc2_.ease = this.ease;
         _loc2_.delayStart = this.delay;
         var _loc3_:Array = [];
         var _loc4_:Object = {"position":1};
         _loc5_ = 0;
         while(_loc5_ < this.frequency)
         {
            _loc6_ = this.pool.checkOut(this.Particle) as DisplayObject;
            _loc6_.blendMode = this.blendMode;
            _loc6_.transform = this.transform;
            if(this.target)
            {
               _loc2_.to(_loc6_,this.target,null);
            }
            _loc2_.to(new Direction2D(_loc6_,this.angle,this.distance,this.startDistance),_loc4_);
            if(this.endColor)
            {
               _loc2_.to(_loc6_.transform.colorTransform,this.endColor,_loc6_);
            }
            _loc3_[_loc5_] = _loc6_;
            this.holder.addChild(_loc6_);
            _loc5_++;
         }
         if(_loc2_.tweens > 0)
         {
            _loc2_.onComplete = this.removeChildren;
            _loc2_.onCompleteParams = _loc3_;
            this.tween.add(_loc2_);
         }
      }
      
      private function removeChildren(... rest) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc2_:int = rest.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = rest[_loc4_];
            this.holder.removeChild(_loc3_);
            this.pool.checkIn(_loc3_);
            _loc4_++;
         }
      }
      
      protected function addEvent(param1:EventDispatcher, param2:String, param3:Function, param4:int = 0, param5:Boolean = true) : void
      {
         param1.addEventListener(param2,param3,false,param4,param5);
      }
      
      protected function removeEvent(param1:EventDispatcher, param2:String, param3:Function) : void
      {
         param1.removeEventListener(param2,param3);
      }
      
      public function dispose() : void
      {
         this.pool.dispose();
         this.tween.dispose();
         this.holder = null;
         this.pool = null;
         this.tween = null;
         this.endColor = null;
         this.target = null;
      }
   }
}
