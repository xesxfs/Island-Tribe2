package logic.resources
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ResHoney extends PickupableObject
   {
       
      
      public function ResHoney(param1:Sprite, param2:int, param3:int, param4:int, param5:String)
      {
         super(param1,param5);
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap(new art_res_honey());
         _loc6_.x = -_loc6_.width / 2;
         _loc6_.y = -_loc6_.height / 2;
         m_art = new MovieClip();
         m_art.addChild(_loc6_);
         this.addChild(m_art);
         m_name = XMLTranslation.s("RES_HONEY");
         m_gives = param4;
         m_gives_res = ResType.HONEY;
      }
   }
}
