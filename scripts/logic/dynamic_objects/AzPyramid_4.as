package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import logic.LevelObject;
   
   public class AzPyramid_4 extends LevelObject
   {
       
      
      public function AzPyramid_4(param1:Sprite, param2:int, param3:int, param4:String, param5:Boolean = false)
      {
         super(param1,true,param4);
         m_sel_g = null;
         m_sel_r = null;
         this.x = param2;
         this.y = param3;
         var _loc6_:Bitmap = new Bitmap(new art_pyramid_az_4());
         _loc6_.x = -_loc6_.width / 2;
         _loc6_.y = -_loc6_.height / 2;
         this.addChild(_loc6_);
         m_name = XMLTranslation.s("AZ_PYRAMID");
         if(param5)
         {
            hide();
         }
      }
      
      override public function infownd_yoffset() : int
      {
         return 30;
      }
      
      override protected function on_click(param1:MouseEvent) : void
      {
      }
   }
}
