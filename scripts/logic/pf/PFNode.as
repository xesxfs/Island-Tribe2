package logic.pf
{
   import flash.geom.Point;
   
   public class PFNode
   {
       
      
      private var m_pos:Point;
      
      private var m_passable:Boolean = true;
      
      private var m_strid:String = "";
      
      public var pf_from:int = -1;
      
      public var pf_dist:int = -1;
      
      public function PFNode(param1:int, param2:int, param3:String = "", param4:Boolean = true)
      {
         this.m_pos = new Point();
         super();
         this.m_pos.x = param1;
         this.m_pos.y = param2;
         this.m_strid = param3;
         this.m_passable = param4;
      }
      
      public function pos() : Point
      {
         return this.m_pos;
      }
      
      public function passable() : Boolean
      {
         return this.m_passable;
      }
      
      public function strid() : String
      {
         return this.m_strid;
      }
      
      public function set_pos(param1:int, param2:int) : void
      {
         this.m_pos.x = param1;
         this.m_pos.y = param2;
      }
      
      public function set_passable(param1:Boolean) : void
      {
         this.m_passable = param1;
      }
      
      public function set_strid(param1:String) : void
      {
         this.m_strid = param1;
      }
   }
}
