package logic
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.GradientType;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   
   public class WarFog extends Sprite
   {
       
      
      private var m_fog:Bitmap;
      
      public function WarFog()
      {
         this.m_fog = new Bitmap();
         super();
         this.reset();
         this.addChild(this.m_fog);
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      private function on_click(param1:MouseEvent) : void
      {
         var _loc2_:uint = this.m_fog.bitmapData.getPixel32(param1.localX,param1.localY);
         var _loc3_:uint = _loc2_ >> 24 & 255;
      }
      
      public function reset() : void
      {
         this.m_fog.bitmapData = new BitmapData(640,480,true,4008636142);
      }
      
      public function show_zone(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:Sprite = new Sprite();
         var _loc6_:Matrix = new Matrix();
         var _loc7_:Array = [16777215,16777215,16777215,16777215];
         var _loc8_:Array = [1,1,1,0];
         var _loc9_:Array = [0,0,225,255];
         _loc6_.createGradientBox(100,100);
         _loc5_.graphics.lineStyle();
         _loc5_.graphics.beginGradientFill(GradientType.RADIAL,_loc7_,_loc8_,_loc9_,_loc6_);
         _loc5_.graphics.drawEllipse(0,0,100,100);
         _loc5_.graphics.endFill();
         var _loc10_:Matrix = new Matrix();
         _loc10_.translate(-_loc5_.width / 2,-_loc5_.height / 2);
         _loc10_.scale(param3 / 100,param4 / 100);
         _loc10_.translate(param1,param2);
         this.m_fog.bitmapData.draw(_loc5_,_loc10_,null,BlendMode.ERASE);
      }
      
      public function hit_test(param1:int, param2:int) : Boolean
      {
         var _loc3_:uint = this.m_fog.bitmapData.getPixel32(param1,param2);
         var _loc4_:uint = _loc3_ >> 24 & 255;
         if(_loc4_ > 0)
         {
            return true;
         }
         return false;
      }
   }
}
