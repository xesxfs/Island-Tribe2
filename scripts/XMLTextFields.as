package
{
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class XMLTextFields
   {
      
      private static var m_xml:XML = null;
       
      
      public function XMLTextFields()
      {
         super();
      }
      
      public static function init() : void
      {
         var _loc1_:Class = XMLTextFields_xmlURL_class;
         var _loc2_:ByteArray = new _loc1_();
         m_xml = new XML(_loc2_.toString());
      }
      
      public static function create(param1:String) : MyTextField
      {
         var _loc2_:XMLList = m_xml.child(param1);
         var _loc3_:String = _loc2_.@name;
         var _loc4_:int = _loc2_.@x;
         var _loc5_:int = _loc2_.@y;
         var _loc6_:int = _loc2_.@w;
         var _loc7_:int = _loc2_.@h;
         var _loc8_:int = _loc2_.@size;
         var _loc9_:int = _loc2_.@color;
         var _loc10_:int = _loc2_.@align;
         var _loc11_:MyTextField = new MyTextField(_loc3_,new Rectangle(_loc4_,_loc5_,_loc6_,_loc7_),_loc8_,_loc9_,_loc10_);
         return _loc11_;
      }
   }
}
