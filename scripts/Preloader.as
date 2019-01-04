package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.utils.getDefinitionByName;
   import mochi.as3.MochiAd;
   
   public class Preloader extends MovieClip
   {
      
      public static var gameid:String = "1a83183fba7a57a4";
      
      public static var mochiADClip:MovieClip;
       
      
      private var pic_back:Class;
      
      private var pic_logo:Class;
      
      private var m_logo:Sprite;
      
      private var m_mask:Sprite;
      
      private var m_bytes_start:int = -1;
      
      public function Preloader()
      {
         this.pic_back = Preloader_pic_back;
         this.pic_logo = Preloader_pic_logo;
         this.m_logo = new Sprite();
         this.m_mask = new Sprite();
         super();
         if(stage)
         {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.SHOW_ALL;
         }
         mochiADClip = new MovieClip();
         addChild(mochiADClip);
         MochiAd.showPreGameAd({
            "clip":mochiADClip,
            "id":Preloader.gameid,
            "res":640 + "x" + 480,
            "ad_finished":this.startLoading
         });
      }
      
      private function startLoading() : void
      {
         addEventListener(Event.ENTER_FRAME,this.checkFrame);
         loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progress);
         loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         this.addChild(new this.pic_back());
         this.m_logo.addChild(new this.pic_logo());
         this.m_logo.x = 70;
         this.m_logo.y = 6;
         this.addChild(this.m_logo);
         this.m_logo.mask = this.m_mask;
         this.m_logo.addChild(this.m_mask);
      }
      
      private function ioError(param1:IOErrorEvent) : void
      {
      }
      
      private function progress(param1:ProgressEvent) : void
      {
         if(this.m_bytes_start < 0)
         {
            this.m_bytes_start = param1.bytesLoaded;
         }
         var _loc2_:Number = (param1.bytesLoaded - this.m_bytes_start) / (param1.bytesTotal - this.m_bytes_start);
         this.m_mask.graphics.beginFill(16777215,1);
         this.m_mask.graphics.drawRect(0,0,this.m_logo.width * _loc2_,this.m_logo.height);
         this.m_mask.graphics.endFill();
      }
      
      private function checkFrame(param1:Event) : void
      {
         if(currentFrame == totalFrames)
         {
            stop();
            this.loadingFinished();
         }
      }
      
      private function loadingFinished() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.checkFrame);
         loaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progress);
         loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         this.startup();
      }
      
      private function startup() : void
      {
         var _loc1_:Class = getDefinitionByName("Application") as Class;
         stage.addChild(new _loc1_() as DisplayObject);
         parent.removeChild(this);
      }
   }
}
