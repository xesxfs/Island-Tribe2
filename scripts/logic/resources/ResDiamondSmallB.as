package logic.resources
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class ResDiamondSmallB extends PickupableObject
   {
       
      
      public function ResDiamondSmallB(param1:Sprite, param2:int, param3:int, param4:int, param5:String)
      {
         super(param1,param5);
         this.x = param2;
         this.y = param3;
         m_gives_res = ResType.DIAMONDS;
         m_gives = param4;
         var _loc6_:Bitmap = new Bitmap(new art_res_diamond_small_b());
         _loc6_.smoothing = true;
         _loc6_.x = -_loc6_.width / 2;
         _loc6_.y = -_loc6_.height / 2;
         m_art = new MovieClip();
         m_art.addChild(_loc6_);
         m_art.rotation = 0;
         TweenMax.to(m_art,1.5,{
            "rotation":60,
            "y":m_art.y - 2,
            "yoyo":true,
            "repeat":-1,
            "ease":Sine.easeInOut
         });
         this.addChild(m_art);
         m_name = XMLTranslation.s("RES_SMALL_DIAMOND_NAME");
      }
   }
}
