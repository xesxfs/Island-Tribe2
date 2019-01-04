package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class RoadLava extends RepairableObject
   {
       
      
      public function RoadLava(param1:Sprite, param2:int, param3:int, param4:String, param5:Rectangle = null)
      {
         super(param1,param4,false,0.05);
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap();
         _loc6_.bitmapData = new art_road_lava();
         _loc6_.x = -_loc6_.width * 0.5;
         _loc6_.y = -_loc6_.height * 0.5;
         m_broken.addChild(_loc6_);
         m_name = XMLTranslation.s("ROAD_BROKEN");
         m_uses_res = ResType.WATER;
         m_uses = 2;
         m_unfog_ellipse = param5;
      }
   }
}
