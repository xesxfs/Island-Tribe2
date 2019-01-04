package
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SplashScreen extends Sprite
   {
       
      
      private var m_callback:Function = null;
      
      private var m_timer_cur:Number = 0.0;
      
      private var m_timer_max:Number = 3.0;
      
      private var m_fill:Sprite = null;
      
      public function SplashScreen(param1:Function)
      {
         super();
         var _loc2_:Class = SplashScreen_image_class;
         this.addChild(new _loc2_());
         this.m_callback = param1;
         this.m_fill = new Sprite();
         this.m_fill.graphics.beginFill(0,1);
         this.m_fill.graphics.drawRect(0,0,640,480);
         this.m_fill.graphics.endFill();
         this.addChild(this.m_fill);
         this.addEventListener(Event.ENTER_FRAME,this.on_frame);
      }
      
      public function on_frame(param1:Event) : void
      {
         this.m_timer_cur = this.m_timer_cur + 1 / this.stage.frameRate;
         var _loc2_:Number = this.m_timer_cur / this.m_timer_max;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         if(_loc2_ < 0.1)
         {
            this.m_fill.alpha = 1 - _loc2_ / 0.1;
         }
         else if(_loc2_ > 0.9)
         {
            this.m_fill.alpha = (_loc2_ - 0.9) / 0.1;
         }
         else
         {
            this.m_fill.alpha = 0;
         }
         if(this.m_timer_cur > this.m_timer_max)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.on_frame);
            if(this.m_callback != null)
            {
               this.m_callback(this);
            }
         }
      }
   }
}
