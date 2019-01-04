package menu
{
   import com.greensock.TweenLite;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import mochi.as3.MochiAd;
   
   public class LevelFinishing extends Sprite
   {
      
      private static var m_this:LevelFinishing = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_art:MovieClip = null;
      
      private static var m_stamp:MovieClip = null;
      
      private static var m_welldone:Bitmap = null;
      
      private static var m_great:Bitmap = null;
      
      private static var m_level_num:int = 0;
      
      private static var m_levelnum:MyTextField = null;
      
      private static var m_levelname:MyTextField = null;
      
      private static var m_username:MyTextField = null;
      
      private static var m_tasks_bonus:MyTextField = null;
      
      private static var m_res_bonus:MyTextField = null;
      
      private static var m_gem_bonus:MyTextField = null;
      
      private static var m_time_bonus:MyTextField = null;
      
      private static var m_total_scores:MyTextField = null;
      
      private static var m_art_count:MyTextField = null;
      
      private static var m_ok:MyTextField = null;
      
      private static var m_restart:MyTextField = null;
      
      private static var m_getit:MyTextField = null;
      
      private static var m_getitmsg:Bitmap = null;
      
      private static var m_resicons:Sprite = null;
      
      private static var m_artefact:Bitmap = null;
      
      private static var m_btn_L:SimpleButton = null;
      
      private static var m_btn_R:SimpleButton = null;
       
      
      public function LevelFinishing()
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
         new LevelFinishing();
         m_layer = param1;
         m_art = new ideLevelFinishing();
         m_this.addChild(m_art);
         var _loc2_:Class = LevelFinishing_pic_back;
         var _loc3_:Bitmap = new _loc2_();
         _loc3_.x = 137;
         _loc3_.y = 54;
         m_art.addChildAt(_loc3_,1);
         m_art.addChild(XMLTextFields.create("LEVEL_END_NUM"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_NAME"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_USER"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_OK"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_RESTART"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_GETIT"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_TASKS"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_TIME"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_SCORE"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_ARTNUM"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_TASKS_CUR"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_RES_CUR"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_GEM_CUR"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_TIME_CUR"));
         m_art.addChild(XMLTextFields.create("LEVEL_END_TOTAL_CUR"));
         m_btn_L = m_art.getChildByName("btn_left") as SimpleButton;
         m_btn_R = m_art.getChildByName("btn_right") as SimpleButton;
         m_levelnum = m_art.getChildByName("txt_level_num") as MyTextField;
         m_levelname = m_art.getChildByName("txt_level_name") as MyTextField;
         m_username = m_art.getChildByName("txt_user_name") as MyTextField;
         m_ok = m_art.getChildByName("txt_ok") as MyTextField;
         m_restart = m_art.getChildByName("txt_restart") as MyTextField;
         m_getit = m_art.getChildByName("txt_getit") as MyTextField;
         m_ok.text = XMLTranslation.s("MENU_LEVEL_FINISHING_OK");
         m_restart.text = XMLTranslation.s("MENU_LEVEL_FINISHING_RESTART");
         m_getit.text = XMLTranslation.s("MENU_LEVEL_FINISHING_GET_IT");
         (m_art.getChildByName("t_tasks_bonus") as MyTextField).text = XMLTranslation.s("MENU_LEVEL_FINISHING_TASKS_BONUS");
         (m_art.getChildByName("t_time_bonus") as MyTextField).text = XMLTranslation.s("MENU_LEVEL_FINISHING_TIME_BONUS");
         (m_art.getChildByName("t_total_score") as MyTextField).text = XMLTranslation.s("MENU_LEVEL_FINISHING_TOTAL_SCORE");
         m_tasks_bonus = m_art.getChildByName("txt_tasks_bonus") as MyTextField;
         m_res_bonus = m_art.getChildByName("txt_res_bonus") as MyTextField;
         m_gem_bonus = m_art.getChildByName("txt_gem_bonus") as MyTextField;
         m_time_bonus = m_art.getChildByName("txt_time_bonus") as MyTextField;
         m_total_scores = m_art.getChildByName("txt_total_scores") as MyTextField;
         m_art_count = m_art.getChildByName("txt_art_count") as MyTextField;
         var _loc4_:Class = LevelFinishing_pic_ad;
         m_getitmsg = new _loc4_();
         m_getitmsg.x = 173;
         m_getitmsg.y = 134;
         m_stamp = m_art.getChildByName("stamp") as MovieClip;
         var _loc5_:Class = LevelFinishing_pic_welldone;
         m_welldone = new _loc5_();
         m_welldone.x = 404 - m_welldone.width / 2;
         m_welldone.y = 364 - m_welldone.height / 2;
         m_art.addChild(m_welldone);
         var _loc6_:Class = LevelFinishing_pic_great;
         m_great = new _loc6_();
         m_great.x = 402 - m_great.width / 2;
         m_great.y = 364 - m_great.height / 2;
         m_art.addChild(m_great);
         m_art.removeChild(m_stamp);
         m_art.removeChild(m_welldone);
         m_art.removeChild(m_great);
         m_resicons = new Sprite();
         m_resicons.x = 190;
         m_resicons.y = 160;
         m_art.addChild(m_resicons);
      }
      
      public static function show(param1:int, param2:int = 100, param3:int = 0, param4:Array = null, param5:int = 0, param6:int = 0, param7:int = 0, param8:int = 0, param9:Number = 0, param10:Boolean = false, param11:Boolean = false) : void
      {
         var icon:Bitmap = null;
         var level_num:int = param1;
         var tasks_bonus:int = param2;
         var res_bonus:int = param3;
         var res_icons:Array = param4;
         var gem_bonus:int = param5;
         var time_bonus:int = param6;
         var total_scores:int = param7;
         var art_count:int = param8;
         var level_time:Number = param9;
         var is_welldone:Boolean = param10;
         var is_great:Boolean = param11;
         hide();
         SndMgr.PlayMusic("win_music",true);
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_username.text = Save.current_user_name();
         m_tasks_bonus.text = tasks_bonus.toString();
         m_res_bonus.text = res_bonus.toString();
         m_gem_bonus.text = gem_bonus.toString();
         m_time_bonus.text = time_bonus.toString();
         m_total_scores.text = total_scores.toString();
         if(art_count > 0)
         {
            m_art_count.text = art_count.toString() + "/1";
         }
         else
         {
            m_art_count.text = "";
         }
         m_level_num = level_num;
         switch(level_num)
         {
            case 1:
               m_levelnum.text = XMLTranslation.s("LEVEL_1_NUM");
               m_levelname.text = XMLTranslation.s("LEVEL_1_NAME");
               break;
            case 2:
               m_levelnum.text = XMLTranslation.s("LEVEL_2_NUM");
               m_levelname.text = XMLTranslation.s("LEVEL_2_NAME");
               break;
            case 3:
               m_levelnum.text = XMLTranslation.s("LEVEL_3_NUM");
               m_levelname.text = XMLTranslation.s("LEVEL_3_NAME");
               break;
            case 4:
               m_levelnum.text = XMLTranslation.s("LEVEL_4_NUM");
               m_levelname.text = XMLTranslation.s("LEVEL_4_NAME");
               break;
            case 5:
               m_levelnum.text = XMLTranslation.s("LEVEL_5_NUM");
               m_levelname.text = XMLTranslation.s("LEVEL_5_NAME");
               break;
            case 6:
               m_levelnum.text = XMLTranslation.s("LEVEL_6_NUM");
               m_levelname.text = XMLTranslation.s("LEVEL_6_NAME");
         }
         if(is_welldone)
         {
            if(!m_art.contains(m_stamp))
            {
               m_art.addChild(m_stamp);
            }
            if(!m_art.contains(m_welldone))
            {
               m_art.addChild(m_welldone);
            }
            m_welldone.scaleX = 4;
            m_welldone.scaleY = 4;
            m_welldone.alpha = 0;
            TweenLite.to(m_welldone,0.5,{
               "delay":1,
               "scaleX":1,
               "scaleY":1,
               "alpha":1
            });
            m_stamp.alpha = 0;
            TweenLite.to(m_stamp,0.07,{
               "delay":1.4,
               "alpha":1
            });
            TweenLite.delayedCall(1.45,function f():void
            {
               SndMgr.PlaySound("stamp");
            });
         }
         else if(m_art.contains(m_welldone))
         {
            m_art.removeChild(m_welldone);
         }
         if(is_great)
         {
            if(!m_art.contains(m_stamp))
            {
               m_art.addChild(m_stamp);
            }
            if(!m_art.contains(m_great))
            {
               m_art.addChild(m_great);
            }
            m_great.scaleX = 4;
            m_great.scaleY = 4;
            m_great.alpha = 0;
            TweenLite.to(m_great,0.5,{
               "delay":1,
               "scaleX":1,
               "scaleY":1,
               "alpha":1
            });
            m_stamp.alpha = 0;
            TweenLite.to(m_stamp,0.07,{
               "delay":1.4,
               "alpha":1
            });
            TweenLite.delayedCall(1.45,function f():void
            {
               SndMgr.PlaySound("stamp");
            });
         }
         else if(m_art.contains(m_great))
         {
            m_art.removeChild(m_great);
         }
         if(!(is_great || is_welldone))
         {
            if(m_art.contains(m_stamp))
            {
               m_art.removeChild(m_stamp);
            }
         }
         while(m_resicons.numChildren)
         {
            m_resicons.removeChildAt(0);
         }
         var cur_w:int = 0;
         for each(icon in res_icons)
         {
            icon.x = cur_w;
            cur_w = cur_w + 18;
            m_resicons.addChild(icon);
         }
         if(m_artefact)
         {
            m_art.removeChild(m_artefact);
         }
         if(art_count)
         {
            switch(level_num)
            {
               case 1:
                  m_artefact = new Bitmap(new art_artefact_1());
                  break;
               case 2:
                  m_artefact = new Bitmap(new art_artefact_2());
                  break;
               case 3:
                  m_artefact = new Bitmap(new art_artefact_3());
                  break;
               case 4:
                  m_artefact = new Bitmap(new art_artefact_4());
                  break;
               case 5:
                  m_artefact = new Bitmap(new art_artefact_5());
                  break;
               case 6:
                  m_artefact = new Bitmap(new art_artefact_6());
            }
            m_artefact.x = 300;
            m_artefact.y = 278;
            m_art.addChild(m_artefact);
         }
         if(level_num < 6)
         {
            if(m_art.contains(m_getitmsg))
            {
               m_art.removeChild(m_getitmsg);
            }
            if(m_art.contains(m_getit))
            {
               m_art.removeChild(m_getit);
            }
            if(!m_art.contains(m_ok))
            {
               m_art.addChild(m_ok);
            }
         }
         else
         {
            if(m_art.contains(m_ok))
            {
               m_art.removeChild(m_ok);
            }
            if(!m_art.contains(m_getit))
            {
               m_art.addChild(m_getit);
            }
            if(m_art.contains(m_getitmsg))
            {
               m_art.removeChild(m_getitmsg);
            }
            if(!m_art.contains(m_getitmsg))
            {
               m_art.addChild(m_getitmsg);
            }
            m_getitmsg.alpha = 0;
            TweenLite.to(m_getitmsg,1,{
               "delay":3,
               "alpha":1
            });
         }
         Save.level_set_scores(level_num - 1,tasks_bonus + res_bonus + time_bonus + gem_bonus);
         Save.level_set_time(level_num - 1,level_time);
         Save.level_set_artifacts_collected(level_num - 1,art_count);
         if(is_great)
         {
            Save.extra_win_level(level_num - 1);
         }
         else
         {
            Save.win_level(level_num - 1);
         }
         if(level_num <= 5)
         {
            Save.unlock_level(level_num + 1 - 1);
         }
         m_this.alpha = 0;
         TweenLite.to(m_this,1,{"alpha":1});
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
      
      private function on_added(param1:Event) : void
      {
         m_btn_L.addEventListener(MouseEvent.CLICK,this.on_left);
         m_btn_R.addEventListener(MouseEvent.CLICK,this.on_right);
         m_btn_L.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_btn_R.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_removed(param1:Event) : void
      {
         m_btn_L.removeEventListener(MouseEvent.CLICK,this.on_left);
         m_btn_R.removeEventListener(MouseEvent.CLICK,this.on_right);
         m_btn_L.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
         m_btn_R.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_left(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         SndMgr.PlaySound("btn_click");
         SndMgr.Stop("win_music");
         SndMgr.PlayMusic("main_music",true);
         if(m_art.contains(m_ok))
         {
            m_this.mouseChildren = false;
            _loc2_ = new MovieClip();
            this.stage.addChild(_loc2_);
            MochiAd.showInterLevelAd({
               "clip":_loc2_,
               "id":Preloader.gameid,
               "res":640 + "x" + 480,
               "ad_finished":this.on_continuegame
            });
         }
         if(m_art.contains(m_getit))
         {
            navigateToURL(new URLRequest(XMLUrl.get_url()));
            hide();
            GameScreen.hide();
            LevelFinishing.hide();
            GameMenu.hide();
            WorldMap.show();
         }
      }
      
      private function on_continuegame() : void
      {
         m_this.mouseChildren = true;
         hide();
         GameScreen.hide();
         LevelLoading.show(m_level_num - 1 + 1);
      }
      
      private function on_right(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         SndMgr.Stop("win_music");
         SndMgr.PlayMusic("main_music",true);
         if(m_art.contains(m_restart))
         {
            hide();
            GameScreen.hide();
            LevelLoading.show(m_level_num - 1);
         }
      }
      
      private function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
