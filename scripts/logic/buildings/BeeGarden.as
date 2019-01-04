package logic.buildings
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import logic.resources.ResType;
   import menu.GameScreen_DemandWnd;
   
   public class BeeGarden extends BaseBuilding
   {
       
      
      private var m_bee_1:BmpClip = null;
      
      private var m_bee_2:BmpClip = null;
      
      public function BeeGarden(param1:Sprite, param2:int, param3:int, param4:String, param5:int, param6:Boolean)
      {
         super(param1,param4,param5);
         this.x = param2;
         this.y = param3;
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_beegarden();
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_base.addChild(_loc7_);
         var _loc8_:Bitmap = new Bitmap();
         _loc8_.bitmapData = new art_beegarden();
         _loc8_.x = -_loc8_.width / 2;
         _loc8_.y = -_loc8_.height / 2;
         m_add.addChild(_loc8_);
         prepare_base_and_add();
         update_icons();
         m_title = XMLTranslation.s("BEEGARDEN");
         m_title_upgrade = XMLTranslation.s("BEEGARDEN_UPGRADE");
         m_name = m_title;
         m_prod_num = 2;
         m_prod_res = ResType.HONEY;
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
         m_work_anim = new MovieClip();
         this.addChild(m_work_anim);
         this.m_bee_1 = new BmpClip(new art_beegarden_work_1(),1.5,19);
         this.m_bee_2 = new BmpClip(new art_beegarden_work_2(),1,21);
         this.m_bee_1.x = this.m_bee_1.x - 24;
         this.m_bee_1.y = this.m_bee_1.y - 13;
         this.m_bee_2.x = this.m_bee_2.x - 24;
         this.m_bee_2.y = this.m_bee_2.y - 9;
         this.m_bee_1.gotoAndPlay(Math.ceil(Math.random() * this.m_bee_1.totalFrames));
         m_work_anim.addChild(this.m_bee_1);
         m_work_anim.addChild(this.m_bee_2);
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
         if(this.contains(m_work_anim))
         {
            this.m_bee_1.update(param1);
            this.m_bee_2.update(param1);
         }
      }
   }
}
