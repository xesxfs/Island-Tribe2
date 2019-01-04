package logic.resources
{
   import flash.display.Sprite;
   import logic.DynamicObject;
   import logic.buildings.BaseBuilding;
   
   public class ProdResourceFactory
   {
       
      
      public function ProdResourceFactory()
      {
         super();
      }
      
      public static function create(param1:int, param2:Sprite, param3:int, param4:int, param5:int, param6:String, param7:BaseBuilding) : DynamicObject
      {
         var _loc8_:DynamicObject = null;
         switch(param1)
         {
            case ResType.WOOD:
               _loc8_ = new ResWood(param2,param3,param4,param5,param6);
               break;
            case ResType.WATER:
               _loc8_ = new ResWater(param2,param3,param4,param5,param6);
               break;
            case ResType.GRAIN:
               _loc8_ = new ResGrain(param2,param3,param4,param5,param6);
               break;
            case ResType.HONEY:
               _loc8_ = new ResHoney(param2,param3,param4,param5,param6);
               break;
            case ResType.STONE:
               _loc8_ = new ResStone(param2,param3,param4,param5,param6);
         }
         _loc8_.set_owner(param7);
         return _loc8_;
      }
   }
}
