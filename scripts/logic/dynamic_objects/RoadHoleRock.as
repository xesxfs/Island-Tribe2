package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import logic.resources.DestroyableObject;
   import logic.resources.ResType;
   
   public class RoadHoleRock extends DestroyableObject
   {
       
      
      public function RoadHoleRock(param1:Sprite, param2:int, param3:int, param4:String, param5:Boolean = false)
      {
         super(param1,param4,false,3.5);
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap();
         _loc6_.bitmapData = new art_road_hole_rock();
         _loc6_.x = -_loc6_.width * 0.5;
         _loc6_.y = -_loc6_.height * 0.5;
         m_full.addChild(_loc6_);
         m_name = XMLTranslation.s("RES_OBSTACLE");
         m_gives_res = ResType.STONE;
         m_gives = 2;
         if(param5)
         {
            hide();
         }
      }
   }
}
