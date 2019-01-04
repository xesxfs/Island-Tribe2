package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PlayersMenu extends Sprite
   {
      
      private static var m_this:PlayersMenu = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_new:SimpleButton = null;
      
      private static var m_select:SimpleButton = null;
      
      private static var m_delete:SimpleButton = null;
      
      private static var m_cancel:SimpleButton = null;
      
      private static var m_users:Sprite = null;
      
      private static var m_curind:int = 0;
       
      
      public function PlayersMenu()
      {
         super();
         if(m_this != null)
         {
         }
         m_this = this;
         m_users = new Sprite();
         this.addEventListener(Event.ADDED_TO_STAGE,this.on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.on_removed);
      }
      
      public static function init(param1:Sprite) : void
      {
         new PlayersMenu();
         m_layer = param1;
         m_users = new Sprite();
         m_this.addChild(m_users);
         var _loc2_:MovieClip = new idePlayersMenu();
         m_this.addChild(_loc2_);
         m_new = _loc2_.getChildByName("btn_new") as SimpleButton;
         m_select = _loc2_.getChildByName("btn_select") as SimpleButton;
         m_delete = _loc2_.getChildByName("btn_delete") as SimpleButton;
         m_cancel = _loc2_.getChildByName("btn_cancel") as SimpleButton;
         _loc2_.addChild(XMLTextFields.create("PLAYERS_MENU_TITLE"));
         _loc2_.addChild(XMLTextFields.create("PLAYERS_MENU_NEW"));
         _loc2_.addChild(XMLTextFields.create("PLAYERS_MENU_SELECT"));
         _loc2_.addChild(XMLTextFields.create("PLAYERS_MENU_DELETE"));
         _loc2_.addChild(XMLTextFields.create("PLAYERS_MENU_CANCEL"));
         (_loc2_.getChildByName("txt_title") as MyTextField).text = XMLTranslation.s("MENU_PLAYERS_TITLE");
         (_loc2_.getChildByName("txt_new") as MyTextField).text = XMLTranslation.s("MENU_PLAYERS_NEW");
         (_loc2_.getChildByName("txt_select") as MyTextField).text = XMLTranslation.s("MENU_PLAYERS_SELECT");
         (_loc2_.getChildByName("txt_delete") as MyTextField).text = XMLTranslation.s("MENU_PLAYERS_DELETE");
         (_loc2_.getChildByName("txt_cancel") as MyTextField).text = XMLTranslation.s("MENU_PLAYERS_CANCEL");
      }
      
      public static function show() : void
      {
         var _loc2_:Object = null;
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_this.alpha = 0;
         TweenLite.to(m_this,0.5,{"alpha":1});
         var _loc1_:int = 0;
         for each(_loc2_ in Save.users_list())
         {
            if(_loc2_.name == Save.current_user_name())
            {
               m_curind = _loc1_;
               break;
            }
            _loc1_++;
         }
         update_list();
      }
      
      public static function hide() : void
      {
         if(m_layer != null && m_layer.contains(m_this))
         {
            m_layer.removeChild(m_this);
         }
      }
      
      public static function update_list() : void
      {
         var _loc2_:Object = null;
         var _loc3_:idePlayersMenu_OnePlayer = null;
         var _loc4_:MyTextField = null;
         if(m_users != null)
         {
            m_this.removeChild(m_users);
            m_users = new Sprite();
            m_this.addChild(m_users);
         }
         var _loc1_:int = 0;
         for each(_loc2_ in Save.users_list())
         {
            _loc3_ = new idePlayersMenu_OnePlayer();
            _loc3_.name = _loc2_.name;
            _loc3_.useHandCursor = true;
            _loc3_.buttonMode = true;
            _loc3_.x = 363;
            _loc3_.y = 182 + _loc1_ * 34;
            m_users.addChild(_loc3_);
            _loc3_.addChild(XMLTextFields.create("PLAYERS_MENU_SINGLE"));
            _loc4_ = _loc3_.getChildByName("txt_name") as MyTextField;
            _loc4_.text = _loc2_.name;
            _loc4_.mouseChildren = false;
            if(_loc1_ == m_curind)
            {
               _loc4_.textColor = 6749952;
            }
            _loc3_.addEventListener(MouseEvent.CLICK,on_user_click,false,0,true);
            _loc1_++;
         }
      }
      
      private static function on_user_click(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = 0;
         while(_loc3_ < m_users.numChildren)
         {
            if(m_users.getChildAt(_loc3_).name == _loc2_)
            {
               m_curind = _loc3_;
               update_list();
            }
            _loc3_++;
         }
      }
      
      private static function on_select(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         var _loc2_:String = m_users.getChildAt(m_curind).name;
         Save.select_user(_loc2_);
         MainMenu.update_player_welcome();
         update_list();
         hide();
      }
      
      public static function delete_selected_user() : void
      {
         var _loc1_:String = null;
         if(Save.num_users() > 1)
         {
            _loc1_ = m_users.getChildAt(m_curind).name;
            Save.delete_user(_loc1_);
            m_curind = 0;
            on_select(null);
            MainMenu.update_player_welcome();
            update_list();
         }
      }
      
      private function on_added(param1:Event) : void
      {
         m_new.addEventListener(MouseEvent.CLICK,this.on_new);
         m_select.addEventListener(MouseEvent.CLICK,on_select);
         m_delete.addEventListener(MouseEvent.CLICK,this.on_delete);
         m_cancel.addEventListener(MouseEvent.CLICK,this.on_cancel);
         m_new.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_select.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_delete.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_cancel.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_removed(param1:Event) : void
      {
         m_new.removeEventListener(MouseEvent.CLICK,this.on_new);
         m_select.removeEventListener(MouseEvent.CLICK,on_select);
         m_delete.removeEventListener(MouseEvent.CLICK,this.on_delete);
         m_cancel.removeEventListener(MouseEvent.CLICK,this.on_cancel);
         m_new.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_select.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_delete.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_cancel.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_new(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         PlayerCreateMenu.show();
      }
      
      private function on_delete(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         if(Save.num_users() > 1)
         {
            ConfirmationDlg.show(XMLTranslation.s("MENU_DLG_PLAYER_DELETE"),delete_selected_user);
         }
         else
         {
            NotifyDlg.show(XMLTranslation.s("MENU_DLF_LAST_PLAYER"));
         }
         update_list();
      }
      
      private function on_cancel(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         PlayersMenu.hide();
      }
      
      private function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
