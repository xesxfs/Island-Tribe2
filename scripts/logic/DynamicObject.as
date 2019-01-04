package logic
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DynamicObject extends LevelObject
   {
       
      
      protected var m_art:Sprite = null;
      
      public function DynamicObject(param1:Sprite, param2:String, param3:Boolean)
      {
         super(param1,param3,param2);
         this.m_art = new Sprite();
         this.addChild(this.m_art);
         this.buttonMode = true;
      }
      
      override protected function on_added(param1:Event) : void
      {
         super.on_added(param1);
      }
      
      override protected function on_removed(param1:Event) : void
      {
         super.on_removed(param1);
         if(this.m_art)
         {
            this.m_art.removeEventListener(MouseEvent.CLICK,on_click);
         }
      }
   }
}
