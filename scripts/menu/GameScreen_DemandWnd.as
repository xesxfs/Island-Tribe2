package menu
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import logic.resources.ResType;
   
   public class GameScreen_DemandWnd extends Sprite
   {
       
      
      private var m_art:MovieClip = null;
      
      private var m_icon:Sprite = null;
      
      public function GameScreen_DemandWnd()
      {
         super();
         this.m_art = new ideGameScreen_DemandWnd();
         this.m_icon = new Sprite();
         this.addChild(this.m_art);
         this.addChild(this.m_icon);
         this.m_art.addChild(XMLTextFields.create("INFOWND_DEMAND_NAME"));
         this.m_art.addChild(XMLTextFields.create("INFOWND_DEMAND_NUM"));
      }
      
      public function set_info(param1:int = 0, param2:int = -1) : void
      {
         (this.m_art.getChildByName("txt_uses") as MyTextField).text = XMLTranslation.s("GAMESCREEN_INFO_WND_USES");
         (this.m_art.getChildByName("txt_num") as MyTextField).text = "-" + param1.toString();
         var _loc3_:Bitmap = ResType.new_icon(param2);
         if(_loc3_ && param1)
         {
            _loc3_.x = 18;
            _loc3_.y = -36;
            _loc3_.smoothing = true;
            _loc3_.scaleX = 0.6;
            _loc3_.scaleY = 0.6;
            this.m_icon.addChild(_loc3_);
         }
      }
   }
}
