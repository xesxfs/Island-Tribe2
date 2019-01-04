package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class RoadHole extends RepairableObject
   {
       
      
      public function RoadHole(param1:Sprite, param2:int, param3:int, param4:String, param5:Boolean = false, param6:Rectangle = null)
      {
         super(param1,param4,false,3.5);
         this.x = param2;
         this.y = param3;
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_road_hole();
         _loc7_.x = -_loc7_.width * 0.5;
         _loc7_.y = -_loc7_.height * 0.5;
         m_broken.addChild(_loc7_);
         m_name = XMLTranslation.s("ROAD_BROKEN");
         m_uses_res = ResType.WOOD;
         m_uses = 2;
         if(param5)
         {
            hide();
         }
         m_unfog_ellipse = param6;
      }
   }
}
