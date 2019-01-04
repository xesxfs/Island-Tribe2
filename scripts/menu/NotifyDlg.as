package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class NotifyDlg extends Sprite
   {
      
      private static var m_this:NotifyDlg = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_ok:SimpleButton = null;
      
      private static var m_text:MyTextField = null;
       
      
      public function NotifyDlg()
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
         new NotifyDlg();
         m_layer = param1;
         var _loc2_:MovieClip = new ideNotifyDlg();
         m_this.addChild(_loc2_);
         _loc2_.addChild(XMLTextFields.create("NOTIFICATION_DLG_TEXT"));
         _loc2_.addChild(XMLTextFields.create("NOTIFICATION_DLG_OK"));
         (_loc2_.getChildByName("txt_ok") as MyTextField).text = XMLTranslation.s("MENU_DLG_OK");
         m_ok = _loc2_.getChildByName("btn_ok") as SimpleButton;
         m_text = _loc2_.getChildByName("txt_field") as MyTextField;
      }
      
      public static function show(param1:String) : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_text.text = param1;
         m_this.alpha = 0;
         TweenLite.to(m_this,0.1,{"alpha":1});
      }
      
      public static function hide() : void
      {
         if(m_layer != null && m_layer.contains(m_this))
         {
            m_layer.removeChild(m_this);
         }
      }
      
      private static function on_ok(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         hide();
      }
      
      private function on_added(param1:Event) : void
      {
         m_ok.addEventListener(MouseEvent.CLICK,on_ok);
         m_ok.addEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_removed(param1:Event) : void
      {
         m_ok.removeEventListener(MouseEvent.CLICK,on_ok);
         m_ok.removeEventListener(MouseEvent.MOUSE_OVER,this.on_btn_over);
      }
      
      private function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
