package logic.buildings
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import logic.resources.ResType;
   import menu.GameScreen_DemandWnd;
   
   public class GrainFarm extends BaseBuilding
   {
       
      
      private var m_grain_1:Bitmap = null;
      
      private var m_grain_2:Bitmap = null;
      
      public function GrainFarm(param1:Sprite, param2:int, param3:int, param4:String, param5:int, param6:Boolean)
      {
         super(param1,param4,param5);
         this.x = param2;
         this.y = param3;
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_grainfarm();
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_base.addChild(_loc7_);
         var _loc8_:Bitmap = new Bitmap();
         _loc8_.bitmapData = new art_grainfarm();
         _loc8_.x = -_loc8_.width / 2;
         _loc8_.y = -_loc8_.height / 2;
         m_add.addChild(_loc8_);
         prepare_base_and_add();
         update_icons();
         m_title = XMLTranslation.s("BLD_GRAINFARM");
         m_title_upgrade = "";
         m_name = m_title;
         m_prod_num = 2;
         m_prod_res = ResType.GRAIN;
         m_prod_len = 12;
         m_demand_cur = 0;
         m_demand_len = 24;
         m_demand_num = 4;
         m_demand_res = ResType.WATER;
         m_demand_wnd = new GameScreen_DemandWnd();
         m_demand_wnd.mouseEnabled = false;
         m_demand_wnd.mouseChildren = false;
         m_upgrade_len = 10;
         m_upgrade_res = ResType.WOOD;
         m_upgrade_cost = 4;
         m_upgrade_result = 4;
         m_work_anim = new BmpClip(new art_grainfarm_worker(),0.6,6);
         m_work_anim.x = -m_work_anim.width / 2;
         m_work_anim.y = -m_work_anim.height / 2;
         this.addChild(m_work_anim);
         this.m_grain_1 = new Bitmap(new art_grainfarm_grain_1());
         this.m_grain_2 = new Bitmap(new art_grainfarm_grain_2());
         this.m_grain_1.x = -50;
         this.m_grain_1.y = -15;
         this.m_grain_2.x = -50;
         this.m_grain_2.y = -15;
         if(param6)
         {
            hide();
         }
      }
      
      override protected function on_upgrade_completed() : void
      {
         super.on_upgrade_completed();
      }
      
      override public function quant(param1:Number) : void
      {
         super.quant(param1);
         if(m_progress >= 0.33)
         {
            if(m_progress <= 0.66)
            {
               if(!this.contains(this.m_grain_1))
               {
                  this.addChild(this.m_grain_1);
                  if(this.contains(m_work_anim))
                  {
                     this.addChild(this.removeChild(m_work_anim));
                  }
               }
               if(this.contains(this.m_grain_2))
               {
                  this.removeChild(this.m_grain_2);
               }
            }
            else if(m_progress <= 1)
            {
               if(!this.contains(this.m_grain_2))
               {
                  this.addChild(this.m_grain_2);
                  if(this.contains(m_work_anim))
                  {
                     this.addChild(this.removeChild(m_work_anim));
                  }
               }
               if(this.contains(this.m_grain_1))
               {
                  this.removeChild(this.m_grain_1);
               }
            }
         }
         else
         {
            if(this.contains(this.m_grain_1))
            {
               this.removeChild(this.m_grain_1);
            }
            if(this.contains(this.m_grain_2))
            {
               this.removeChild(this.m_grain_2);
            }
         }
         if(m_progress >= 0)
         {
            if(m_work_anim.scaleX > 0)
            {
               if(m_progress >= 0 && m_progress < 0.2 || m_progress >= 0.6 && m_progress < 0.8)
               {
                  m_work_anim.scaleX = -1;
                  m_work_anim.x = -m_work_anim.width;
                  m_work_anim.x = 37;
                  m_work_anim.y = -15;
               }
            }
            else if(m_progress >= 0.4 && m_progress < 0.6 || m_progress >= 0.8 && m_progress < 1)
            {
               m_work_anim.scaleX = 1;
               m_work_anim.x = -50;
               m_work_anim.y = -15;
            }
         }
      }
   }
}
