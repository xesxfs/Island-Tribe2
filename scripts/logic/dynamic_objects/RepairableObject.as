package logic.dynamic_objects
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import logic.DynamicObject;
   import logic.GameLevel;
   import logic.LevelTriggers;
   import logic.Worker;
   import logic.resources.ResType;
   import menu.GameScreen_BldPBar;
   
   public class RepairableObject extends DynamicObject
   {
       
      
      protected var m_timer_cur:Number = -1;
      
      protected var m_timer_max:Number = 1.0;
      
      protected var m_broken:Sprite;
      
      protected var m_full:Sprite;
      
      protected var m_remove_after:Boolean = true;
      
      protected var m_pbar:GameScreen_BldPBar = null;
      
      protected var m_dust:BmpClip = null;
      
      protected var m_fire:BmpClip = null;
      
      public function RepairableObject(param1:Sprite, param2:String, param3:Boolean, param4:Number)
      {
         this.m_broken = new Sprite();
         this.m_full = new Sprite();
         super(param1,param2,param3);
         this.m_timer_max = param4;
         this.m_pbar = new GameScreen_BldPBar();
         m_art.addChild(this.m_broken);
      }
      
      override public function on_worker_visit(param1:Worker) : void
      {
         super.on_worker_visit(param1);
         m_worker = param1;
         m_worker.start_repairing();
         if(this.m_dust)
         {
            this.addChild(this.m_dust);
         }
         this.m_full.alpha = 0;
         m_art.addChild(this.m_full);
         m_uses = 0;
         m_uses_res = ResType.NONE;
         m_gives = 0;
         m_gives_res = ResType.NONE;
         this.m_timer_cur = 0.01;
      }
      
      override public function quant(param1:Number) : void
      {
         super.quant(param1);
         if(this.m_dust)
         {
            this.m_dust.update(param1);
         }
         if(this.m_fire)
         {
            this.m_fire.update(param1);
         }
         if(this.m_timer_cur >= 0)
         {
            this.m_timer_cur = this.m_timer_cur + param1;
            if(this.m_timer_cur >= this.m_timer_max)
            {
               if(this.m_dust && this.contains(this.m_dust))
               {
                  this.removeChild(this.m_dust);
               }
               m_worker.stop_working();
               this.m_timer_cur = -1;
               m_progress = -1;
               GameLevel.set_node_passable(m_nodeid);
               if(m_overed)
               {
                  GameLevel.hide_infownd();
               }
               m_art.removeChild(this.m_broken);
               this.m_broken = null;
               if(this.m_remove_after)
               {
                  hide();
               }
               deactivate();
               if(GameLevel.get_pbar_layer().contains(this.m_pbar))
               {
                  GameLevel.get_pbar_layer().removeChild(this.m_pbar);
               }
               LevelTriggers.on_object_repaired(m_uid);
               GameLevel.on_worker_leave(m_worker);
            }
            else
            {
               m_progress = this.m_timer_cur / this.m_timer_max;
               this.m_broken.alpha = 1 - m_progress;
               this.m_full.alpha = m_progress;
               this.m_pbar.set_progress(m_progress);
               if(!GameLevel.get_pbar_layer().contains(this.m_pbar))
               {
                  this.m_pbar.x = this.x;
                  this.m_pbar.y = this.y - 30;
                  GameLevel.get_pbar_layer().addChild(this.m_pbar);
               }
            }
         }
      }
      
      override protected function on_click(param1:MouseEvent) : void
      {
         if(this.m_timer_cur < 0)
         {
            super.on_click(param1);
         }
      }
      
      public function repaired() : Boolean
      {
         return this.m_broken == null;
      }
      
      override public function infownd_yoffset() : int
      {
         return 35;
      }
      
      override public function arrive_radius() : Number
      {
         return 20;
      }
   }
}
