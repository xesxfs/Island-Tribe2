package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class TotemStone_Broken extends RepairableObject
   {
       
      
      public function TotemStone_Broken(param1:Sprite, param2:int, param3:int, param4:String, param5:Rectangle = null)
      {
         super(param1,param4,false,4);
         m_remove_after = false;
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap();
         _loc6_.bitmapData = new art_totem_stone_broken();
         _loc6_.x = -_loc6_.width * 0.55;
         _loc6_.y = -_loc6_.height * 0.7;
         m_broken.addChild(_loc6_);
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_totem_stone();
         _loc7_.x = -_loc7_.width * 0.5;
         _loc7_.y = -_loc7_.height * 0.7;
         m_full.addChild(_loc7_);
         m_name = XMLTranslation.s("TOTEM_BROKEN");
         m_uses = 5;
         m_uses_res = ResType.STONE;
      }
      
      override public function infownd_yoffset() : int
      {
         return 25;
      }
   }
}
