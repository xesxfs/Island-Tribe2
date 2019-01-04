package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import logic.resources.ResType;
   
   public class RoadLavaRock extends RepairableObject
   {
       
      
      public function RoadLavaRock(param1:Sprite, param2:int, param3:int, param4:String)
      {
         super(param1,param4,false,0.05);
         this.x = param2;
         this.y = param3;
         var _loc5_:Bitmap = new Bitmap();
         _loc5_.bitmapData = new art_road_lavarock();
         _loc5_.x = -_loc5_.width * 0.5;
         _loc5_.y = -_loc5_.height * 0.5;
         m_broken.addChild(_loc5_);
         m_name = XMLTranslation.s("ROAD_LAVA");
         m_uses_res = ResType.WATER;
         m_uses = 3;
      }
   }
}
