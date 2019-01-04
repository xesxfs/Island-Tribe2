package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class GrainFarm_Broken extends RepairableObject
   {
       
      
      public function GrainFarm_Broken(param1:Sprite, param2:int, param3:int, param4:String, param5:Boolean = false, param6:Rectangle = null)
      {
         super(param1,param4,true,5);
         this.x = param2;
         this.y = param3;
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_grainfarm_broken();
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_broken.addChild(_loc7_);
         var _loc8_:Bitmap = new Bitmap();
         _loc8_.bitmapData = new art_grainfarm();
         _loc8_.x = -_loc8_.width / 2;
         _loc8_.y = -_loc8_.height / 2;
         m_full.addChild(_loc8_);
         m_name = XMLTranslation.s("BLD_GRAINFARM_BROKEN");
         m_uses = 2;
         m_uses_res = ResType.WOOD;
         m_unfog_ellipse = param6;
         if(param5)
         {
            hide();
         }
         var _loc9_:Bitmap = new Bitmap(new art_broken_building_icon());
         _loc9_.x = -_loc9_.width * 0.5;
         _loc9_.y = -_loc9_.height;
         this.addChild(_loc9_);
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
