package
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class XMLUrl
   {
      
      private static var m_url:String = "";
      
      private static var m_callback:Function = null;
       
      
      public function XMLUrl()
      {
         super();
      }
      
      public static function init(param1:String = "", param2:Function = null) : void
      {
         var _loc3_:Class = null;
         var _loc4_:ByteArray = null;
         var _loc5_:XML = null;
         var _loc6_:URLLoader = null;
         m_callback = param2;
         if(param1.length == 0)
         {
            _loc3_ = XMLUrl_xmlURL_class;
            _loc4_ = new _loc3_();
            _loc5_ = new XML(_loc4_.toString());
            m_url = _loc5_.data.@url;
            if(m_callback != null)
            {
               m_callback();
            }
         }
         else
         {
            _loc5_ = new XML();
            _loc6_ = new URLLoader(new URLRequest(param1));
            _loc6_.addEventListener(Event.COMPLETE,on_loading_complete);
         }
      }
      
      public static function on_loading_complete(param1:Event) : void
      {
         var _loc2_:XML = new XML(param1.target.data);
         m_url = _loc2_.data.@url;
         if(m_callback != null)
         {
            m_callback();
         }
      }
      
      public static function get_url() : String
      {
         return m_url;
      }
   }
}
