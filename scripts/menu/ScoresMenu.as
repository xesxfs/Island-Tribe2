package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ScoresMenu extends Sprite
   {
      
      private static var m_this:ScoresMenu = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_ok:SimpleButton = null;
      
      private static var m_scores:Sprite = null;
       
      
      public function ScoresMenu()
      {
         super();
         if(m_this != null)
         {
         }
         m_this = this;
         m_scores = new Sprite();
         m_this.addChild(m_scores);
         this.addEventListener(Event.ADDED_TO_STAGE,on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,on_removed);
      }
      
      public static function init(param1:Sprite) : void
      {
         new ScoresMenu();
         m_layer = param1;
         var _loc2_:MovieClip = new ideScoresMenu();
         m_this.addChild(_loc2_);
         m_ok = _loc2_.getChildByName("btn_ok") as SimpleButton;
         _loc2_.addChild(XMLTextFields.create("SCORES_MENU_TITLE"));
         _loc2_.addChild(XMLTextFields.create("SCORES_MENU_OK"));
         (_loc2_.getChildByName("txt_title") as MyTextField).text = XMLTranslation.s("MENU_SCORES_TITLE");
         (_loc2_.getChildByName("txt_ok") as MyTextField).text = XMLTranslation.s("MENU_SCORES_OK");
         update_scores();
      }
      
      public static function show() : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_this.alpha = 0;
         TweenLite.to(m_this,0.5,{"alpha":1});
         update_scores();
      }
      
      public static function hide() : void
      {
         if(m_layer != null && m_layer.contains(m_this))
         {
            m_layer.removeChild(m_this);
         }
      }
      
      public static function update_scores() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:ideScoresMenu_OneResult = null;
         if(m_scores != null)
         {
            m_this.removeChild(m_scores);
            m_scores = new Sprite();
            m_this.addChild(m_scores);
         }
         var _loc1_:int = 0;
         while(_loc1_ < Save.num_scores())
         {
            _loc2_ = "";
            _loc3_ = "";
            _loc4_ = new ideScoresMenu_OneResult();
            _loc4_.x = 317;
            _loc4_.y = 180 + 25 * _loc1_;
            _loc4_.addChild(XMLTextFields.create("SCORES_MENU_NAME"));
            _loc4_.addChild(XMLTextFields.create("SCORES_MENU_POINTS"));
            (_loc4_.getChildByName("txt_name") as MyTextField).text = Save.scores_name(_loc1_);
            (_loc4_.getChildByName("txt_points") as MyTextField).text = Save.scores_points(_loc1_).toString();
            m_scores.addChild(_loc4_);
            _loc1_++;
         }
      }
      
      private static function on_added(param1:Event) : void
      {
         m_ok.addEventListener(MouseEvent.CLICK,on_ok);
         m_ok.addEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
      }
      
      private static function on_removed(param1:Event) : void
      {
         m_ok.removeEventListener(MouseEvent.CLICK,on_ok);
         m_ok.removeEventListener(MouseEvent.MOUSE_OVER,on_btn_over);
      }
      
      private static function on_ok(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         hide();
      }
      
      private static function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
