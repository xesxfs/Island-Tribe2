package menu
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import logic.GameLevel;
   import logic.resources.ResType;
   
   public class GameScreen extends Sprite
   {
      
      private static var m_this:GameScreen = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_art:MovieClip = null;
      
      private static var m_menu:SimpleButton = null;
      
      private static var m_getit:SimpleButton = null;
      
      private static var m_name:MyTextField = null;
      
      private static var m_task_1:MyTextField = null;
      
      private static var m_task_2:MyTextField = null;
      
      private static var m_task_1_r:MovieClip = null;
      
      private static var m_task_2_r:MovieClip = null;
      
      private static var m_task_1_g:MovieClip = null;
      
      private static var m_task_2_g:MovieClip = null;
      
      private static var m_respanel:GameScreen_ResPanel = null;
      
      private static var m_timebar:Sprite = null;
       
      
      public function GameScreen()
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
         new GameScreen();
         m_layer = param1;
         var _loc2_:GameLevel = GameLevel.init();
         m_this.addChild(_loc2_);
         m_timebar = new Sprite();
         m_this.addChild(m_timebar);
         m_art = new ideGameScreen();
         m_this.addChild(m_art);
         m_art.mouseEnabled = false;
         m_respanel = new GameScreen_ResPanel();
         m_art.addChild(m_respanel);
         m_art.addChild(XMLTextFields.create("GAMESCREEN_MENU"));
         m_art.addChild(XMLTextFields.create("GAMESCREEN_GETIT"));
         m_art.addChild(XMLTextFields.create("GAMESCREEN_DIAMONDS"));
         m_art.addChild(XMLTextFields.create("GAMESCFEEN_TASK_1"));
         m_art.addChild(XMLTextFields.create("GAMESCFEEN_TASK_2"));
         m_art.addChild(XMLTextFields.create("GAMESCFEEN_LEVELNUM"));
         (m_art.getChildByName("txt_menu") as MyTextField).text = XMLTranslation.s("GAMESCREEN_MENU");
         (m_art.getChildByName("txt_getit") as MyTextField).text = XMLTranslation.s("GAMESCREEN_GETIT");
         m_menu = m_art.getChildByName("btn_menu") as SimpleButton;
         m_getit = m_art.getChildByName("btn_getit") as SimpleButton;
         m_name = m_art.getChildByName("txt_levelnum") as MyTextField;
         m_task_1 = m_art.getChildByName("txt_task_1") as MyTextField;
         m_task_2 = m_art.getChildByName("txt_task_2") as MyTextField;
         m_task_1_r = m_art.getChildByName("task_1_red") as MovieClip;
         m_task_2_r = m_art.getChildByName("task_2_red") as MovieClip;
         m_task_1_g = m_art.getChildByName("task_1_green") as MovieClip;
         m_task_2_g = m_art.getChildByName("task_2_green") as MovieClip;
      }
      
      public static function show() : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         SndMgr.PlaySound("start_level");
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
      
      private static function on_added(param1:Event) : void
      {
         m_menu.addEventListener(MouseEvent.CLICK,on_menu);
         m_getit.addEventListener(MouseEvent.CLICK,on_getit);
         m_menu.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_getit.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
      }
      
      private static function on_removed(param1:Event) : void
      {
         m_menu.removeEventListener(MouseEvent.CLICK,on_menu);
         m_getit.removeEventListener(MouseEvent.CLICK,on_getit);
         m_menu.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_getit.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
      }
      
      private static function on_menu(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         GameLevel.pause();
         GameMenu.show();
      }
      
      private static function on_getit(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         GameLevel.pause();
         GameMenu.show();
         navigateToURL(new URLRequest(XMLUrl.get_url()));
      }
      
      public static function update_name(param1:String) : void
      {
         m_name.text = param1;
      }
      
      public static function update_task_1_text(param1:String) : void
      {
         m_task_1.text = param1;
         if(param1.length == 0)
         {
            if(m_art.contains(m_task_1_r))
            {
               m_art.removeChild(m_task_1_r);
            }
            if(m_art.contains(m_task_1_g))
            {
               m_art.removeChild(m_task_1_g);
            }
         }
      }
      
      public static function update_task_2_text(param1:String) : void
      {
         m_task_2.text = param1;
         if(param1.length == 0)
         {
            if(m_art.contains(m_task_2_r))
            {
               m_art.removeChild(m_task_2_r);
            }
            if(m_art.contains(m_task_2_g))
            {
               m_art.removeChild(m_task_2_g);
            }
         }
      }
      
      public static function update_task_1_status(param1:Boolean) : void
      {
         if(param1)
         {
            m_task_1.transform.colorTransform = new ColorTransform(0,1,0);
            if(!m_art.contains(m_task_1_g))
            {
               m_art.addChild(m_task_1_g);
            }
            if(m_art.contains(m_task_1_r))
            {
               m_art.removeChild(m_task_1_r);
            }
         }
         else
         {
            m_task_1.transform.colorTransform = new ColorTransform(1,1,1);
            if(!m_art.contains(m_task_1_r))
            {
               m_art.addChild(m_task_1_r);
            }
            if(m_art.contains(m_task_1_g))
            {
               m_art.removeChild(m_task_1_g);
            }
         }
      }
      
      public static function update_task_2_status(param1:Boolean) : void
      {
         if(param1)
         {
            m_task_2.transform.colorTransform = new ColorTransform(0,1,0);
            if(!m_art.contains(m_task_2_g))
            {
               m_art.addChild(m_task_2_g);
            }
            if(m_art.contains(m_task_2_r))
            {
               m_art.removeChild(m_task_2_r);
            }
         }
         else
         {
            m_task_2.transform.colorTransform = new ColorTransform(1,1,1);
            if(!m_art.contains(m_task_2_r))
            {
               m_art.addChild(m_task_2_r);
            }
            if(m_art.contains(m_task_2_g))
            {
               m_art.removeChild(m_task_2_g);
            }
         }
      }
      
      public static function update_resources(param1:Array) : void
      {
         m_respanel.update(param1);
         (m_art.getChildByName("txt_diamonds") as MyTextField).text = param1[ResType.DIAMONDS].toString();
      }
      
      public static function update_timebar(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         m_timebar.x = 155;
         m_timebar.y = 0;
         m_timebar.graphics.clear();
         m_timebar.graphics.beginFill(12472369,1);
         m_timebar.graphics.drawRect(0,0,85,20);
         if(param1 < 0.67)
         {
            m_timebar.graphics.beginFill(5091840,1);
         }
         else
         {
            m_timebar.graphics.beginFill(15385347,1);
         }
         m_timebar.graphics.drawRect(0,0,m_timebar.width * (1 - param1),20);
      }
      
      private static function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
