package menu
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class WorldMap extends Sprite
   {
      
      private static var m_this:WorldMap = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_menu:SimpleButton = null;
      
      private static var m_getit:SimpleButton = null;
      
      private static var m_play:SimpleButton = null;
      
      private static var m_level_index:int = 0;
      
      private static var m_selector:MovieClip = null;
      
      private static var m_bouys_gold:Array = null;
      
      private static var m_bouys_green:Array = null;
      
      private static var m_art:MovieClip = null;
      
      private static var m_fill:Sprite = null;
      
      private static var m_infownd:MovieClip = null;
       
      
      public function WorldMap()
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
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         new WorldMap();
         m_layer = param1;
         m_art = new ideWorldMap();
         m_this.addChild(m_art);
         m_menu = m_art.getChildByName("btn_menu") as SimpleButton;
         m_getit = m_art.getChildByName("btn_getit") as SimpleButton;
         m_play = m_art.getChildByName("btn_play") as SimpleButton;
         m_art.addChild(XMLTextFields.create("WORLD_MAP_MENU"));
         m_art.addChild(XMLTextFields.create("WORLD_MAP_GETIT"));
         m_art.addChild(XMLTextFields.create("WORLD_MAP_PLAY"));
         (m_art.getChildByName("txt_menu") as MyTextField).text = XMLTranslation.s("WORLD_MAP_MENU");
         (m_art.getChildByName("txt_getit") as MyTextField).text = XMLTranslation.s("WORLD_MAP_GETIT");
         (m_art.getChildByName("txt_play") as MyTextField).text = XMLTranslation.s("WORLD_MAP_PLAY");
         m_bouys_gold = new Array();
         m_bouys_green = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = m_art.getChildByName("gold_" + (_loc2_ + 1).toString()) as MovieClip;
            _loc4_ = m_art.getChildByName("green_" + (_loc2_ + 1).toString()) as MovieClip;
            _loc3_.mouseEnabled = true;
            _loc3_.buttonMode = true;
            _loc4_.mouseEnabled = true;
            _loc4_.buttonMode = true;
            m_art.removeChild(_loc3_);
            m_art.removeChild(_loc4_);
            m_bouys_gold.push(_loc3_);
            m_bouys_green.push(_loc4_);
            _loc4_.rotation = -7;
            _loc3_.rotation = -2;
            TweenMax.to(_loc4_,2,{
               "y":_loc4_.y + 1,
               "rotation":7,
               "yoyo":true,
               "repeat":-1,
               "ease":Sine.easeInOut
            }).currentProgress = (Math.random() - 0.5) * 2;
            TweenMax.to(_loc3_,2,{
               "y":_loc3_.y + 1,
               "rotation":10,
               "yoyo":true,
               "repeat":-1,
               "ease":Sine.easeInOut
            }).currentProgress = (Math.random() - 0.5) * 2;
            _loc2_++;
         }
         m_selector = m_art.getChildByName("selector") as MovieClip;
         m_selector.scaleX = 0.95;
         m_selector.scaleY = 0.95;
         TweenMax.to(m_selector,0.5,{
            "scaleX":1.1,
            "scaleY":1.1,
            "yoyo":true,
            "repeat":-1
         });
         m_infownd = m_art.getChildByName("info_wnd") as MovieClip;
         m_infownd.alpha = 0;
         m_infownd.mouseEnabled = false;
         m_infownd.mouseChildren = false;
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_SCORES"));
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_TIME"));
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_ARTFCTS"));
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_NUM"));
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_NAME"));
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_SCORE"));
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_CURTIME"));
         m_infownd.addChild(XMLTextFields.create("WORLD_MAP_INFO_ARTNUM"));
         (m_infownd.getChildByName("text_scores") as MyTextField).text = XMLTranslation.s("WORLD_MAP_INFOWND_SCORES");
         (m_infownd.getChildByName("text_time") as MyTextField).text = XMLTranslation.s("WORLD_MAP_INFOWND_TIME");
         (m_infownd.getChildByName("text_artifacts") as MyTextField).text = XMLTranslation.s("WORLD_MAP_INFOWND_ARTEFACTS");
         m_fill = new Sprite();
         m_this.addChild(m_fill);
         m_fill.graphics.beginFill(0,1);
         m_fill.graphics.drawRect(0,0,640,480);
         m_fill.graphics.endFill();
         m_art.removeChild(m_infownd);
         m_art.addChild(m_infownd);
      }
      
      public static function show() : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         var j:int = 0;
         while(j < 6)
         {
            if(Save.unlocked_level(j))
            {
               if(Save.won_level(j))
               {
                  set_level_green(j);
                  m_selector.x = m_bouys_green[j].x;
                  m_selector.y = m_bouys_green[j].y;
                  m_level_index = j;
               }
               else if(Save.extra_won_level(j))
               {
                  set_level_gold(j);
                  m_selector.x = m_bouys_gold[j].x;
                  m_selector.y = m_bouys_gold[j].y;
                  m_level_index = j;
               }
            }
            else
            {
               set_level_hidden(j);
            }
            j++;
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
      
      private static function on_added(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         m_menu.addEventListener(MouseEvent.CLICK,on_menu);
         m_play.addEventListener(MouseEvent.CLICK,on_play);
         m_getit.addEventListener(MouseEvent.CLICK,on_getit);
         m_menu.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_play.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_getit.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = m_bouys_gold[_loc2_] as MovieClip;
            _loc4_ = m_bouys_green[_loc2_] as MovieClip;
            _loc4_.addEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc4_.addEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,on_bouy_over);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,on_bouy_out);
            _loc3_.addEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc3_.addEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc3_.addEventListener(MouseEvent.MOUSE_OVER,on_bouy_over);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,on_bouy_out);
            _loc2_++;
         }
      }
      
      private static function on_removed(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         m_menu.removeEventListener(MouseEvent.CLICK,on_menu);
         m_play.removeEventListener(MouseEvent.CLICK,on_play);
         m_getit.removeEventListener(MouseEvent.CLICK,on_getit);
         m_menu.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_play.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         m_getit.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = m_bouys_gold[_loc2_] as MovieClip;
            _loc4_ = m_bouys_green[_loc2_] as MovieClip;
            _loc4_.removeEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc4_.removeEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc4_.removeEventListener(MouseEvent.MOUSE_OVER,on_bouy_over);
            _loc4_.removeEventListener(MouseEvent.MOUSE_OUT,on_bouy_out);
            _loc3_.removeEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc3_.removeEventListener(MouseEvent.CLICK,on_bouy_click);
            _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,on_bouy_over);
            _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,on_bouy_out);
            _loc2_++;
         }
      }
      
      private static function on_menu(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SndMgr.PlaySound("btn_click");
         show_fill(function f():void
         {
            MainMenu.show();
            WorldMap.hide();
         });
      }
      
      private static function on_play(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SndMgr.PlaySound("btn_click");
         show_fill(function f():void
         {
            LevelLoading.show(m_level_index);
            WorldMap.hide();
         });
      }
      
      private static function on_getit(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         navigateToURL(new URLRequest(XMLUrl.get_url()));
      }
      
      public static function set_level_green(param1:int) : void
      {
         if(param1 < 0 || param1 > 5)
         {
            return;
         }
         var _loc2_:MovieClip = m_bouys_green[param1];
         var _loc3_:MovieClip = m_bouys_gold[param1];
         if(m_art.contains(_loc3_))
         {
            m_art.removeChild(_loc3_);
         }
         if(!m_art.contains(_loc2_))
         {
            m_art.addChild(_loc2_);
         }
         m_art.removeChild(m_infownd);
         m_art.addChild(m_infownd);
      }
      
      public static function set_level_gold(param1:int) : void
      {
         if(param1 < 0 || param1 > 5)
         {
            return;
         }
         var _loc2_:MovieClip = m_bouys_green[param1];
         var _loc3_:MovieClip = m_bouys_gold[param1];
         if(m_art.contains(_loc2_))
         {
            m_art.removeChild(_loc2_);
         }
         if(!m_art.contains(_loc3_))
         {
            m_art.addChild(_loc3_);
         }
         m_art.removeChild(m_infownd);
         m_art.addChild(m_infownd);
      }
      
      public static function set_level_hidden(param1:int) : void
      {
         if(param1 < 0 || param1 > 5)
         {
            return;
         }
         var _loc2_:MovieClip = m_bouys_green[param1];
         var _loc3_:MovieClip = m_bouys_gold[param1];
         if(m_art.contains(_loc2_))
         {
            m_art.removeChild(_loc2_);
         }
         if(m_art.contains(_loc3_))
         {
            m_art.removeChild(_loc3_);
         }
      }
      
      private static function on_bouy_click(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         SndMgr.PlaySound("btn_click");
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = m_bouys_gold[_loc2_] as MovieClip;
            _loc4_ = m_bouys_green[_loc2_] as MovieClip;
            if(param1.currentTarget == _loc3_ || param1.currentTarget == _loc4_)
            {
               m_level_index = _loc2_;
            }
            _loc2_++;
         }
         TweenMax.to(m_selector,0.2,{
            "x":param1.currentTarget.x,
            "y":param1.currentTarget.y,
            "overwrite":false
         });
      }
      
      private static function on_bouy_over(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MyTextField = null;
         var _loc6_:MyTextField = null;
         var _loc7_:MyTextField = null;
         var _loc8_:MyTextField = null;
         var _loc9_:MyTextField = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var _loc14_:String = null;
         SndMgr.PlaySound("btn_over");
         m_infownd.x = param1.currentTarget.x - m_infownd.width / 2;
         m_infownd.y = param1.currentTarget.y - m_infownd.height * 1.3;
         if(m_infownd.x < 2)
         {
            m_infownd.x = 2;
         }
         TweenLite.to(m_infownd,0.5,{"alpha":1});
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = m_bouys_gold[_loc2_] as MovieClip;
            _loc4_ = m_bouys_green[_loc2_] as MovieClip;
            if(param1.currentTarget == _loc3_ || param1.currentTarget == _loc4_)
            {
               _loc5_ = m_infownd.getChildByName("txt_num") as MyTextField;
               _loc6_ = m_infownd.getChildByName("txt_name") as MyTextField;
               _loc7_ = m_infownd.getChildByName("txt_scores") as MyTextField;
               _loc8_ = m_infownd.getChildByName("txt_time") as MyTextField;
               _loc9_ = m_infownd.getChildByName("txt_artifacts") as MyTextField;
               _loc7_.text = Save.level_get_scores(_loc2_).toString();
               _loc10_ = Save.level_get_time(_loc2_);
               _loc11_ = Math.floor(_loc10_ / 60);
               _loc12_ = _loc10_ - _loc11_ * 60;
               _loc13_ = _loc11_.toString();
               _loc14_ = _loc12_.toString();
               if(_loc13_.length < 2)
               {
                  _loc13_ = "0" + _loc13_;
               }
               if(_loc14_.length < 2)
               {
                  _loc14_ = "0" + _loc14_;
               }
               _loc8_.text = _loc13_ + ":" + _loc14_;
               _loc9_.text = Save.level_get_artifacts_collected(_loc2_).toString() + "/" + Save.level_get_artifacts_number(_loc2_);
               switch(_loc2_ + 1)
               {
                  case 1:
                     _loc5_.text = XMLTranslation.s("LEVEL_1_NUM");
                     _loc6_.text = XMLTranslation.s("LEVEL_1_NAME");
                     break;
                  case 2:
                     _loc5_.text = XMLTranslation.s("LEVEL_2_NUM");
                     _loc6_.text = XMLTranslation.s("LEVEL_2_NAME");
                     break;
                  case 3:
                     _loc5_.text = XMLTranslation.s("LEVEL_3_NUM");
                     _loc6_.text = XMLTranslation.s("LEVEL_3_NAME");
                     break;
                  case 4:
                     _loc5_.text = XMLTranslation.s("LEVEL_4_NUM");
                     _loc6_.text = XMLTranslation.s("LEVEL_4_NAME");
                     break;
                  case 5:
                     _loc5_.text = XMLTranslation.s("LEVEL_5_NUM");
                     _loc6_.text = XMLTranslation.s("LEVEL_5_NAME");
                     break;
                  case 6:
                     _loc5_.text = XMLTranslation.s("LEVEL_6_NUM");
                     _loc6_.text = XMLTranslation.s("LEVEL_6_NAME");
               }
            }
            _loc2_++;
         }
      }
      
      private static function on_bouy_out(param1:MouseEvent) : void
      {
         TweenLite.to(m_infownd,0.5,{"alpha":0});
      }
      
      private static function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
