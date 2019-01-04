package menu
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import logic.resources.ResType;
   
   public class GameScreen_InfoWnd extends MovieClip
   {
       
      
      private var m_art_uses:MovieClip = null;
      
      private var m_art_gives:MovieClip = null;
      
      private var m_art_name:MovieClip = null;
      
      private var m_art_progress:MovieClip = null;
      
      private var m_art_progress_gives:MovieClip = null;
      
      private var m_art_uses_gives:MovieClip = null;
      
      private var m_icon:Sprite = null;
      
      public function GameScreen_InfoWnd()
      {
         super();
         this.m_art_uses = new ideGameScreen_InfoUses();
         this.m_art_uses.addChild(XMLTextFields.create("INFOWND_USES_NAME"));
         this.m_art_uses.addChild(XMLTextFields.create("INFOWND_USES_RES"));
         this.m_art_uses.addChild(XMLTextFields.create("INFOWND_USES_NUM"));
         this.m_art_gives = new ideGameScreen_InfoGives();
         this.m_art_gives.addChild(XMLTextFields.create("INFOWND_GIVES_NAME"));
         this.m_art_gives.addChild(XMLTextFields.create("INFOWND_GIVES_TXT"));
         this.m_art_gives.addChild(XMLTextFields.create("INFOWND_GIVES_NUM"));
         this.m_art_name = new ideGameScreen_InfoName();
         this.m_art_name.addChild(XMLTextFields.create("INFOWND_NAME"));
         this.m_art_progress = new ideGameScreen_InfoProgress();
         this.m_art_progress.addChild(XMLTextFields.create("INFOWND_PROGRESS_NAME"));
         this.m_art_progress_gives = new ideGameScreen_InfoProgressGives();
         this.m_art_progress_gives.addChild(XMLTextFields.create("INFOWND_PRGRSGIVES_TTL"));
         this.m_art_progress_gives.addChild(XMLTextFields.create("INFOWND_PRGRSGIVES_RES"));
         this.m_art_progress_gives.addChild(XMLTextFields.create("INFOWND_PRGRSGIVES_NUM"));
         this.m_art_uses_gives = new ideGameScreen_InfoUsesGives();
         this.m_art_uses_gives.addChild(XMLTextFields.create("INFOWND_USESGIVES_NAME"));
         this.m_art_uses_gives.addChild(XMLTextFields.create("INFOWND_USESGIVES_GTXT"));
         this.m_art_uses_gives.addChild(XMLTextFields.create("INFOWND_USESGIVES_GNUM"));
         this.m_art_uses_gives.addChild(XMLTextFields.create("INFOWND_USESGIVES_UTXT"));
         this.m_art_uses_gives.addChild(XMLTextFields.create("INFOWND_USESGIVES_UNUM"));
         this.m_icon = new Sprite();
         this.addChild(this.m_icon);
      }
      
      public function set_info(param1:int = 0, param2:int = 0, param3:int = -1, param4:int = -1, param5:String = "", param6:Number = -1) : void
      {
         if(this.y - this.height < 21)
         {
            this.y = 21 + this.height;
         }
         if(param2 > 0 && param1 > 0)
         {
            (this.m_art_uses_gives.getChildByName("txt_name") as MyTextField).text = param5;
            (this.m_art_uses_gives.getChildByName("txt_gives_num") as MyTextField).text = "+" + param2.toString();
            (this.m_art_uses_gives.getChildByName("txt_uses_num") as MyTextField).text = "-" + param1.toString();
            (this.m_art_uses_gives.getChildByName("txt_gives") as MyTextField).text = XMLTranslation.s("GAMESCREEN_INFO_WND_GIVES");
            (this.m_art_uses_gives.getChildByName("txt_uses") as MyTextField).text = XMLTranslation.s("GAMESCREEN_INFO_WND_USES");
            if(!this.contains(this.m_art_uses_gives))
            {
               this.addChildAt(this.m_art_uses_gives,0);
            }
         }
         else if(this.contains(this.m_art_uses_gives))
         {
            this.removeChild(this.m_art_uses_gives);
         }
         if(param6 >= 0 && param2 <= 0)
         {
            (this.m_art_progress.getChildByName("txt_name") as MyTextField).text = param5;
            (this.m_art_progress.getChildByName("bar_full") as MovieClip).scaleX = param6;
            if(!this.contains(this.m_art_progress))
            {
               this.addChildAt(this.m_art_progress,0);
            }
         }
         else if(this.contains(this.m_art_progress))
         {
            this.removeChild(this.m_art_progress);
         }
         if(param6 >= 0 && param2 > 0 && param1 <= 0)
         {
            (this.m_art_progress_gives.getChildByName("txt_name") as MyTextField).text = param5;
            (this.m_art_progress_gives.getChildByName("bar_full") as MovieClip).scaleX = param6;
            (this.m_art_progress_gives.getChildByName("txt_gives") as MyTextField).text = XMLTranslation.s("GAMESCREEN_INFO_WND_GIVES");
            (this.m_art_progress_gives.getChildByName("txt_num") as MyTextField).text = "+" + param2.toString();
            if(!this.contains(this.m_art_progress_gives))
            {
               this.addChildAt(this.m_art_progress_gives,0);
            }
         }
         else if(this.contains(this.m_art_progress_gives))
         {
            this.removeChild(this.m_art_progress_gives);
         }
         if(param6 < 0 && param1 && param2 <= 0)
         {
            (this.m_art_uses.getChildByName("txt_uses") as MyTextField).text = XMLTranslation.s("GAMESCREEN_INFO_WND_USES");
            (this.m_art_uses.getChildByName("txt_num") as MyTextField).text = "-" + param1.toString();
            (this.m_art_uses.getChildByName("txt_name") as MyTextField).text = param5;
            if(!this.contains(this.m_art_uses))
            {
               this.addChildAt(this.m_art_uses,0);
            }
         }
         else if(this.contains(this.m_art_uses))
         {
            this.removeChild(this.m_art_uses);
         }
         if(param6 < 0 && param2 && param1 <= 0 && param4 != ResType.DIAMONDS)
         {
            (this.m_art_gives.getChildByName("txt_gives") as MyTextField).text = XMLTranslation.s("GAMESCREEN_INFO_WND_GIVES");
            (this.m_art_gives.getChildByName("txt_num") as MyTextField).text = "+" + param2.toString();
            (this.m_art_gives.getChildByName("txt_name") as MyTextField).text = param5;
            if(!this.contains(this.m_art_gives))
            {
               this.addChildAt(this.m_art_gives,0);
            }
         }
         else if(this.contains(this.m_art_gives))
         {
            this.removeChild(this.m_art_gives);
         }
         if(param6 < 0 && (!param1 && !param2 || param3 == ResType.DIAMONDS || param4 == ResType.DIAMONDS))
         {
            (this.m_art_name.getChildByName("txt_name") as MyTextField).text = param5;
            if(!this.contains(this.m_art_name))
            {
               this.addChildAt(this.m_art_name,0);
            }
         }
         else if(this.contains(this.m_art_name))
         {
            this.removeChild(this.m_art_name);
         }
         while(this.m_icon.numChildren)
         {
            this.m_icon.removeChildAt(0);
         }
         var _loc7_:Bitmap = ResType.new_icon(param4);
         var _loc8_:Bitmap = ResType.new_icon(param3);
         if(_loc7_ && param2)
         {
            _loc7_.x = 22;
            _loc7_.y = -19;
            if(param6 >= 0)
            {
               _loc7_.y = -19;
            }
            if(_loc8_)
            {
               _loc7_.x = 25;
            }
            _loc7_.smoothing = true;
            _loc7_.scaleX = 0.6;
            _loc7_.scaleY = 0.6;
            this.m_icon.addChild(_loc7_);
         }
         if(_loc8_ && param1)
         {
            _loc8_.x = 22;
            _loc8_.y = -19;
            if(param6 >= 0)
            {
               _loc8_.y = -26;
            }
            if(param2 > 0)
            {
               _loc8_.x = 25;
               _loc8_.y = -28;
            }
            _loc8_.smoothing = true;
            _loc8_.scaleX = 0.6;
            _loc8_.scaleY = 0.6;
            this.m_icon.addChild(_loc8_);
         }
      }
   }
}
