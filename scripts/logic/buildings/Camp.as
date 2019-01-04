package logic.buildings
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class Camp extends BaseBuilding
   {
       
      
      public function Camp(param1:Sprite, param2:int, param3:int, param4:String, param5:int, param6:Rectangle)
      {
         super(param1,param4,param5);
         m_sel_g = null;
         m_sel_r = null;
         this.x = param2;
         this.y = param3;
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_Camp();
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_base.addChild(_loc7_);
         var _loc8_:Bitmap = new Bitmap();
         _loc8_.bitmapData = new art_Camp();
         _loc8_.x = -_loc8_.width / 2;
         _loc8_.y = -_loc8_.height / 2;
         m_add.addChild(_loc8_);
         prepare_base_and_add();
         update_icons();
         m_title = XMLTranslation.s("BLD_CAMP");
         m_title_upgrade = XMLTranslation.s("BLD_CAMP_UPGRADE");
         m_name = m_title;
         m_upgrade_len = 5;
         m_upgrade_res = ResType.WOOD;
         m_upgrade_cost = 5;
         m_prod_res = ResType.WORKER;
         m_upgrade_result = 1;
         m_unfog_ellipse = param6;
      }
   }
}
