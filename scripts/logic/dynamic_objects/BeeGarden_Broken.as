package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class BeeGarden_Broken extends RepairableObject
   {
       
      
      public function BeeGarden_Broken(param1:Sprite, param2:int, param3:int, param4:String, param5:Rectangle = null)
      {
         super(param1,param4,true,6);
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap();
         _loc6_.bitmapData = new art_beegarden_broken();
         _loc6_.x = -_loc6_.width / 2;
         _loc6_.y = -_loc6_.height / 2;
         m_broken.addChild(_loc6_);
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_beegarden();
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_full.addChild(_loc7_);
         m_name = XMLTranslation.s("BEEGARDEN_BROKEN");
         m_uses = 4;
         m_uses_res = ResType.WOOD;
         m_unfog_ellipse = param5;
         var _loc8_:Bitmap = new Bitmap(new art_broken_building_icon());
         _loc8_.x = -_loc8_.width * 0.5;
         _loc8_.y = -_loc8_.height;
         this.addChild(_loc8_);
         m_dust = new BmpClip(new art_build_dust(),2.5,25);
         m_dust.x = -m_dust.width / 2;
         m_dust.y = -m_dust.height / 2;
      }
      
      override public function infownd_yoffset() : int
      {
         return 25;
      }
      
      override public function arrive_radius() : Number
      {
         return 0;
      }
   }
}
