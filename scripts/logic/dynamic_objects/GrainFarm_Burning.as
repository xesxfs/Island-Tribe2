package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class GrainFarm_Burning extends RepairableObject
   {
       
      
      public function GrainFarm_Burning(param1:Sprite, param2:int, param3:int, param4:String, param5:Rectangle = null)
      {
         super(param1,param4,true,0.5);
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap();
         _loc6_.bitmapData = new art_grainfarm_broken();
         _loc6_.x = -_loc6_.width / 2;
         _loc6_.y = -_loc6_.height / 2;
         m_broken.addChild(_loc6_);
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_grainfarm();
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_full.addChild(_loc7_);
         m_fire = new BmpClip(new art_fire(),0.6,6);
         m_fire.blendMode = BlendMode.ADD;
         m_fire.x = -20;
         m_fire.y = -65;
         m_fire.scaleX = 2;
         m_fire.scaleY = 1.5;
         this.addChild(m_fire);
         m_name = XMLTranslation.s("BLD_GRAINFARM_BURNING");
         m_uses = 2;
         m_uses_res = ResType.WATER;
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
