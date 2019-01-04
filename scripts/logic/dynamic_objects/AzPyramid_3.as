package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class AzPyramid_3 extends RepairableObject
   {
       
      
      public function AzPyramid_3(param1:Sprite, param2:int, param3:int, param4:String, param5:Boolean = false, param6:Rectangle = null)
      {
         super(param1,param4,true,7);
         this.x = param2;
         this.y = param3;
         m_pbar.y = m_pbar.y - 20;
         m_sel_g.scaleX = 1.6;
         m_sel_g.scaleY = 1.6;
         m_sel_r.scaleX = 1.6;
         m_sel_r.scaleY = 1.6;
         var _loc7_:Bitmap = new Bitmap(new art_pyramid_az_3());
         _loc7_.x = -_loc7_.width / 2;
         _loc7_.y = -_loc7_.height / 2;
         this.addChild(_loc7_);
         m_name = XMLTranslation.s("AZ_PYRAMID");
         m_uses_res = ResType.WOOD;
         m_uses = 7;
         m_unfog_ellipse = param6;
         if(param5)
         {
            hide();
         }
      }
      
      override public function infownd_yoffset() : int
      {
         return 30;
      }
   }
}
