package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class OptionsMenu extends Sprite
   {
      
      private static var m_this:OptionsMenu = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_ok:SimpleButton = null;
      
      private static var m_music_e:MovieClip = null;
      
      private static var m_music_f:MovieClip = null;
      
      private static var m_sound_e:MovieClip = null;
      
      private static var m_sound_f:MovieClip = null;
      
      private static var m_music_mask:Sprite = null;
      
      private static var m_sound_mask:Sprite = null;
      
      private static var m_music_mark:Sprite = null;
      
      private static var m_sound_mark:Sprite = null;
      
      private static var m_music_drag:Boolean = false;
      
      private static var m_sound_drag:Boolean = false;
       
      
      public function OptionsMenu()
      {
         super();
         if(m_this != null)
         {
         }
         m_this = this;
         this.addEventListener(Event.ADDED_TO_STAGE,on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,on_removed);
      }
      
      public static function init(param1:Sprite) : void
      {
         new OptionsMenu();
         m_layer = param1;
         var _loc2_:MovieClip = new ideOptionsMenu();
         m_this.addChild(_loc2_);
         _loc2_.addChild(XMLTextFields.create("OPTIONS_MENU_TITLE"));
         _loc2_.addChild(XMLTextFields.create("OPTIONS_MENU_MUSIC"));
         _loc2_.addChild(XMLTextFields.create("OPTIONS_MENU_SOUNDS"));
         _loc2_.addChild(XMLTextFields.create("OPTIONS_MENU_OK"));
         (_loc2_.getChildByName("txt_title") as MyTextField).text = XMLTranslation.s("MENU_OPTIONS_TITLE");
         (_loc2_.getChildByName("txt_music") as MyTextField).text = XMLTranslation.s("MENU_OPTIONS_MUSIC");
         (_loc2_.getChildByName("txt_sounds") as MyTextField).text = XMLTranslation.s("MENU_OPTIONS_SOUNDS");
         (_loc2_.getChildByName("txt_ok") as MyTextField).text = XMLTranslation.s("MENU_OPTIONS_OK");
         m_ok = _loc2_.getChildByName("btn_ok") as SimpleButton;
         m_music_e = _loc2_.getChildByName("bar_music_e") as MovieClip;
         m_music_f = _loc2_.getChildByName("bar_music_f") as MovieClip;
         m_music_mark = _loc2_.getChildByName("music_mark") as MovieClip;
         m_sound_e = _loc2_.getChildByName("bar_sound_e") as MovieClip;
         m_sound_f = _loc2_.getChildByName("bar_sound_f") as MovieClip;
         m_sound_mark = _loc2_.getChildByName("sound_mark") as MovieClip;
         m_music_mark.mouseEnabled = false;
         m_music_mark.mouseChildren = false;
         m_sound_mark.mouseEnabled = false;
         m_sound_mark.mouseChildren = false;
         m_music_f.mouseChildren = false;
         m_music_f.mouseEnabled = false;
         m_sound_f.mouseChildren = false;
         m_sound_f.mouseEnabled = false;
         m_music_mask = new Sprite();
         m_music_f.mask = m_music_mask;
         m_music_f.addChild(m_music_mask);
         m_sound_mask = new Sprite();
         m_sound_f.mask = m_sound_mask;
         m_sound_f.addChild(m_sound_mask);
      }
      
      public static function show() : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_this.alpha = 0;
         TweenLite.to(m_this,0.5,{"alpha":1});
         update_music(Save.get_music_level());
         update_sound(Save.get_sound_level());
      }
      
      public static function hide() : void
      {
         if(m_layer != null && m_layer.contains(m_this))
         {
            m_layer.removeChild(m_this);
         }
      }
      
      private static function on_added(param1:Event) : void
      {
         m_ok.addEventListener(MouseEvent.CLICK,on_ok);
         m_ok.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_music_e.addEventListener(MouseEvent.MOUSE_DOWN,on_music_down);
         m_music_e.addEventListener(MouseEvent.MOUSE_UP,on_music_up);
         m_music_e.addEventListener(MouseEvent.MOUSE_OUT,on_music_out);
         m_music_e.addEventListener(MouseEvent.MOUSE_MOVE,on_music_move);
         m_sound_e.addEventListener(MouseEvent.MOUSE_DOWN,on_sound_down);
         m_sound_e.addEventListener(MouseEvent.MOUSE_UP,on_sound_up);
         m_sound_e.addEventListener(MouseEvent.MOUSE_OUT,on_sound_out);
         m_sound_e.addEventListener(MouseEvent.MOUSE_MOVE,on_sound_move);
      }
      
      private static function on_removed(param1:Event) : void
      {
         m_ok.removeEventListener(MouseEvent.CLICK,on_ok);
         m_ok.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
      }
      
      private static function on_ok(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         hide();
      }
      
      private static function on_music_down(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.localX / param1.currentTarget.width;
         update_music(_loc2_);
         m_music_drag = true;
      }
      
      private static function on_music_up(param1:MouseEvent) : void
      {
         m_music_drag = false;
      }
      
      private static function on_music_out(param1:MouseEvent) : void
      {
         m_music_drag = false;
      }
      
      private static function on_music_move(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(m_music_drag)
         {
            _loc2_ = param1.localX / param1.currentTarget.width;
            update_music(_loc2_);
         }
      }
      
      private static function on_sound_down(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.localX / param1.currentTarget.width;
         update_sound(_loc2_);
         m_sound_drag = true;
      }
      
      private static function on_sound_up(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         m_sound_drag = false;
      }
      
      private static function on_sound_out(param1:MouseEvent) : void
      {
         m_sound_drag = false;
      }
      
      private static function on_sound_move(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(m_sound_drag)
         {
            _loc2_ = param1.localX / param1.currentTarget.width;
            update_sound(_loc2_);
         }
      }
      
      private static function update_music(param1:Number) : void
      {
         if(param1 < 0.1)
         {
            param1 = 0;
         }
         if(param1 > 0.9)
         {
            param1 = 1;
         }
         m_music_mask.graphics.clear();
         m_music_mask.graphics.beginFill(16777215,1);
         m_music_mask.graphics.drawRect(0,0,m_music_f.width * param1,m_music_f.height);
         m_music_mask.graphics.endFill();
         m_music_mark.x = m_music_f.x + param1 * m_music_f.width;
         Save.save_music_level(param1);
         SndMgr.set_volume("main_music",param1);
      }
      
      private static function update_sound(param1:Number) : void
      {
         if(param1 < 0.1)
         {
            param1 = 0;
         }
         if(param1 > 0.9)
         {
            param1 = 1;
         }
         m_sound_mask.graphics.clear();
         m_sound_mask.graphics.beginFill(16777215,1);
         m_sound_mask.graphics.drawRect(0,0,m_sound_f.width * param1,m_sound_f.height);
         m_sound_mask.graphics.endFill();
         m_sound_mark.x = m_sound_f.x + param1 * m_sound_f.width;
         Save.save_sound_level(param1);
      }
      
      private static function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
