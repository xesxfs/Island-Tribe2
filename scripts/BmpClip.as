package
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Matrix;
   
   public class BmpClip extends MovieClip
   {
       
      
      private var m_frame_w:Number;
      
      private var m_frame_h:Number;
      
      private var m_cur_frame:Number;
      
      private var m_frames_num:Number;
      
      private var m_cur_time:Number;
      
      private var m_duration:Number;
      
      private var m_pivot_x:Number = 0;
      
      private var m_pivot_y:Number = 0;
      
      private var m_sheet:BitmapData;
      
      private var m_rows:Number = 0;
      
      private var m_cols:Number = 0;
      
      private var m_stoped:Boolean = false;
      
      private var m_use_enter_frame:Boolean = false;
      
      private var m_loaded:Boolean = false;
      
      public function BmpClip(param1:BitmapData, param2:Number, param3:int = -1)
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         this.m_cur_frame = -1;
         this.m_cur_time = 0;
         this.m_sheet = param1;
         if(param3 < 0)
         {
            this.m_frames_num = Math.ceil(param1.height / param1.width);
         }
         else
         {
            this.m_frames_num = param3;
         }
         this.m_duration = param2;
         this.m_pivot_x = 0;
         this.m_pivot_y = 0;
         this.m_frame_w = param1.width;
         this.m_frame_h = param1.height / this.m_frames_num;
         this.m_cols = 1;
         this.m_rows = this.m_frames_num;
         this.m_loaded = true;
         this.x = 0;
         this.y = 0;
         this.updateGraphics();
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1 - this.m_pivot_x;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1 - this.m_pivot_y;
      }
      
      override public function get x() : Number
      {
         return super.x + this.m_pivot_x;
      }
      
      override public function get y() : Number
      {
         return super.y + this.m_pivot_y;
      }
      
      override public function get totalFrames() : int
      {
         return this.m_frames_num;
      }
      
      override public function get currentFrame() : int
      {
         return this.m_cur_frame;
      }
      
      public function get loaded() : Boolean
      {
         return this.m_loaded;
      }
      
      public function onAdded(param1:Event) : void
      {
         if(this.m_use_enter_frame)
         {
            this.addEventListener(Event.ENTER_FRAME,this.onFrame);
         }
         this.update(0);
      }
      
      public function onRemoved(param1:Event) : void
      {
         if(this.m_use_enter_frame)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onFrame);
         }
      }
      
      public function onFrame(param1:Event) : void
      {
         this.update(1 / 32);
      }
      
      public function update(param1:Number) : void
      {
         if(this.m_stoped)
         {
            return;
         }
         this.m_cur_time = this.m_cur_time + param1;
         while(this.m_cur_time > this.m_duration)
         {
            this.m_cur_time = this.m_cur_time - this.m_duration;
         }
         var _loc2_:Number = this.m_cur_frame;
         this.m_cur_frame = Math.ceil(this.m_frames_num * this.m_cur_time / this.m_duration);
         if(this.m_cur_frame != _loc2_)
         {
            this.updateGraphics();
         }
      }
      
      public function updateGraphics() : void
      {
         if(!this.m_sheet)
         {
            return;
         }
         var _loc1_:Number = (this.m_cur_frame - 1) % this.m_cols;
         var _loc2_:Number = Math.floor((this.m_cur_frame - 1) / this.m_cols);
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(-this.m_frame_w * _loc1_,-this.m_frame_h * _loc2_);
         this.graphics.clear();
         this.graphics.beginBitmapFill(this.m_sheet,_loc3_);
         this.graphics.drawRect(0,0,this.m_frame_w,this.m_frame_h);
         this.graphics.endFill();
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         this.m_stoped = false;
         this.m_cur_frame = Number(param1);
         this.m_cur_time = this.m_cur_frame / this.m_frames_num * this.m_duration;
         this.updateGraphics();
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         this.m_stoped = true;
         this.m_cur_frame = Number(param1);
         this.m_cur_time = this.m_cur_frame / this.m_frames_num * this.m_duration;
         this.updateGraphics();
      }
      
      override public function stop() : void
      {
         this.m_stoped = true;
      }
      
      public function dontUseEnterFrame() : void
      {
         this.m_use_enter_frame = false;
      }
   }
}
