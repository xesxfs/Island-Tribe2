package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import logic.GameLevel;
   
   public class LevelLoading extends Sprite
   {
      
      private static var m_this:LevelLoading = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_art:MovieClip = null;
      
      private static var m_fill:Sprite = null;
      
      private static var m_name:MyTextField = null;
      
      private static var m_bar:MovieClip = null;
      
      private static var m_hint:MyTextField = null;
      
      private static var m_mark_1:MovieClip = null;
      
      private static var m_mark_2:MovieClip = null;
      
      private static var m_task_1:MyTextField = null;
      
      private static var m_task_2:MyTextField = null;
      
      private static var m_pressanykey:MyTextField = null;
      
      private static var m_progress:int = 0;
      
      private static var m_bar_mask:Sprite = null;
      
      private static var m_level_num:int = -1;
       
      
      public function LevelLoading()
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
         new LevelLoading();
         m_layer = param1;
         m_art = new ideLevelLoading();
         m_this.addChild(m_art);
         m_art.addChild(XMLTextFields.create("LOADING_MENU_LEVEL"));
         m_art.addChild(XMLTextFields.create("LOADING_MENU_TASK_1"));
         m_art.addChild(XMLTextFields.create("LOADING_MENU_TASK_2"));
         m_art.addChild(XMLTextFields.create("LOADING_MENU_HINT"));
         m_art.addChild(XMLTextFields.create("LOADING_MENU_CLICK"));
         m_name = m_art.getChildByName("txt_name") as MyTextField;
         m_mark_1 = m_art.getChildByName("mark_1") as MovieClip;
         m_mark_2 = m_art.getChildByName("mark_2") as MovieClip;
         m_task_1 = m_art.getChildByName("txt_task_1") as MyTextField;
         m_task_2 = m_art.getChildByName("txt_task_2") as MyTextField;
         m_hint = m_art.getChildByName("txt_hint") as MyTextField;
         m_bar = m_art.getChildByName("loading_bar") as MovieClip;
         m_pressanykey = m_art.getChildByName("txt_pressanykey") as MyTextField;
         m_pressanykey.text = XMLTranslation.s("MENU_LOADING_PRESSANYKEY");
         m_art.removeChild(m_pressanykey);
         m_fill = new Sprite();
         m_this.addChild(m_fill);
         m_fill.graphics.beginFill(0,1);
         m_fill.graphics.drawRect(0,0,640,480);
         m_fill.graphics.endFill();
         m_bar_mask = new Sprite();
         m_bar.mask = m_bar_mask;
         m_bar.addChild(m_bar_mask);
         update_bar();
      }
      
      public static function show(param1:int) : void
      {
         var level_index:int = param1;
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         if(m_art.contains(m_pressanykey))
         {
            m_art.removeChild(m_pressanykey);
         }
         m_level_num = level_index + 1;
         m_progress = 0;
         switch(level_index + 1)
         {
            case 1:
               m_name.text = XMLTranslation.s("LEVEL_1_NAME");
               m_task_1.text = XMLTranslation.s("LEVEL_1_TASK_1_1");
               m_task_2.text = XMLTranslation.s("LEVEL_1_TASK_2");
               m_hint.text = XMLTranslation.s("LEVEL_1_HINT");
               break;
            case 2:
               m_name.text = XMLTranslation.s("LEVEL_2_NAME");
               m_task_1.text = XMLTranslation.s("LEVEL_2_TASK_1_1");
               m_task_2.text = XMLTranslation.s("LEVEL_2_TASK_2");
               m_hint.text = XMLTranslation.s("LEVEL_2_HINT");
               break;
            case 3:
               m_name.text = XMLTranslation.s("LEVEL_3_NAME");
               m_task_1.text = XMLTranslation.s("LEVEL_3_TASK_1_1");
               m_task_2.text = XMLTranslation.s("LEVEL_3_TASK_2");
               m_hint.text = XMLTranslation.s("LEVEL_3_HINT");
               break;
            case 4:
               m_name.text = XMLTranslation.s("LEVEL_4_NAME");
               m_task_1.text = XMLTranslation.s("LEVEL_4_TASK_1_1");
               m_task_2.text = XMLTranslation.s("LEVEL_4_TASK_2_4");
               m_hint.text = XMLTranslation.s("LEVEL_4_HINT");
               break;
            case 5:
               m_name.text = XMLTranslation.s("LEVEL_5_NAME");
               m_task_1.text = XMLTranslation.s("LEVEL_5_TASK_1_1");
               m_task_2.text = XMLTranslation.s("LEVEL_5_TASK_2");
               m_hint.text = XMLTranslation.s("LEVEL_5_HINT");
               break;
            case 6:
               m_name.text = XMLTranslation.s("LEVEL_6_NAME");
               m_task_1.text = XMLTranslation.s("LEVEL_6_TASK_1_1");
               m_task_2.text = XMLTranslation.s("LEVEL_6_TASK_2");
               m_hint.text = XMLTranslation.s("LEVEL_6_HINT");
         }
         if(m_task_2.text == "")
         {
            if(m_art.contains(m_task_2))
            {
               m_art.removeChild(m_task_2);
            }
            if(m_art.contains(m_mark_2))
            {
               m_art.removeChild(m_mark_2);
            }
         }
         else
         {
            if(!m_art.contains(m_task_2))
            {
               m_art.addChild(m_task_2);
            }
            if(!m_art.contains(m_mark_2))
            {
               m_art.addChild(m_mark_2);
            }
         }
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
      
      public static function hide() : void
      {
         if(m_layer != null && m_layer.contains(m_this))
         {
            m_layer.removeChild(m_this);
         }
      }
      
      private static function on_click(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(m_progress >= 100)
         {
            show_fill(function f():void
            {
               LevelLoading.hide();
               GameScreen.show();
            });
         }
      }
      
      private static function on_enter_frame(param1:Event) : void
      {
         if(m_progress >= 100)
         {
            return;
         }
         m_progress = m_progress + 1;
         if(m_progress == 20)
         {
            GameLevel.load_step_1(m_level_num);
         }
         else if(m_progress == 30)
         {
            GameLevel.load_step_2();
         }
         if(m_progress == 100)
         {
            GameLevel.loading_complete();
         }
         update_bar();
         if(m_progress >= 100)
         {
            m_art.addChild(m_pressanykey);
         }
      }
      
      private static function update_bar() : void
      {
         m_bar_mask.graphics.clear();
         m_bar_mask.graphics.beginFill(16777215,1);
         m_bar_mask.graphics.drawRect(0,0,m_bar.width * (m_progress * 0.01),m_bar.height);
         m_bar_mask.graphics.endFill();
      }
      
      private function on_added(param1:Event) : void
      {
         m_this.addEventListener(MouseEvent.CLICK,on_click);
         m_this.addEventListener(Event.ENTER_FRAME,on_enter_frame);
      }
      
      private function on_removed(param1:Event) : void
      {
         m_this.removeEventListener(MouseEvent.CLICK,on_click);
         m_this.removeEventListener(Event.ENTER_FRAME,on_enter_frame);
      }
   }
}
