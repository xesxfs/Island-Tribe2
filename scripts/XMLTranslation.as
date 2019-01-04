package
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class XMLTranslation
   {
      
      private static var m_xml:XML = null;
      
      private static var m_callback:Function = null;
       
      
      public function XMLTranslation()
      {
         super();
      }
      
      public static function init(param1:String = "", param2:Function = null) : void
      {
         var _loc3_:Class = null;
         var _loc4_:ByteArray = null;
         var _loc5_:URLLoader = null;
         m_callback = param2;
         if(param1.length == 0)
         {
            _loc3_ = XMLTranslation_xmlURL_class;
            _loc4_ = new _loc3_();
            m_xml = new XML(_loc4_.toString());
            if(m_callback != null)
            {
               m_callback();
            }
         }
         else
         {
            _loc5_ = new URLLoader(new URLRequest(param1));
            _loc5_.addEventListener(Event.COMPLETE,on_loading_complete);
         }
      }
      
      public static function on_loading_complete(param1:Event) : void
      {
         m_xml = new XML(param1.target.data);
         if(m_callback != null)
         {
            m_callback();
         }
      }
      
      public static function s(param1:String) : String
      {
         var _loc2_:String = m_xml.child(param1);
         return _loc2_;
      }
   }
}
