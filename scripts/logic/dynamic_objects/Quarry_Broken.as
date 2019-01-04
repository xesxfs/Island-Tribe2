package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class Quarry_Broken extends RepairableObject
   {
       
      
      public function Quarry_Broken(param1:Sprite, param2:int, param3:int, param4:String, param5:Boolean = false, param6:Rectangle = null)
      {
         super(param1,param4,true,6);
         this.x = param2;
         this.y = param3;
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_quarry_broken();
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_broken.addChild(_loc7_);
         var _loc8_:Bitmap = new Bitmap();
         _loc8_.bitmapData = new art_quarry();
         _loc8_.x = -_loc8_.width / 2;
         _loc8_.y = -_loc8_.height / 2;
         m_full.addChild(_loc8_);
         m_name = XMLTranslation.s("QUARRY_BROKEN");
         m_uses = 2;
         m_uses_res = ResType.STONE;
         m_unfog_ellipse = param6;
         m_dust = new BmpClip(new art_build_dust(),2.5,25);
         m_dust.x = -m_dust.width / 2;
         m_dust.y = -m_dust.height / 2;
         if(param5)
         {
            hide();
         }
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
