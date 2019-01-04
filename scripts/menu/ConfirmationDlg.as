package menu
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConfirmationDlg extends Sprite
   {
      
      private static var m_this:ConfirmationDlg = null;
      
      private static var m_layer:Sprite = null;
      
      private static var m_ok:SimpleButton = null;
      
      private static var m_cancel:SimpleButton = null;
      
      private static var m_text:MyTextField = null;
      
      private static var m_ok_callback:Function = null;
       
      
      public function ConfirmationDlg()
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
         new ConfirmationDlg();
         m_layer = param1;
         var _loc2_:MovieClip = new ideConfirmationDlg();
         m_this.addChild(_loc2_);
         _loc2_.addChild(XMLTextFields.create("CONFIRMATION_DLG_TEXT"));
         _loc2_.addChild(XMLTextFields.create("CONFIRMATION_DLG_OK"));
         _loc2_.addChild(XMLTextFields.create("CONFIRMATION_DLG_CNCL"));
         (_loc2_.getChildByName("txt_ok") as MyTextField).text = XMLTranslation.s("MENU_DLG_OK");
         (_loc2_.getChildByName("txt_cancel") as MyTextField).text = XMLTranslation.s("MENU_DLG_CANCEL");
         m_ok = _loc2_.getChildByName("btn_ok") as SimpleButton;
         m_cancel = _loc2_.getChildByName("btn_cancel") as SimpleButton;
         m_text = _loc2_.getChildByName("txt_field") as MyTextField;
      }
      
      public static function show(param1:String, param2:Function) : void
      {
         if(m_layer != null && !m_layer.contains(m_this))
         {
            m_layer.addChild(m_this);
         }
         m_this.alpha = 0;
         TweenLite.to(m_this,0.1,{"alpha":1});
         m_text.text = param1;
         m_ok_callback = param2;
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
         if(m_ok_callback != null)
         {
            m_ok_callback();
         }
      }
      
      private static function on_cancel(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_click");
         hide();
      }
      
      private function on_added(param1:Event) : void
      {
         m_ok.addEventListener(MouseEvent.CLICK,on_ok);
         m_cancel.addEventListener(MouseEvent.CLICK,on_cancel);
      }
      
      private function on_removed(param1:Event) : void
      {
         m_ok.removeEventListener(MouseEvent.CLICK,on_ok);
         m_cancel.removeEventListener(MouseEvent.CLICK,on_cancel);
      }
      
      private function on_btn_over(param1:MouseEvent) : void
      {
         SndMgr.PlaySound("btn_over");
      }
   }
}
