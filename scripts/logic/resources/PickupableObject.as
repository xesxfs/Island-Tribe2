package logic.resources
{
   import flash.display.Sprite;
   import logic.DynamicObject;
   import logic.GameLevel;
   import logic.LevelTriggers;
   import logic.Worker;
   
   public class PickupableObject extends DynamicObject
   {
       
      
      public function PickupableObject(param1:Sprite, param2:String)
      {
         super(param1,param2,false);
      }
      
      override public function on_worker_visit(param1:Worker) : void
      {
         GameLevel.set_node_passable(m_nodeid);
         if(m_gives_res != ResType.DIAMONDS)
         {
            param1.start_carrying();
         }
         super.on_worker_visit(param1);
         if(m_overed)
         {
            GameLevel.hide_infownd();
         }
         hide();
         LevelTriggers.on_object_picked_up(m_uid);
      }
      
      override public function infownd_yoffset() : int
      {
         return 35;
      }
      
      override public function arrive_radius() : Number
      {
         return 10;
      }
   }
}
