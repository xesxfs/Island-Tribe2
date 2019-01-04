package menu
{
   import flash.display.MovieClip;
   
   public class GameScreen_BldPBar extends MovieClip
   {
       
      
      private var m_art:MovieClip = null;
      
      public function GameScreen_BldPBar()
      {
         super();
         this.m_art = new ideGameScreen_BldPBar();
         (this.m_art.getChildByName("bar_full") as MovieClip).scaleX = 0;
         this.addChild(this.m_art);
      }
      
      public function set_progress(param1:Number = -1) : void
      {
         (this.m_art.getChildByName("bar_full") as MovieClip).scaleX = param1;
      }
   }
}
