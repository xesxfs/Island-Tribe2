package logic.resources
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class ResMilk extends PickupableObject
   {
       
      
      public function ResMilk(param1:Sprite, param2:int, param3:int, param4:int, param5:String, param6:Rectangle = null)
      {
         super(param1,param5);
         this.x = param2;
         this.y = param3;
         m_gives_res = ResType.MILK;
         m_gives = param4;
         var _loc7_:Bitmap = new Bitmap(new art_res_milk());
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         m_art = new MovieClip();
         m_art.addChild(_loc7_);
         this.addChild(m_art);
         m_name = XMLTranslation.s("RES_MILK");
         m_unfog_ellipse = param6;
      }
   }
}
