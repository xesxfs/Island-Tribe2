package logic
{
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import logic.buildings.BaseBuilding;
   
   public class LevelObject extends Sprite
   {
       
      
      protected var m_layer:Sprite = null;
      
      protected var m_name:String = "";
      
      protected var m_accessable:Boolean = false;
      
      protected var m_sel_g:MovieClip;
      
      protected var m_sel_r:MovieClip;
      
      protected var m_overed:Boolean = false;
      
      protected var m_check_sign:Bitmap = null;
      
      protected var m_cross_sign:Bitmap = null;
      
      protected var m_uid:String = "";
      
      protected var m_progress:Number = -1;
      
      protected var m_nodeid:String = "";
      
      protected var m_gives:int = 0;
      
      protected var m_uses:int = 0;
      
      protected var m_uses_res:int = -1;
      
      protected var m_gives_res:int = -1;
      
      protected var m_worker:Worker = null;
      
      protected var m_owner:BaseBuilding = null;
      
      protected var m_unfog_ellipse:Rectangle = null;
      
      protected var m_reshow_cur:Number = -1;
      
      protected var m_reshow_max:Number = -1;
      
      public function LevelObject(param1:Sprite, param2:Boolean = false, param3:String = "")
      {
         var _loc4_:Bitmap = null;
         var _loc5_:Bitmap = null;
         var _loc6_:Bitmap = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Bitmap = null;
         var _loc9_:Bitmap = null;
         this.m_sel_g = new MovieClip();
         this.m_sel_r = new MovieClip();
         super();
         this.m_layer = param1;
         this.m_nodeid = param3;
         this.m_sel_g = new MovieClip();
         this.m_sel_r = new MovieClip();
         if(!param2)
         {
            _loc4_ = new Bitmap(new art_res_selector_g());
            _loc4_.smoothing = true;
            _loc4_.x = -_loc4_.width / 2;
            _loc4_.y = -_loc4_.height / 2;
            this.m_sel_g.addChild(_loc4_);
            this.m_sel_g.scaleX = 0.95;
            this.m_sel_g.scaleY = 0.95;
            _loc5_ = new Bitmap(new art_res_selector_r());
            _loc5_.smoothing = true;
            _loc5_.x = -_loc5_.width / 2;
            _loc5_.y = -_loc5_.height / 2;
            this.m_sel_r.addChild(_loc5_);
            this.m_sel_r.scaleX = 0.95;
            this.m_sel_r.scaleY = 0.95;
            TweenMax.to(this.m_sel_g,0.5,{
               "scaleX":1.1,
               "scaleY":1.1,
               "yoyo":true,
               "repeat":-1
            });
            TweenMax.to(this.m_sel_r,0.5,{
               "scaleX":1.1,
               "scaleY":1.1,
               "yoyo":true,
               "repeat":-1
            });
         }
         else
         {
            _loc6_ = new Bitmap(new art_building_selector_g());
            _loc7_ = new Bitmap(new art_building_selector_g());
            _loc7_.scaleX = -1;
            _loc6_.smoothing = true;
            _loc7_.smoothing = true;
            _loc6_.x = -_loc6_.width / 2 - 30;
            _loc6_.y = -_loc6_.height / 2;
            _loc7_.x = _loc6_.width / 2 + 30;
            _loc7_.y = -_loc6_.height / 2;
            this.m_sel_g.addChild(_loc6_);
            this.m_sel_g.addChild(_loc7_);
            _loc8_ = new Bitmap(new art_building_selector_r());
            _loc9_ = new Bitmap(new art_building_selector_r());
            _loc9_.scaleX = -1;
            _loc8_.smoothing = true;
            _loc9_.smoothing = true;
            _loc8_.x = -_loc8_.width / 2 - 30;
            _loc8_.y = -_loc8_.height / 2;
            _loc9_.x = _loc8_.width / 2 + 30;
            _loc9_.y = -_loc8_.height / 2;
            this.m_sel_r.addChild(_loc8_);
            this.m_sel_r.addChild(_loc9_);
            TweenMax.to(_loc6_,0.5,{
               "x":_loc6_.x - 5,
               "yoyo":true,
               "repeat":-1
            });
            TweenMax.to(_loc7_,0.5,{
               "x":_loc7_.x + 5,
               "yoyo":true,
               "repeat":-1
            });
            TweenMax.to(_loc8_,0.5,{
               "x":_loc6_.x - 5,
               "yoyo":true,
               "repeat":-1
            });
            TweenMax.to(_loc9_,0.5,{
               "x":_loc7_.x + 5,
               "yoyo":true,
               "repeat":-1
            });
         }
         this.m_sel_r.mouseEnabled = false;
         this.m_sel_r.mouseChildren = false;
         this.m_sel_g.mouseEnabled = false;
         this.m_sel_g.mouseChildren = false;
         this.m_check_sign = new Bitmap(new art_check_sign());
         this.m_check_sign.x = -this.m_check_sign.width / 2;
         this.m_check_sign.y = -this.m_check_sign.height / 2;
         this.m_cross_sign = new Bitmap(new art_cross_sign());
         this.m_cross_sign.x = -this.m_cross_sign.width / 2;
         this.m_cross_sign.y = -this.m_cross_sign.height / 2;
         this.addEventListener(Event.ADDED_TO_STAGE,this.on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.on_removed);
         this.show();
         this.activate();
      }
      
      protected function on_over(param1:MouseEvent) : void
      {
         GameLevel.update_object_accessability(this);
         if(!this.contains(this.m_check_sign))
         {
            this.m_overed = true;
            GameLevel.show_infownd(this);
            if(this.m_accessable)
            {
               if(this.m_sel_g && !this.contains(this.m_sel_g))
               {
                  this.addChildAt(this.m_sel_g,0);
               }
            }
            else if(this.m_sel_r && !this.contains(this.m_sel_r))
            {
               this.addChildAt(this.m_sel_r,0);
            }
         }
      }
      
      protected function on_out(param1:MouseEvent) : void
      {
         this.m_overed = false;
         GameLevel.hide_infownd();
         if(this.m_sel_g && this.contains(this.m_sel_g))
         {
            this.removeChild(this.m_sel_g);
         }
         if(this.m_sel_r && this.contains(this.m_sel_r))
         {
            this.removeChild(this.m_sel_r);
         }
      }
      
      protected function on_click(param1:MouseEvent) : void
      {
         if(this.contains(this.m_check_sign))
         {
            return;
         }
         if(this.m_nodeid != "&camp")
         {
            if(this.m_accessable)
            {
               if(this.m_sel_g && this.contains(this.m_sel_g))
               {
                  this.removeChild(this.m_sel_g);
               }
               this.addChild(this.m_check_sign);
            }
            else
            {
               this.m_cross_sign.alpha = 1;
               this.addChild(this.m_cross_sign);
               TweenMax.to(this.m_cross_sign,0.75,{
                  "delay":0.5,
                  "alpha":0
               });
            }
         }
         GameLevel.on_object_click(this);
      }
      
      public function on_worker_visit(param1:Worker) : void
      {
         if(this.contains(this.m_check_sign))
         {
            this.removeChild(this.m_check_sign);
         }
      }
      
      public function on_worker_leave(param1:Worker) : void
      {
      }
      
      protected function on_added(param1:Event) : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.on_over);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.on_out);
         this.addEventListener(MouseEvent.CLICK,this.on_click);
      }
      
      protected function on_removed(param1:Event) : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.on_over);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.on_out);
         this.removeEventListener(MouseEvent.CLICK,this.on_click);
      }
      
      public function set_unfog_ellipse(param1:Rectangle) : void
      {
         this.m_unfog_ellipse = param1;
      }
      
      public function get_unfog_ellipse() : Rectangle
      {
         if(this.m_unfog_ellipse)
         {
            return this.m_unfog_ellipse;
         }
         return new Rectangle(0,0,170,170);
      }
      
      public function show() : void
      {
         if(!this.m_layer.contains(this))
         {
            this.m_layer.addChild(this);
         }
      }
      
      public function hide() : void
      {
         this.m_overed = false;
         if(this.m_layer.contains(this))
         {
            this.m_layer.removeChild(this);
         }
         if(this.m_reshow_max > 0)
         {
            this.m_reshow_cur = 0.01;
         }
      }
      
      public function set_reshow_interval(param1:Number) : void
      {
         this.m_reshow_max = param1;
      }
      
      public function is_reshowable() : Boolean
      {
         return this.m_reshow_max > 0;
      }
      
      public function is_visible() : Boolean
      {
         return this.m_layer.contains(this);
      }
      
      public function activate() : void
      {
         this.buttonMode = true;
         this.mouseEnabled = true;
         this.mouseChildren = true;
      }
      
      public function deactivate() : void
      {
         this.buttonMode = false;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         if(this.m_sel_g && this.contains(this.m_sel_g))
         {
            this.removeChild(this.m_sel_g);
         }
         if(this.m_sel_r && this.contains(this.m_sel_r))
         {
            this.removeChild(this.m_sel_r);
         }
      }
      
      public function set_accessable(param1:Boolean) : void
      {
         this.m_accessable = param1;
      }
      
      public function update_selectors() : void
      {
         if(this.m_overed)
         {
            if(this.m_accessable)
            {
               if(this.m_sel_r && this.contains(this.m_sel_r))
               {
                  this.removeChild(this.m_sel_r);
               }
               if(this.m_sel_g && !this.contains(this.m_sel_g))
               {
                  this.addChildAt(this.m_sel_g,0);
               }
            }
            else
            {
               if(this.m_sel_r && !this.contains(this.m_sel_r))
               {
                  this.addChildAt(this.m_sel_r,0);
               }
               if(this.m_sel_g && this.contains(this.m_sel_g))
               {
                  this.removeChild(this.m_sel_g);
               }
            }
            if(this.contains(this.m_check_sign))
            {
               if(this.m_sel_g && this.contains(this.m_sel_g))
               {
                  this.removeChild(this.m_sel_g);
               }
               if(this.m_sel_r && this.contains(this.m_sel_r))
               {
                  this.removeChild(this.m_sel_r);
               }
            }
            GameLevel.show_infownd(this);
         }
      }
      
      public function accessable() : Boolean
      {
         return this.m_accessable;
      }
      
      public function quant(param1:Number) : void
      {
         if(this.m_overed)
         {
            GameLevel.update_infownd(this);
         }
         if(this.contains(this.m_cross_sign) && this.m_cross_sign.alpha == 0)
         {
            this.removeChild(this.m_cross_sign);
         }
         if(this.m_reshow_cur >= 0)
         {
            this.m_reshow_cur = this.m_reshow_cur + param1;
            if(this.m_reshow_cur >= this.m_reshow_max)
            {
               this.m_reshow_cur = -1;
               this.show();
            }
         }
      }
      
      public function get_progress() : Number
      {
         return this.m_progress;
      }
      
      public function get_name() : String
      {
         return this.m_name;
      }
      
      public function get_uid() : String
      {
         return this.m_uid;
      }
      
      public function set_uid(param1:String) : void
      {
         this.m_uid = param1;
      }
      
      public function set_owner(param1:BaseBuilding) : void
      {
         this.m_owner = param1;
      }
      
      public function get_owner() : BaseBuilding
      {
         return this.m_owner;
      }
      
      public function gives_num() : int
      {
         return this.m_gives;
      }
      
      public function uses_num() : int
      {
         return this.m_uses;
      }
      
      public function uses_res() : int
      {
         return this.m_uses_res;
      }
      
      public function gives_res() : int
      {
         return this.m_gives_res;
      }
      
      public function progress() : Number
      {
         return this.m_progress;
      }
      
      public function get_nodeid() : String
      {
         return this.m_nodeid;
      }
      
      public function infownd_yoffset() : int
      {
         return 0;
      }
      
      public function arrive_radius() : Number
      {
         return 0;
      }
   }
}
