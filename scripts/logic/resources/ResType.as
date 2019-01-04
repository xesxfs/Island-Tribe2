package logic.resources
{
   import flash.display.Bitmap;
   
   public class ResType
   {
      
      public static const NONE:int = -1;
      
      public static const WORKER:int = 0;
      
      public static const WOOD:int = 1;
      
      public static const STONE:int = 2;
      
      public static const WATER:int = 3;
      
      public static const GRAIN:int = 4;
      
      public static const HONEY:int = 5;
      
      public static const DIAMONDS:int = 6;
      
      public static const MILK:int = 7;
      
      public static const LVLRES_LAST:int = 8;
       
      
      public function ResType()
      {
         super();
      }
      
      public static function new_icon(param1:int) : Bitmap
      {
         var _loc2_:Bitmap = null;
         switch(param1)
         {
            case ResType.WORKER:
               _loc2_ = new Bitmap(new art_res_worker());
               break;
            case ResType.WOOD:
               _loc2_ = new Bitmap(new art_res_wood());
               break;
            case ResType.STONE:
               _loc2_ = new Bitmap(new art_res_stone());
               break;
            case ResType.WATER:
               _loc2_ = new Bitmap(new art_res_water());
               break;
            case ResType.GRAIN:
               _loc2_ = new Bitmap(new art_res_grain());
               break;
            case ResType.HONEY:
               _loc2_ = new Bitmap(new art_res_honey());
               break;
            case ResType.MILK:
               _loc2_ = new Bitmap(new art_res_milk());
         }
         if(_loc2_)
         {
            _loc2_.smoothing = true;
         }
         return _loc2_;
      }
   }
}
