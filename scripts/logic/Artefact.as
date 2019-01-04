package logic
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Artefact extends Sprite
   {
       
      
      private var m_layer:Sprite = null;
      
      private var m_timer:Number = -1;
      
      private var m_art:Bitmap = null;
      
      private var m_is_active:Boolean = true;
      
      public function Artefact(param1:Sprite, param2:BitmapData, param3:int, param4:int)
      {
         super();
         this.m_layer = param1;
         this.x = param3;
         this.y = param4;
         this.m_art = new Bitmap(param2);
         this.m_art.smoothing = true;
         this.m_art.x = -this.m_art.width / 2;
         this.m_art.y = -this.m_art.height / 2;
         this.addChild(this.m_art);
         this.buttonMode = true;
         this.addEventListener(Event.ADDED_TO_STAGE,this.on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.on_removed);
      }
      
      private function on_added(param1:Event) : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.on_over);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.on_out);
         this.addEventListener(MouseEvent.CLICK,this.on_click);
      }
      
      private function on_removed(param1:Event) : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.on_over);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.on_out);
         this.removeEventListener(MouseEvent.CLICK,this.on_click);
      }
      
      private function on_over(param1:MouseEvent) : void
      {
         this.scaleX = 1.1;
         this.scaleY = 1.1;
      }
      
      private function on_out(param1:MouseEvent) : void
      {
         this.scaleX = 1;
         this.scaleY = 1;
      }
      
      private function on_click(param1:MouseEvent) : void
      {
         GameLevel.on_artefact_click();
         this.hide();
      }
      
      public function show(param1:Number) : void
      {
         if(!this.m_layer.contains(this))
         {
            this.m_layer.addChild(this);
         }
         this.m_timer = param1;
         this.m_is_active = false;
      }
      
      public function hide() : void
      {
         if(this.m_layer.contains(this))
         {
            this.m_layer.removeChild(this);
         }
      }
      
      public function quant(param1:Number) : void
      {
         if(this.m_timer > 0)
         {
            this.m_timer = this.m_timer - param1;
            if(this.m_timer <= 0)
            {
               this.m_timer = -1;
               this.hide();
            }
         }
      }
      
      public function is_active() : Boolean
      {
         return this.m_is_active;
      }
   }
}
