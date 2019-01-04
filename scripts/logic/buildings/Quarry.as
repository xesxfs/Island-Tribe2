package logic.buildings
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import logic.resources.ResType;
   
   public class Quarry extends BaseBuilding
   {
       
      
      public function Quarry(param1:Sprite, param2:int, param3:int, param4:String, param5:int, param6:int, param7:Boolean = false)
      {
         super(param1,param4,param5);
         this.x = param2;
         this.y = param3;
         var _loc8_:Bitmap = new Bitmap();
         _loc8_.bitmapData = new art_quarry();
         _loc8_.x = -_loc8_.width / 2;
         _loc8_.y = -_loc8_.height / 2;
         m_base.addChild(_loc8_);
         var _loc9_:Bitmap = new Bitmap();
         _loc9_.bitmapData = new art_quarry();
         _loc9_.x = -_loc9_.width / 2;
         _loc9_.y = -_loc9_.height / 2;
         m_add.addChild(_loc9_);
         prepare_base_and_add();
         update_icons();
         m_title = XMLTranslation.s("QUARRY");
         m_title_upgrade = XMLTranslation.s("QUARRY_UPGRADE");
         m_name = m_title;
         m_prod_num = 2;
         m_prod_res = ResType.STONE;
         m_prod_len = 15;
         m_upgrade_len = 4.5;
         m_upgrade_res = ResType.STONE;
         m_upgrade_cost = 2;
         m_upgrade_result = 3;
         if(param6 > 1)
         {
            m_cur_level = param6 - 1;
            this.on_upgrade_completed();
         }
         m_work_anim = new BmpClip(new art_quarry_work(),1.3,13);
         m_work_anim.x = -18;
         m_work_anim.y = -18;
         this.addChild(m_work_anim);
         if(param7)
         {
            hide();
         }
      }
      
      override protected function on_upgrade_completed() : void
      {
         super.on_upgrade_completed();
         if(m_cur_level == 2)
         {
            m_upgrade_len = 4.5;
            m_upgrade_res = ResType.STONE;
            m_upgrade_cost = 2;
            m_upgrade_result = 4;
         }
      }
   }
}
