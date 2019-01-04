package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import logic.GameLevel;
   import menu.ConfirmationDlg;
   import menu.GameMenu;
   import menu.GameScreen;
   import menu.LevelFinishing;
   import menu.LevelLoading;
   import menu.MainMenu;
   import menu.NotifyDlg;
   import menu.OptionsMenu;
   import menu.PlayerCreateMenu;
   import menu.PlayersMenu;
   import menu.ScoresMenu;
   import menu.WorldMap;
   
   public class Application extends Sprite
   {
       
      
      private var xml_loaded_num:int = 0;
      
      public function Application()
      {
         super();
         if(stage)
         {
            this.pre_init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.pre_init);
         }
      }
      
      private function pre_init(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.pre_init);
         true;
         XMLUrl.init();
         XMLTranslation.init();
         this.show_splashes();
      }
      
      private function on_xml_loaded() : void
      {
         this.xml_loaded_num++;
         if(this.xml_loaded_num == 2)
         {
            this.show_splashes();
         }
      }
      
      private function show_splashes() : void
      {
         this.init();
      }
      
      private function show_splash_1(param1:Function) : void
      {
         this.addChild(new SplashScreen(param1));
      }
      
      private function hide_splash_1(param1:Sprite) : void
      {
         this.init();
      }
      
      private function init(param1:Event = null) : void
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Sprite = new Sprite();
         Save.init();
         XMLTextFields.init();
         MainMenu.init(_loc2_);
         OptionsMenu.init(_loc2_);
         PlayersMenu.init(_loc2_);
         PlayerCreateMenu.init(_loc2_);
         ConfirmationDlg.init(_loc2_);
         NotifyDlg.init(_loc2_);
         ScoresMenu.init(_loc2_);
         WorldMap.init(_loc2_);
         GameMenu.init(_loc2_);
         LevelLoading.init(_loc2_);
         GameScreen.init(_loc2_);
         LevelFinishing.init(_loc2_);
         this.addChild(_loc2_);
         this.addChild(_loc3_);
         SndMgr.PlayMusic("main_music",true,Save.get_music_level());
         MainMenu.show();
         stage.addEventListener(Event.ACTIVATE,this.on_activate);
         stage.addEventListener(Event.DEACTIVATE,this.on_deactivate);
      }
      
      private function on_activate(param1:Event) : void
      {
         SoundMixer.soundTransform = new SoundTransform(1);
      }
      
      private function on_deactivate(param1:Event) : void
      {
         SoundMixer.soundTransform = new SoundTransform(0);
         if(GameScreen.is_visible() && !LevelFinishing.is_visible() && !GameMenu.is_visible())
         {
            GameLevel.pause();
            GameMenu.show();
         }
      }
   }
}
