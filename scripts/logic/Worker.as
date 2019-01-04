package logic
{
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Worker extends Sprite
   {
       
      
      private var m_layer:Sprite = null;
      
      private var m_path:Array = null;
      
      private var m_speed:Number = 4.4;
      
      private var m_dir:Point;
      
      private var m_target:LevelObject = null;
      
      private var m_working:Boolean = false;
      
      private var m_breaking:Boolean = false;
      
      private var m_picking:Boolean = false;
      
      private var m_axing:Boolean = false;
      
      private var m_carrying:Boolean = false;
      
      private var m_art:BmpClip = null;
      
      private var m_run_n:BmpClip;
      
      private var m_run_nw:BmpClip;
      
      private var m_run_w:BmpClip;
      
      private var m_run_sw:BmpClip;
      
      private var m_run_s:BmpClip;
      
      private var m_run_se:BmpClip;
      
      private var m_run_e:BmpClip;
      
      private var m_run_ne:BmpClip;
      
      private var m_build_n:BmpClip;
      
      private var m_build_nw:BmpClip;
      
      private var m_build_w:BmpClip;
      
      private var m_build_sw:BmpClip;
      
      private var m_build_s:BmpClip;
      
      private var m_build_se:BmpClip;
      
      private var m_build_e:BmpClip;
      
      private var m_build_ne:BmpClip;
      
      private var m_carry_n:BmpClip;
      
      private var m_carry_nw:BmpClip;
      
      private var m_carry_w:BmpClip;
      
      private var m_carry_sw:BmpClip;
      
      private var m_carry_s:BmpClip;
      
      private var m_carry_se:BmpClip;
      
      private var m_carry_e:BmpClip;
      
      private var m_carry_ne:BmpClip;
      
      private var m_pick_n:BmpClip;
      
      private var m_pick_nw:BmpClip;
      
      private var m_pick_w:BmpClip;
      
      private var m_pick_sw:BmpClip;
      
      private var m_pick_s:BmpClip;
      
      private var m_pick_se:BmpClip;
      
      private var m_pick_e:BmpClip;
      
      private var m_pick_ne:BmpClip;
      
      public function Worker(param1:Sprite)
      {
         this.m_dir = new Point();
         this.m_run_n = new BmpClip(new art_worker_run_n(),0.72);
         this.m_run_nw = new BmpClip(new art_worker_run_nw(),0.72);
         this.m_run_w = new BmpClip(new art_worker_run_w(),0.72);
         this.m_run_sw = new BmpClip(new art_worker_run_sw(),0.72);
         this.m_run_s = new BmpClip(new art_worker_run_s(),0.72);
         this.m_run_se = new BmpClip(new art_worker_run_se(),0.72);
         this.m_run_e = new BmpClip(new art_worker_run_e(),0.72);
         this.m_run_ne = new BmpClip(new art_worker_run_ne(),0.72);
         this.m_build_n = new BmpClip(new art_worker_build_n(),0.72);
         this.m_build_nw = new BmpClip(new art_worker_build_nw(),0.72);
         this.m_build_w = new BmpClip(new art_worker_build_w(),0.72);
         this.m_build_sw = new BmpClip(new art_worker_build_sw(),0.72);
         this.m_build_s = new BmpClip(new art_worker_build_s(),0.72);
         this.m_build_se = new BmpClip(new art_worker_build_se(),0.72);
         this.m_build_e = new BmpClip(new art_worker_build_e(),0.72);
         this.m_build_ne = new BmpClip(new art_worker_build_ne(),0.72);
         this.m_carry_n = new BmpClip(new art_worker_carry_n(),0.72);
         this.m_carry_nw = new BmpClip(new art_worker_carry_nw(),0.72);
         this.m_carry_w = new BmpClip(new art_worker_carry_w(),0.72);
         this.m_carry_sw = new BmpClip(new art_worker_carry_sw(),0.72);
         this.m_carry_s = new BmpClip(new art_worker_carry_s(),0.72);
         this.m_carry_se = new BmpClip(new art_worker_carry_se(),0.72);
         this.m_carry_e = new BmpClip(new art_worker_carry_e(),0.72);
         this.m_carry_ne = new BmpClip(new art_worker_carry_ne(),0.72);
         this.m_pick_n = new BmpClip(new art_worker_pick_n(),0.72);
         this.m_pick_nw = new BmpClip(new art_worker_pick_nw(),0.72);
         this.m_pick_w = new BmpClip(new art_worker_pick_w(),0.72);
         this.m_pick_sw = new BmpClip(new art_worker_pick_sw(),0.72);
         this.m_pick_s = new BmpClip(new art_worker_pick_s(),0.72);
         this.m_pick_se = new BmpClip(new art_worker_pick_se(),0.72);
         this.m_pick_e = new BmpClip(new art_worker_pick_e(),0.72);
         this.m_pick_ne = new BmpClip(new art_worker_pick_ne(),0.72);
         super();
         this.m_layer = param1;
      }
      
      public function run(param1:Array, param2:LevelObject, param3:Boolean) : void
      {
         if(param1 == null)
         {
         }
         if(!this.m_layer.contains(this))
         {
            SndMgr.PlaySound("worker_out");
         }
         this.show();
         this.m_path = param1;
         this.m_target = param2;
         this.m_carrying = param3;
      }
      
      public function get_next_path_pos() : Point
      {
         if(this.m_path.length)
         {
            return this.m_path[0];
         }
         return null;
      }
      
      public function is_carrying() : Boolean
      {
         return this.m_carrying;
      }
      
      public function is_visible() : Boolean
      {
         return this.m_layer.contains(this);
      }
      
      public function ready_for_task() : Boolean
      {
         if(this.m_layer.contains(this))
         {
            if(this.m_working)
            {
               return false;
            }
            if(this.m_carrying)
            {
               return false;
            }
            if(this.m_breaking)
            {
               return false;
            }
            if(this.m_target.get_uid() != "camp")
            {
               return false;
            }
            return true;
         }
         return true;
      }
      
      public function quant(param1:Number) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!this.m_working && !this.m_breaking)
         {
            if(this.m_path.length == 0)
            {
               return;
            }
            this.m_dir.x = (this.m_path[0] as Point).x - this.x;
            this.m_dir.y = (this.m_path[0] as Point).y - this.y;
            _loc2_ = new Point();
            _loc2_.x = (this.m_path[this.m_path.length - 1] as Point).x - this.x;
            _loc2_.y = (this.m_path[this.m_path.length - 1] as Point).y - this.y;
            _loc3_ = Math.sqrt(this.m_dir.x * this.m_dir.x + this.m_dir.y * this.m_dir.y);
            _loc4_ = Math.sqrt(_loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y);
            if(_loc4_ < this.m_speed + this.m_target.arrive_radius())
            {
               GameLevel.on_worker_arrive(this);
            }
            else if(_loc3_ < this.m_speed)
            {
               this.x = this.m_path[0].x;
               this.y = this.m_path[0].y;
               this.m_path.shift();
            }
            else
            {
               this.m_dir.normalize(1);
               this.x = this.x + this.m_dir.x * this.m_speed;
               this.y = this.y + this.m_dir.y * this.m_speed;
            }
         }
         this.update_art();
         if(this.m_art)
         {
            _loc5_ = this.m_art.currentFrame;
            this.m_art.update(param1);
            _loc6_ = this.m_art.currentFrame;
            if(_loc6_ != _loc5_)
            {
               if(this.m_working && _loc6_ == 7)
               {
                  SndMgr.PlaySound("hammer");
               }
               else if(this.m_breaking && _loc6_ == 7)
               {
                  if(this.m_picking)
                  {
                     SndMgr.PlaySound("pick");
                  }
                  if(this.m_axing)
                  {
                     SndMgr.PlaySound("axe");
                  }
               }
            }
         }
      }
      
      private function update_art() : void
      {
         if(this.m_art)
         {
            this.removeChild(this.m_art);
            this.m_art = null;
         }
         var _loc1_:Number = Math.atan2(-this.m_dir.y,this.m_dir.x);
         var _loc2_:Number = _loc1_ * 180 / Math.PI;
         if(_loc2_ < 0)
         {
            _loc2_ = _loc2_ + 360;
         }
         if(_loc2_ >= 22.5 || _loc2_ <= 67.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_ne;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_ne;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_ne;
            }
            else
            {
               this.m_art = this.m_run_ne;
            }
         }
         if(_loc2_ >= 67.5 && _loc2_ <= 112.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_n;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_n;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_n;
            }
            else
            {
               this.m_art = this.m_run_n;
            }
         }
         if(_loc2_ >= 112.5 && _loc2_ <= 157.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_nw;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_nw;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_nw;
            }
            else
            {
               this.m_art = this.m_run_nw;
            }
         }
         if(_loc2_ >= 157.5 && _loc2_ <= 202.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_w;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_w;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_w;
            }
            else
            {
               this.m_art = this.m_run_w;
            }
         }
         if(_loc2_ >= 202.5 && _loc2_ <= 247.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_sw;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_sw;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_sw;
            }
            else
            {
               this.m_art = this.m_run_sw;
            }
         }
         if(_loc2_ >= 247.5 && _loc2_ <= 292.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_s;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_s;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_s;
            }
            else
            {
               this.m_art = this.m_run_s;
            }
         }
         if(_loc2_ >= 292.5 && _loc2_ <= 337.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_se;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_se;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_se;
            }
            else
            {
               this.m_art = this.m_run_se;
            }
         }
         if(_loc2_ >= 337.5 || _loc2_ <= 22.5)
         {
            if(this.m_working)
            {
               this.m_art = this.m_build_e;
            }
            else if(this.m_breaking)
            {
               this.m_art = this.m_pick_e;
            }
            else if(this.m_carrying)
            {
               this.m_art = this.m_carry_e;
            }
            else
            {
               this.m_art = this.m_run_e;
            }
         }
         if(this.m_art)
         {
            this.m_art.x = -24;
            this.m_art.y = -36;
            this.addChild(this.m_art);
         }
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
         if(this.m_layer.contains(this))
         {
            this.m_layer.removeChild(this);
         }
      }
      
      public function get_target() : LevelObject
      {
         return this.m_target;
      }
      
      public function start_repairing() : void
      {
         this.m_carrying = false;
         this.m_breaking = false;
         this.m_working = true;
      }
      
      public function start_destroying() : void
      {
         this.m_carrying = false;
         this.m_working = false;
         this.m_breaking = true;
         this.m_picking = false;
         this.m_axing = false;
      }
      
      public function start_picking() : void
      {
         this.m_carrying = false;
         this.m_working = false;
         this.m_breaking = true;
         this.m_picking = true;
         this.m_axing = false;
      }
      
      public function start_axing() : void
      {
         this.m_carrying = false;
         this.m_working = false;
         this.m_breaking = true;
         this.m_picking = false;
         this.m_axing = true;
      }
      
      public function stop_working() : void
      {
         this.m_working = false;
         this.m_carrying = false;
         this.m_breaking = false;
      }
      
      public function start_carrying() : void
      {
         this.m_working = false;
         this.m_breaking = false;
         this.m_carrying = true;
      }
   }
}
