package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class PlayerCreateMenu extends Sprite
   {
      
      private static var m_this:PlayerCreateMenu = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_art:MovieClip = null;
      
      private static var m_ok:SimpleButton = null;
      
      private static var m_cancel:SimpleButton = null;
      
      private static var m_name:TextField = null;
      
      private static var m_ok_txt:MyTextField = null;
      
      private static var m_cancel_txt:MyTextField = null;
       
      
      public function PlayerCreateMenu()
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
         new PlayerCreateMenu();
         m_layer = param1;
         m_art = new idePlayerCreateMenu();
         m_this.addChild(m_art);
         m_ok = m_art.getChildByName("btn_ok") as SimpleButton;
         m_cancel = m_art.getChildByName("btn_cancel") as SimpleButton;
         m_name = m_art.getChildByName("txt_name") as TextField;
         m_name.maxChars = 8;
         m_art.addChild(XMLTextFields.create("PLAYER_CREATE_DLG_OK"));
         m_art.addChild(XMLTextFields.create("PLAYER_CREATE_DLG_CNCL"));
         m_art.addChild(XMLTextFields.create("PLAYER_CREATE_DLG_TEXT"));
         (m_art.getChildByName("txt_ok") as MyTextField).text = XMLTranslation.s("MENU_DLG_OK");
         (m_art.getChildByName("txt_cancel") as MyTextField).text = XMLTranslation.s("MENU_DLG_CANCEL");
         (m_art.getChildByName("txt_enter_your_name") as MyTextField).text = XMLTranslation.s("MENU_PLAYER_CREATE_TEXT");
         var _loc2_:MyTextField = XMLTextFields.create("PLAYER_CREATE_DLG_NEW");
         m_name.x = _loc2_.x;
         m_name.y = _loc2_.y;
         m_name.width = _loc2_.width;
         m_name.height = _loc2_.height;
         m_name.textColor = _loc2_.textColor;
         m_ok_txt = m_art.getChildByName("txt_ok") as MyTextField;
         m_cancel_txt = m_art.getChildByName("txt_cancel") as MyTextField;
      }
      
      public static function show() : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_name.text = "";
         m_this.alpha = 0;
         TweenLite.to(m_this,0.1,{"alpha":1});
         update_ok_button();
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
         m_cancel.addEventListener(MouseEvent.CLICK,on_cancel);
         m_name.addEventListener(KeyboardEvent.KEY_UP,update_ok_button);
         m_ok.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_cancel.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
      }
      
      private static function on_removed(param1:Event) : void
      {
         m_ok.removeEventListener(MouseEvent.CLICK,on_ok);
         m_cancel.removeEventListener(MouseEvent.CLICK,on_cancel);
         m_name.removeEventListener(KeyboardEvent.KEY_UP,update_ok_button);
         m_ok.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_cancel.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
      }
      
      private static function on_ok(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         if(!Save.get_user(m_name.text))
         {
            Save.create_user(m_name.text);
            Save.select_user(m_name.text);
            MainMenu.update_player_welcome();
            PlayersMenu.update_list();
            PlayersMenu.hide();
         }
         PlayerCreateMenu.hide();
      }
      
      private static function on_cancel(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         PlayerCreateMenu.hide();
      }
      
      private static function update_ok_button(param1:KeyboardEvent = null) : void
      {
         var _loc2_:Boolean = false;
         if(m_name.text.length == 0 || Save.get_user(m_name.text) || Save.num_users() >= 5)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            if(m_art.contains(m_ok))
            {
               m_art.removeChild(m_ok);
            }
            if(m_art.contains(m_ok_txt))
            {
               m_art.removeChild(m_ok_txt);
            }
            if(!m_art.contains(m_cancel))
            {
               m_art.addChild(m_cancel);
            }
            if(!m_art.contains(m_cancel_txt))
            {
               m_art.addChild(m_cancel_txt);
            }
         }
         else
         {
            if(m_art.contains(m_cancel))
            {
               m_art.removeChild(m_cancel);
            }
            if(m_art.contains(m_cancel_txt))
            {
               m_art.removeChild(m_cancel_txt);
            }
            if(!m_art.contains(m_ok))
            {
               m_art.addChild(m_ok);
            }
            if(!m_art.contains(m_ok_txt))
            {
               m_art.addChild(m_ok_txt);
            }
         }
      }
      
      private static function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
