package logic.buildings
{
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import logic.GameLevel;
   import logic.LevelObject;
   import logic.LevelTriggers;
   import logic.Worker;
   import logic.resources.ResType;
   import menu.GameScreen;
   import menu.GameScreen_DemandWnd;
   
   public class BaseBuilding extends LevelObject
   {
       
      
      protected var m_base:MovieClip;
      
      protected var m_add:MovieClip;
      
      protected var m_icons:Sprite;
      
      protected var m_cur_level:int = 1;
      
      protected var m_max_level:int = 1;
      
      protected var m_title:String = "";
      
      protected var m_title_upgrade:String = "";
      
      protected var m_prod_res:int = -1;
      
      protected var m_prod_num:int = 0;
      
      protected var m_prod_cur:Number = 0.0;
      
      protected var m_prod_len:Number = 0.0;
      
      protected var m_upgrade_cur:Number = -1;
      
      protected var m_upgrade_len:Number = 0.0;
      
      protected var m_upgrade_res:int = -1;
      
      protected var m_upgrade_cost:int = 0;
      
      protected var m_upgrade_result:int = 0;
      
      protected var m_demand_num:int = 0;
      
      protected var m_demand_res:int = 0;
      
      protected var m_demand_cur:Number = -1;
      
      protected var m_demand_len:Number = 0.0;
      
      protected var m_demand_wnd:GameScreen_DemandWnd = null;
      
      protected var m_work_anim:MovieClip = null;
      
      protected var m_res_pickedup:Boolean = true;
      
      protected var m_dust:BmpClip = null;
      
      public function BaseBuilding(param1:Sprite, param2:String, param3:int)
      {
         this.m_base = new MovieClip();
         this.m_add = new MovieClip();
         this.m_icons = new Sprite();
         super(param1,true,param2);
         this.m_cur_level = 1;
         this.m_max_level = param3;
         this.m_dust = new BmpClip(new art_build_dust(),2.5,25);
         this.m_dust.x = -this.m_dust.width / 2;
         this.m_dust.y = -this.m_dust.height / 2;
         this.addEventListener(Event.ADDED_TO_STAGE,this.on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.on_removed);
      }
      
      protected function prepare_base_and_add() : void
      {
         if(this.m_base)
         {
            this.addChild(this.m_base);
         }
         if(this.m_add)
         {
            this.m_add.blendMode = BlendMode.ADD;
            this.m_add.alpha = 0.3;
            this.m_add.mouseChildren = false;
            this.m_add.mouseEnabled = false;
            if(this.contains(this.m_add))
            {
               this.removeChild(this.m_add);
            }
         }
         this.m_icons.mouseEnabled = false;
         this.m_icons.y = -40;
         this.addChild(this.m_icons);
      }
      
      protected function update_icons() : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:Bitmap = null;
         var _loc6_:Bitmap = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Sprite = null;
         while(this.m_icons.numChildren)
         {
            this.m_icons.removeChildAt(0);
         }
         var _loc1_:int = 1;
         if(m_nodeid != "&camp")
         {
            _loc1_ = 2;
         }
         while(_loc1_ <= this.m_max_level)
         {
            if(_loc1_ > this.m_cur_level + 1)
            {
               break;
            }
            _loc4_ = new Sprite();
            _loc4_.mouseEnabled = false;
            _loc4_.mouseChildren = false;
            if(_loc1_ <= this.m_cur_level)
            {
               if(m_nodeid == "&camp")
               {
                  _loc4_.addChild(new Bitmap(new art_building_icon_worker()));
               }
               else if(this.m_max_level > 1)
               {
                  _loc4_.addChild(new Bitmap(new art_building_icon_star()));
               }
            }
            else if(_loc1_ <= this.m_max_level)
            {
               _loc5_ = new Bitmap(new art_building_icon_b());
               _loc6_ = new Bitmap(new art_building_icon_g());
               _loc7_ = new Bitmap(new art_building_icon_r());
               _loc4_.addChild(_loc5_);
               _loc4_.addChild(_loc6_);
               _loc4_.addChild(_loc7_);
               _loc6_.alpha = 0;
               _loc7_.alpha = 0;
               _loc4_.buttonMode = true;
               _loc4_.mouseEnabled = true;
            }
            _loc4_.y = -_loc4_.height / 2;
            this.m_icons.addChild(_loc4_);
            _loc1_++;
         }
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_icons.numChildren)
         {
            _loc8_ = this.m_icons.getChildAt(_loc3_) as Sprite;
            _loc8_.x = _loc2_;
            _loc2_ = _loc2_ + _loc8_.width * 0.8;
            _loc3_++;
         }
         this.m_icons.x = -this.m_icons.width / 2;
      }
      
      override public function on_worker_visit(param1:Worker) : void
      {
         super.on_worker_visit(param1);
         if(this.m_demand_cur >= this.m_demand_len)
         {
            param1.stop_working();
            this.m_demand_cur = 0;
            this.m_prod_cur = 0;
            m_uses = 0;
            m_uses_res = ResType.NONE;
            m_gives = this.m_prod_num;
            m_gives_res = this.m_prod_res;
         }
      }
      
      override protected function on_added(param1:Event) : void
      {
         super.on_added(param1);
         this.m_icons.addEventListener(MouseEvent.CLICK,this.on_upgrade_сlick);
         this.m_icons.addEventListener(MouseEvent.MOUSE_OVER,this.on_upgrade_over);
         this.m_icons.addEventListener(MouseEvent.MOUSE_OUT,this.on_upgrade_out);
      }
      
      override protected function on_removed(param1:Event) : void
      {
         super.on_removed(param1);
         this.m_icons.removeEventListener(MouseEvent.CLICK,this.on_upgrade_сlick);
         this.m_icons.removeEventListener(MouseEvent.MOUSE_OVER,this.on_upgrade_over);
         this.m_icons.removeEventListener(MouseEvent.MOUSE_OUT,this.on_upgrade_out);
      }
      
      override protected function on_over(param1:MouseEvent) : void
      {
         if(m_name == this.m_title)
         {
            m_gives = this.m_prod_num;
            m_gives_res = this.m_prod_res;
         }
         super.on_over(param1);
         if(!this.m_base.contains(this.m_add))
         {
            this.m_base.addChild(this.m_add);
         }
      }
      
      override protected function on_out(param1:MouseEvent) : void
      {
         super.on_out(param1);
         if(this.m_base.contains(this.m_add))
         {
            this.m_base.removeChild(this.m_add);
         }
      }
      
      override public function activate() : void
      {
         super.activate();
         this.buttonMode = false;
         this.m_base.buttonMode = true;
      }
      
      override protected function on_click(param1:MouseEvent) : void
      {
         if(this.m_demand_cur >= this.m_demand_len)
         {
            super.on_click(param1);
         }
      }
      
      protected function on_upgrade_completed() : void
      {
         if(GameScreen.is_visible())
         {
            SndMgr.PlaySound("upgrade");
            SndMgr.PlaySound("worker_joy");
         }
         if(m_worker)
         {
            m_worker.stop_working();
            m_worker = null;
         }
         if(this.m_dust && this.contains(this.m_dust))
         {
            this.removeChild(this.m_dust);
         }
         this.m_cur_level++;
         this.m_upgrade_cur = -1;
         if(this.m_res_pickedup)
         {
            this.m_prod_cur = 0.01;
         }
         this.m_prod_num = this.m_upgrade_result;
         m_name = this.m_title;
         m_uses = 0;
         m_uses_res = ResType.NONE;
         m_gives = this.m_prod_num;
         m_gives_res = this.m_prod_res;
         m_progress = -1;
         if(m_uid == "camp")
         {
            m_uses = 0;
            m_uses_res = ResType.NONE;
            m_gives = 0;
            m_gives_res = ResType.NONE;
         }
         this.update_icons();
         LevelTriggers.on_object_upgraded(m_uid);
      }
      
      protected function on_upgrade_сlick(param1:MouseEvent) : void
      {
         if(!m_accessable)
         {
            return;
         }
         if(this.m_upgrade_cur > 0)
         {
            return;
         }
         SndMgr.PlaySound("upgrade_start");
         if(this.m_work_anim && this.contains(this.m_work_anim))
         {
            this.removeChild(this.m_work_anim);
         }
         this.m_prod_cur = 0.01;
         m_progress = -1;
         var _loc2_:Sprite = this.m_icons.getChildAt(this.m_icons.numChildren - 1) as Sprite;
         var _loc3_:Bitmap = _loc2_.getChildAt(0) as Bitmap;
         var _loc4_:Bitmap = _loc2_.getChildAt(1) as Bitmap;
         var _loc5_:Bitmap = _loc2_.getChildAt(2) as Bitmap;
         _loc5_.alpha = 0;
         _loc4_.alpha = 0;
         if(GameLevel.get_resource_num(this.m_upgrade_res) < this.m_upgrade_cost)
         {
            return;
         }
         if(this.m_dust)
         {
            this.addChild(this.m_dust);
         }
         m_name = this.m_title_upgrade;
         m_uses_res = this.m_upgrade_res;
         m_uses = this.m_upgrade_cost;
         m_gives_res = this.m_prod_res;
         m_gives = this.m_upgrade_result;
         GameLevel.use_resource(m_uses_res,m_uses);
         this.m_upgrade_cur = 0.01;
      }
      
      protected function on_upgrade_over(param1:MouseEvent) : void
      {
         if(this.m_upgrade_cur > 0)
         {
            return;
         }
         var _loc2_:Sprite = this.m_icons.getChildAt(this.m_icons.numChildren - 1) as Sprite;
         var _loc3_:Bitmap = _loc2_.getChildAt(0) as Bitmap;
         var _loc4_:Bitmap = _loc2_.getChildAt(1) as Bitmap;
         var _loc5_:Bitmap = _loc2_.getChildAt(2) as Bitmap;
         if(GameLevel.get_resource_num(this.m_upgrade_res) >= this.m_upgrade_cost)
         {
            _loc5_.alpha = 0;
            _loc4_.alpha = 1;
         }
         else
         {
            _loc5_.alpha = 1;
            _loc4_.alpha = 0;
         }
         m_name = this.m_title_upgrade;
         m_uses = this.m_upgrade_cost;
         m_uses_res = this.m_upgrade_res;
         m_gives = this.m_upgrade_result;
         m_gives_res = this.m_prod_res;
         super.on_over(param1);
      }
      
      protected function on_upgrade_out(param1:MouseEvent) : void
      {
         if(this.m_upgrade_cur > 0)
         {
            return;
         }
         var _loc2_:Sprite = this.m_icons.getChildAt(this.m_icons.numChildren - 1) as Sprite;
         var _loc3_:Bitmap = _loc2_.getChildAt(0) as Bitmap;
         var _loc4_:Bitmap = _loc2_.getChildAt(1) as Bitmap;
         var _loc5_:Bitmap = _loc2_.getChildAt(2) as Bitmap;
         _loc4_.alpha = 0;
         _loc5_.alpha = 0;
         m_name = this.m_title;
         m_uses = 0;
         m_uses_res = ResType.NONE;
         m_gives = this.m_prod_num;
         m_gives_res = this.m_prod_res;
      }
      
      override public function quant(param1:Number) : void
      {
         super.quant(param1);
         if(this.m_work_anim as BmpClip)
         {
            this.m_work_anim.update(param1);
         }
         if(this.m_dust)
         {
            this.m_dust.update(param1);
         }
         if(this.m_upgrade_cur >= 0)
         {
            this.m_upgrade_cur = this.m_upgrade_cur + param1;
            if(this.m_upgrade_cur >= this.m_upgrade_len)
            {
               this.m_upgrade_cur = -1;
               this.on_upgrade_completed();
            }
            else
            {
               m_progress = this.m_upgrade_cur / this.m_upgrade_len;
               m_uses_res = ResType.NONE;
               m_uses = 0;
               m_gives_res = ResType.NONE;
               m_gives = 0;
            }
         }
         if(this.m_upgrade_cur < 0 && this.m_res_pickedup && this.m_demand_cur < this.m_demand_len && this.m_prod_cur < 0)
         {
            this.m_prod_cur = 0.01;
         }
         var _loc2_:Boolean = false;
         if(this.m_prod_len > 0 && this.m_prod_cur >= 0 && this.m_res_pickedup && this.m_upgrade_cur < 0)
         {
            if(this.m_demand_cur < this.m_demand_len)
            {
               this.m_prod_cur = this.m_prod_cur + param1;
               _loc2_ = true;
               if(this.m_prod_cur >= this.m_prod_len)
               {
                  if(this.contains(this.m_work_anim))
                  {
                     this.removeChild(this.m_work_anim);
                  }
                  GameLevel.create_resource(m_nodeid,this.m_prod_res,this.m_prod_num,this);
                  this.m_res_pickedup = false;
                  this.m_prod_cur = -1;
                  m_progress = -1;
               }
               else
               {
                  m_progress = this.m_prod_cur / this.m_prod_len;
                  if(!this.contains(this.m_work_anim))
                  {
                     this.addChild(this.m_work_anim);
                  }
               }
            }
         }
         if(this.m_demand_wnd)
         {
            if(this.m_demand_len > 0 && this.m_demand_cur >= 0)
            {
               if(_loc2_)
               {
                  this.m_demand_cur = this.m_demand_cur + param1;
               }
               if(this.m_demand_cur >= this.m_demand_len)
               {
                  if(!this.contains(this.m_demand_wnd))
                  {
                     this.m_demand_wnd.set_info(this.m_demand_num,this.m_demand_res);
                     this.addChild(this.m_demand_wnd);
                     m_gives = 0;
                     m_gives_res = ResType.NONE;
                     m_uses = this.m_demand_num;
                     m_uses_res = this.m_demand_res;
                     if(this.contains(this.m_work_anim))
                     {
                        this.removeChild(this.m_work_anim);
                     }
                  }
               }
               else if(this.contains(this.m_demand_wnd))
               {
                  this.removeChild(this.m_demand_wnd);
               }
            }
         }
      }
      
      public function is_demand() : Boolean
      {
         return this.m_demand_wnd && this.contains(this.m_demand_wnd);
      }
      
      public function on_resource_pickedup() : void
      {
         this.m_res_pickedup = true;
         if(this.m_prod_len > 0 && this.m_demand_cur < this.m_demand_len && this.m_upgrade_cur < 0)
         {
            if(!this.contains(this.m_work_anim))
            {
               this.addChild(this.m_work_anim);
            }
            this.m_prod_cur = 0;
         }
      }
      
      override public function arrive_radius() : Number
      {
         return 0;
      }
   }
}
