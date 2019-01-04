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
   import logic.GameLevel;
   
   public class GameMenu extends Sprite
   {
      
      private static var m_this:GameMenu = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_resume:SimpleButton = null;
      
      private static var m_options:SimpleButton = null;
      
      private static var m_restart:SimpleButton = null;
      
      private static var m_getit:SimpleButton = null;
      
      private static var m_abort:SimpleButton = null;
      
      private static var m_art:MovieClip = null;
      
      private static var m_fill:Sprite = null;
       
      
      public function GameMenu()
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
         new GameMenu();
         m_layer = param1;
         m_fill = new Sprite();
         m_this.addChild(m_fill);
         m_fill.graphics.beginFill(0,0.5);
         m_fill.graphics.drawRect(0,0,640,480);
         m_fill.graphics.endFill();
         m_art = new ideGameMenu();
         m_this.addChild(m_art);
         m_resume = m_art.getChildByName("btn_resume") as SimpleButton;
         m_options = m_art.getChildByName("btn_options") as SimpleButton;
         m_restart = m_art.getChildByName("btn_restart") as SimpleButton;
         m_getit = m_art.getChildByName("btn_getit") as SimpleButton;
         m_abort = m_art.getChildByName("btn_abort") as SimpleButton;
         m_art.addChild(XMLTextFields.create("GAME_MENU_RESUME"));
         m_art.addChild(XMLTextFields.create("GAME_MENU_OPTIONS"));
         m_art.addChild(XMLTextFields.create("GAME_MENU_RESTART"));
         m_art.addChild(XMLTextFields.create("GAME_MENU_GETIT"));
         m_art.addChild(XMLTextFields.create("GAME_MENU_ABORT"));
         (m_art.getChildByName("txt_resume") as MyTextField).text = XMLTranslation.s("MENU_GAME_RESUME");
         (m_art.getChildByName("txt_options") as MyTextField).text = XMLTranslation.s("MENU_GAME_OPTIONS");
         (m_art.getChildByName("txt_restart") as MyTextField).text = XMLTranslation.s("MENU_GAME_RESTART");
         (m_art.getChildByName("txt_getit") as MyTextField).text = XMLTranslation.s("MENU_GAME_GETIT");
         (m_art.getChildByName("txt_abort") as MyTextField).text = XMLTranslation.s("MENU_GAME_ABORT");
      }
      
      public static function show() : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_art.x = 320;
         TweenLite.to(m_art,1,{"x":0});
         m_fill.alpha = 0;
         TweenLite.to(m_fill,1,{"alpha":1});
      }
      
      public static function move_out() : void
      {
         m_art.x = 0;
         TweenLite.to(m_art,1,{"x":320});
         m_fill.alpha = 1;
         TweenLite.to(m_fill,1,{"alpha":0});
         TweenLite.delayedCall(1.01,hide);
      }
      
      public static function hide() : void
      {
         if(m_layer != null && m_layer.contains(m_this))
         {
            m_layer.removeChild(m_this);
         }
      }
      
      public static function is_visible() : Boolean
      {
         return m_layer.contains(m_this);
      }
      
      private static function on_resume(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         move_out();
         GameLevel.unpause();
      }
      
      private static function on_options(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         OptionsMenu.show();
      }
      
      private static function on_restart(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         ConfirmationDlg.show(XMLTranslation.s("MENU_DLG_RESTART"),restart_level);
      }
      
      private static function on_getit(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         navigateToURL(new URLRequest(XMLUrl.get_url()));
      }
      
      private static function on_abort(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         ConfirmationDlg.show(XMLTranslation.s("MENU_DLG_ABORT"),exit_to_map);
      }
      
      private static function restart_level() : void
      {
         move_out();
         hide();
         GameScreen.hide();
         LevelLoading.show(GameLevel.current_level_num() - 1);
      }
      
      private static function exit_to_map() : void
      {
         GameMenu.hide();
         GameScreen.hide();
         LevelFinishing.hide();
         WorldMap.show();
      }
      
      private function on_added(param1:Event) : void
      {
         m_resume.addEventListener(MouseEvent.CLICK,on_resume);
         m_options.addEventListener(MouseEvent.CLICK,on_options);
         m_restart.addEventListener(MouseEvent.CLICK,on_restart);
         m_getit.addEventListener(MouseEvent.CLICK,on_getit);
         m_abort.addEventListener(MouseEvent.CLICK,on_abort);
         m_resume.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_options.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_restart.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_getit.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_abort.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_removed(param1:Event) : void
      {
         m_resume.removeEventListener(MouseEvent.CLICK,on_resume);
         m_options.removeEventListener(MouseEvent.CLICK,on_options);
         m_restart.removeEventListener(MouseEvent.CLICK,on_restart);
         m_getit.removeEventListener(MouseEvent.CLICK,on_getit);
         m_abort.removeEventListener(MouseEvent.CLICK,on_abort);
         m_resume.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_options.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_restart.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_getit.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_abort.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
