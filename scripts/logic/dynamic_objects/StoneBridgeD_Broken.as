package logic.dynamic_objects
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import logic.resources.ResType;
   
   public class StoneBridgeD_Broken extends RepairableObject
   {
       
      
      public function StoneBridgeD_Broken(param1:Sprite, param2:int, param3:int, param4:Number, param5:String, param6:Rectangle = null)
      {
         super(param1,param5,false,3.5);
         m_remove_after = false;
         this.x = param2;
         this.y = param3;
         var _loc7_:Bitmap = new Bitmap();
         _loc7_.bitmapData = new art_bridge_stone_d_broken();
         _loc7_.smoothing = true;
         var _loc8_:Bitmap = new Bitmap();
         _loc8_.bitmapData = new art_bridge_stone_d();
         _loc8_.smoothing = true;
         var _loc9_:Matrix = new Matrix();
         _loc9_.translate(-_loc7_.width * 0.5,-_loc7_.height * 0.5);
         _loc9_.rotate(param4 * Math.PI / 180);
         _loc7_.transform.matrix = _loc9_;
         _loc8_.transform.matrix = _loc9_;
         m_broken.addChild(_loc7_);
         m_full.addChild(_loc8_);
         m_name = XMLTranslation.s("BRIDGE_BROKEN");
         m_uses = 2;
         m_uses_res = ResType.STONE;
         m_unfog_ellipse = param6;
      }
   }
}
