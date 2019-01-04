package logic.resources
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class ResWoodLogs_1 extends DestroyableObject
   {
       
      
      public function ResWoodLogs_1(param1:Sprite, param2:int, param3:int, param4:int, param5:String, param6:Rectangle = null)
      {
         super(param1,param5,false,3);
         this.x = param2;
         this.y = param3;
         m_gives_res = ResType.WOOD;
         m_gives = param4;
         var _loc7_:Bitmap = new Bitmap(new art_road_logs_1());
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_full.addChild(_loc7_);
         m_name = XMLTranslation.s("RES_OBSTACLE");
         m_gives = param4;
         m_gives_res = ResType.WOOD;
         m_unfog_ellipse = param6;
      }
   }
}
