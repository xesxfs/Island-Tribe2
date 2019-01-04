package logic
{
   import com.flashdynamix.motion.TweensyGroup;
   import com.flashdynamix.motion.effects.core.ColorEffect;
   import com.flashdynamix.motion.effects.core.FilterEffect;
   import com.flashdynamix.motion.extras.Emitter;
   import com.flashdynamix.motion.layers.BitmapLayer;
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class ExplorerGuy extends Sprite
   {
       
      
      protected var m_layer:Sprite = null;
      
      private var m_art:MovieClip = null;
      
      private var m_timer_cur:Number = -1;
      
      private var m_timer_max:Number = 0.0;
      
      private var m_fly_cur:Number = -1;
      
      private var m_fly_max:Number = 2.0;
      
      private var m_happy:MovieClip = null;
      
      private var m_normal:MovieClip = null;
      
      private var m_sad:MovieClip = null;
      
      private var m_fill:MovieClip = null;
      
      private var m_icon:Bitmap = null;
      
      private var m_icon_f:Bitmap = null;
      
      private var m_fly_from:Point = null;
      
      private var m_fx_tween:TweensyGroup;
      
      private var m_fx_emittor:Emitter;
      
      private var m_fx_layer:BitmapLayer;
      
      private var m_fx_ct:ColorTransform;
      
      private var m_fx_bf:BlurFilter;
      
      public function ExplorerGuy(param1:Sprite)
      {
         super();
         this.m_layer = param1;
         this.m_art = new artExplorerGuy();
         this.addChild(this.m_art);
         this.m_happy = this.m_art.getChildByName("happy") as MovieClip;
         this.m_normal = this.m_art.getChildByName("normal") as MovieClip;
         this.m_sad = this.m_art.getChildByName("sad") as MovieClip;
         this.m_fill = this.m_art.getChildByName("fill") as MovieClip;
         this.m_fx_tween = new TweensyGroup(false,true);
         this.m_fx_bf = new BlurFilter(20,20,1);
         this.m_fx_ct = new ColorTransform(0.15,1,1,1,13,-115,-255,0);
         this.m_fx_layer = new BitmapLayer(640,480);
         this.m_fx_layer.add(new ColorEffect(new ColorTransform(1,1,1,0.9)));
         this.m_fx_layer.add(new FilterEffect(this.m_fx_bf));
         this.m_fx_emittor = new Emitter(art_artefact_particle,{
            "scaleX":0.1,
            "scaleY":0.1,
            "rotation":360
         },1,1,270,"30, 90",1,BlendMode.ADD);
         this.m_fx_emittor.delay = 0.2;
         this.m_fx_emittor.transform.colorTransform = this.m_fx_ct;
         this.m_fx_emittor.endColor = new ColorTransform(1,1,-0.375,1,255,-198,-255,-50);
         this.m_fx_layer.draw(this.m_fx_emittor.holder);
         this.m_fx_emittor.mouseEnabled = false;
         this.m_fx_emittor.mouseChildren = false;
         this.m_fx_emittor.holder.mouseEnabled = false;
         this.m_fx_emittor.holder.mouseChildren = false;
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function init(param1:BitmapData) : void
      {
         if(this.m_icon && this.contains(this.m_icon))
         {
            this.removeChild(this.m_icon);
         }
         if(this.m_icon_f && this.contains(this.m_icon_f))
         {
            this.removeChild(this.m_icon_f);
         }
         if(this.m_fx_layer && this.contains(this.m_fx_layer))
         {
            this.removeChild(this.m_fx_layer);
         }
         this.m_icon = new Bitmap(param1);
         this.m_icon.smoothing = true;
         this.m_icon_f = new Bitmap(param1);
         this.m_icon_f.smoothing = true;
         this.addChild(this.m_icon);
         this.m_icon.x = 10;
         this.m_icon.y = 50;
         this.m_icon.scaleX = 0.7;
         this.m_icon.scaleY = 0.7;
         this.m_timer_cur = -1;
         this.hide();
      }
      
      public function show(param1:Number) : void
      {
         if(!this.m_layer.contains(this))
         {
            this.m_layer.addChild(this);
         }
         this.x = 650;
         this.y = 70;
         TweenMax.to(this,1,{"x":532});
         this.m_timer_cur = 0.01;
         this.m_timer_max = param1;
         SndMgr.PlaySound("explorer_show");
         this.quant(0);
      }
      
      public function fly_from(param1:int, param2:int) : void
      {
         this.m_icon_f.x = param1 - this.x - this.m_icon_f.width / 2;
         this.m_icon_f.y = param2 - this.y - this.m_icon_f.height / 2;
         this.m_fly_from = new Point(this.m_icon_f.x,this.m_icon_f.y);
         this.addChild(this.m_icon_f);
         this.m_fly_cur = 0.01;
         this.m_fx_layer.x = 0 - this.x;
         this.m_fx_layer.y = 0 - this.y;
         this.addChildAt(this.m_fx_layer,0);
      }
      
      public function move_out() : void
      {
         TweenMax.to(this,1,{
            "x":650,
            "onComplete":this.hide
         });
      }
      
      private function hide() : void
      {
         this.m_timer_cur = -1;
         if(this.m_layer.contains(this))
         {
            this.m_layer.removeChild(this);
         }
         if(this.contains(this.m_fx_layer))
         {
            this.removeChild(this.m_fx_layer);
         }
      }
      
      public function quant(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         if(this.m_icon_f == null || !this.contains(this.m_icon_f))
         {
            if(this.m_timer_cur >= 0)
            {
               this.m_timer_cur = this.m_timer_cur + param1;
               if(this.m_timer_cur > this.m_timer_max)
               {
                  SndMgr.PlaySound("explorer_hide");
                  this.m_timer_cur = -1;
                  this.move_out();
                  return;
               }
               _loc2_ = this.m_timer_cur * 1 / this.m_timer_max;
               this.m_fill.scaleY = 1 - _loc2_;
               if(_loc2_ < 0.5)
               {
                  if(!this.m_art.contains(this.m_happy))
                  {
                     this.m_art.addChildAt(this.m_happy,0);
                  }
                  if(this.m_art.contains(this.m_normal))
                  {
                     this.m_art.removeChild(this.m_normal);
                  }
                  if(this.m_art.contains(this.m_sad))
                  {
                     this.m_art.removeChild(this.m_sad);
                  }
               }
               else if(_loc2_ < 0.85)
               {
                  if(this.m_art.contains(this.m_happy))
                  {
                     this.m_art.removeChild(this.m_happy);
                  }
                  if(!this.m_art.contains(this.m_normal))
                  {
                     this.m_art.addChildAt(this.m_normal,0);
                  }
                  if(this.m_art.contains(this.m_sad))
                  {
                     this.m_art.removeChild(this.m_sad);
                  }
               }
               else
               {
                  if(this.m_art.contains(this.m_happy))
                  {
                     this.m_art.removeChild(this.m_happy);
                  }
                  if(this.m_art.contains(this.m_normal))
                  {
                     this.m_art.removeChild(this.m_normal);
                  }
                  if(!this.m_art.contains(this.m_sad))
                  {
                     this.m_art.addChildAt(this.m_sad,0);
                  }
               }
            }
         }
         else if(this.m_fly_cur >= this.m_fly_max)
         {
            if(this.contains(this.m_icon_f))
            {
               this.removeChild(this.m_icon_f);
            }
            this.m_icon_f = null;
            this.m_fly_cur = -1;
            this.move_out();
         }
         else
         {
            this.m_fly_cur = this.m_fly_cur + param1;
            _loc3_ = this.m_fly_cur / this.m_fly_max;
            _loc4_ = new Point(this.m_fly_from.x,this.m_fly_from.y);
            _loc5_ = new Point(320 - this.x,120 - this.y);
            _loc6_ = new Point(this.m_icon.x,this.m_icon.y);
            this.m_icon_f.x = (1 - _loc3_) * (1 - _loc3_) * _loc4_.x + 2 * _loc3_ * (1 - _loc3_) * _loc5_.x + _loc3_ * _loc3_ * _loc6_.x;
            this.m_icon_f.y = (1 - _loc3_) * (1 - _loc3_) * _loc4_.y + 2 * _loc3_ * (1 - _loc3_) * _loc5_.y + _loc3_ * _loc3_ * _loc6_.y;
            this.m_fx_emittor.x = this.m_icon_f.x + this.x + this.m_icon_f.width / 2;
            this.m_fx_emittor.y = this.m_icon_f.y + this.y + this.m_icon_f.height / 2;
         }
      }
   }
}
