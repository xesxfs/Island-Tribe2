package logic.dynamic_objects
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import logic.Worker;
   import logic.resources.DestroyableObject;
   import logic.resources.ResType;
   
   public class RoadWasps extends DestroyableObject
   {
       
      
      private var m_wasps:Array = null;
      
      private var m_wasps_layer:Sprite = null;
      
      public function RoadWasps(param1:Sprite, param2:int, param3:int, param4:String)
      {
         var _loc6_:BmpClip = null;
         super(param1,param4,false,0.05);
         this.x = param2;
         this.y = param3;
         this.m_wasps_layer = new Sprite();
         this.m_wasps_layer.x = -15;
         this.m_wasps_layer.y = -15;
         this.addChild(this.m_wasps_layer);
         this.m_wasps = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < 10)
         {
            _loc6_ = new BmpClip(new art_road_wasps(),0.4);
            _loc6_.x = -10 + Math.random() * 20;
            _loc6_.y = -10 + Math.random() * 20;
            this.m_wasps_layer.addChild(_loc6_);
            this.m_wasps.push(_loc6_);
            _loc5_++;
         }
         m_name = XMLTranslation.s("ROAD_WASPS");
         m_uses_res = ResType.HONEY;
         m_uses = 2;
      }
      
      override public function quant(param1:Number) : void
      {
         var _loc2_:BmpClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Point = null;
         super.quant(param1);
         for each(_loc2_ in this.m_wasps)
         {
            _loc2_.update(param1);
            _loc2_.x = _loc2_.x + (-1 + Math.random() * 2);
            _loc2_.y = _loc2_.y + (-1 + Math.random() * 2);
            _loc3_ = 1;
            _loc4_ = 1;
            if(_loc2_.x < 0)
            {
               _loc3_ = -1;
            }
            if(_loc2_.y < 0)
            {
               _loc4_ = -1;
            }
            _loc5_ = new Point(_loc2_.x,_loc2_.y);
            if(_loc5_.length > 20)
            {
               _loc5_.normalize(20);
            }
            _loc5_.x = _loc5_.x * _loc3_;
            _loc5_.y = _loc5_.y * _loc4_;
            _loc2_.x = _loc5_.x;
            _loc2_.y = _loc5_.y;
         }
      }
      
      override public function on_worker_visit(param1:Worker) : void
      {
         super.on_worker_visit(param1);
         SndMgr.PlaySound("wasps");
      }
   }
}
