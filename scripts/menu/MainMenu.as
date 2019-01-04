package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class MainMenu extends Sprite
   {
      
      private static var m_this:MainMenu = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_start:SimpleButton = null;
      
      private static var m_options:SimpleButton = null;
      
      private static var m_getit:SimpleButton = null;
      
      private static var m_scores:SimpleButton = null;
      
      private static var m_players:SimpleButton = null;
      
      private static var m_username:MyTextField = null;
      
      private static var m_fill:Sprite = null;
       
      
      public function MainMenu()
      {
         super();
         if(m_this != null)
         {
         }
         m_this = this;
         this.addEventListener(Event.ADDED_TO_STAGE,this.on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.on_removed);
      }
      
      public static function init(param1:Sprite) : void
      {
         new MainMenu();
         m_layer = param1;
         var _loc2_:MovieClip = new ideMainMenu();
         m_this.addChild(_loc2_);
         _loc2_.addChild(XMLTextFields.create("MAIN_MENU_START"));
         _loc2_.addChild(XMLTextFields.create("MAIN_MENU_OPTIONS"));
         _loc2_.addChild(XMLTextFields.create("MAIN_MENU_GETIT"));
         _loc2_.addChild(XMLTextFields.create("MAIN_MENU_SCORES"));
         _loc2_.addChild(XMLTextFields.create("MAIN_MENU_USERNAME"));
         _loc2_.addChild(XMLTextFields.create("MAIN_MENU_CHANGE"));
         m_start = _loc2_.getChildByName("btn_start") as SimpleButton;
         m_options = _loc2_.getChildByName("btn_options") as SimpleButton;
         m_getit = _loc2_.getChildByName("btn_getit") as SimpleButton;
         m_scores = _loc2_.getChildByName("btn_scores") as SimpleButton;
         m_players = _loc2_.getChildByName("btn_players") as SimpleButton;
         m_username = _loc2_.getChildByName("txt_username") as MyTextField;
         (_loc2_.getChildByName("txt_start") as MyTextField).text = XMLTranslation.s("MENU_MAIN_START");
         (_loc2_.getChildByName("txt_options") as MyTextField).text = XMLTranslation.s("MENU_MAIN_OPTIONS");
         (_loc2_.getChildByName("txt_getit") as MyTextField).text = XMLTranslation.s("MENU_MAIN_GET_IT");
         (_loc2_.getChildByName("txt_scores") as MyTextField).text = XMLTranslation.s("MENU_MAIN_SCORES");
         (_loc2_.getChildByName("txt_click_here_to_change") as MyTextField).text = XMLTranslation.s("MENU_MAIN_CLICK_HERE");
         m_fill = new Sprite();
         m_this.addChild(m_fill);
         m_fill.graphics.beginFill(0,1);
         m_fill.graphics.drawRect(0,0,640,480);
         m_fill.graphics.endFill();
      }
      
      private static function remove_fill() : void
      {
         if(m_this.contains(m_fill))
         {
            m_this.removeChild(m_fill);
         }
      }
      
      private static function show_fill(param1:Function) : void
      {
         if(!m_this.contains(m_fill))
         {
            m_this.addChild(m_fill);
         }
         m_fill.alpha = 0;
         TweenLite.to(m_fill,0.5,{"alpha":1});
         TweenLite.delayedCall(0.51,param1);
      }
      
      public static function show() : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         update_player_welcome();
         if(!m_this.contains(m_fill))
         {
            m_this.addChild(m_fill);
         }
         m_fill.alpha = 1;
         TweenLite.to(m_fill,0.5,{"alpha":0});
         TweenLite.delayedCall(0.51,function f():void
         {
            remove_fill();
         });
      }
      
      public static function update_player_welcome() : void
      {
         if(Save.num_users())
         {
            m_username.text = XMLTranslation.s("MENU_MAIN_HELLO_A") + Save.current_user_name() + XMLTranslation.s("MENU_MAIN_HELLO_B");
         }
         else
         {
            PlayerCreateMenu.show();
         }
      }
      
      public static function hide() : void
      {
         if(m_layer != null && m_layer.contains(m_this))
         {
            m_layer.removeChild(m_this);
         }
      }
      
      private function on_added(param1:Event) : void
      {
         m_start.addEventListener(MouseEvent.CLICK,this.on_start);
         m_options.addEventListener(MouseEvent.CLICK,this.on_options);
         m_scores.addEventListener(MouseEvent.CLICK,this.on_scores);
         m_players.addEventListener(MouseEvent.CLICK,this.on_players);
         m_getit.addEventListener(MouseEvent.CLICK,this.on_getit);
         m_start.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_options.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_scores.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_players.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_getit.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_removed(param1:Event) : void
      {
         m_start.removeEventListener(MouseEvent.CLICK,this.on_start);
         m_options.removeEventListener(MouseEvent.CLICK,this.on_options);
         m_scores.removeEventListener(MouseEvent.CLICK,this.on_scores);
         m_players.removeEventListener(MouseEvent.CLICK,this.on_players);
         m_getit.removeEventListener(MouseEvent.CLICK,this.on_getit);
         m_start.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_options.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_scores.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_players.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_getit.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_start(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SndMgr.PlaySound("btn_click");
         show_fill(function f():void
         {
            WorldMap.show();
            MainMenu.hide();
         });
      }
      
      private function on_options(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         OptionsMenu.show();
      }
      
      private function on_players(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         PlayersMenu.show();
      }
      
      private function on_scores(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         ScoresMenu.show();
      }
      
      private function on_getit(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         navigateToURL(new URLRequest(XMLUrl.get_url()));
      }
      
      private function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
