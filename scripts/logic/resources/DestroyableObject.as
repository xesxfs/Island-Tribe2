package logic.resources
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import logic.DynamicObject;
   import logic.GameLevel;
   import logic.LevelTriggers;
   import logic.Worker;
   import menu.GameScreen_BldPBar;
   
   public class DestroyableObject extends DynamicObject
   {
       
      
      protected var m_timer_cur:Number = -1;
      
      protected var m_timer_max:Number = 1.0;
      
      protected var m_full:Sprite;
      
      protected var m_remove_after:Boolean = true;
      
      protected var m_pbar:GameScreen_BldPBar = null;
      
      public function DestroyableObject(param1:Sprite, param2:String, param3:Boolean, param4:Number)
      {
         this.m_full = new Sprite();
         super(param1,param2,param3);
         this.m_timer_max = param4;
         this.m_pbar = new GameScreen_BldPBar();
         this.m_pbar.y = -40;
         m_art.addChild(this.m_full);
      }
      
      override public function on_worker_visit(param1:Worker) : void
      {
         super.on_worker_visit(param1);
         m_worker = param1;
         if(m_gives_res == ResType.STONE)
         {
            m_worker.start_picking();
         }
         else if(m_gives_res == ResType.WOOD)
         {
            m_worker.start_axing();
         }
         else
         {
            m_worker.start_destroying();
         }
         this.m_timer_cur = 0.01;
      }
      
      override public function quant(param1:Number) : void
      {
         super.quant(param1);
         if(this.m_timer_cur >= 0)
         {
            this.m_timer_cur = this.m_timer_cur + param1;
            if(this.m_timer_cur >= this.m_timer_max)
            {
               m_worker.stop_working();
               if(m_gives)
               {
                  m_worker.start_carrying();
               }
               this.m_timer_cur = -1;
               m_progress = -1;
               GameLevel.set_node_passable(m_nodeid);
               if(m_overed)
               {
                  GameLevel.hide_infownd();
               }
               deactivate();
               hide();
               if(GameLevel.get_pbar_layer().contains(this.m_pbar))
               {
                  GameLevel.get_pbar_layer().removeChild(this.m_pbar);
               }
               LevelTriggers.on_object_destroyed(m_uid);
               GameLevel.on_worker_leave(m_worker);
            }
            else
            {
               m_progress = this.m_timer_cur / this.m_timer_max;
               this.m_full.alpha = 1 - m_progress;
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
      
      override public function infownd_yoffset() : int
      {
         return 35;
      }
      
      override public function arrive_radius() : Number
      {
         return 15;
      }
   }
}
