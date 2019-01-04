package logic.resources
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RoadRocks_2 extends DestroyableObject
   {
       
      
      public function RoadRocks_2(param1:Sprite, param2:int, param3:int, param4:int, param5:String)
      {
         super(param1,param5,false,3);
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap(new art_road_rocks_2());
         _loc6_.x = -_loc6_.width / 2;
         _loc6_.y = -_loc6_.height / 2;
         m_full.addChild(_loc6_);
         m_name = XMLTranslation.s("RES_OBSTACLE");
         m_gives = param4;
         m_gives_res = ResType.STONE;
      }
   }
}
