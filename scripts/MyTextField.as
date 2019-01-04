package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class MyTextField extends Sprite
   {
       
      
      private var m_art:MovieClip = null;
      
      public var m_txt:TextField = null;
      
      public function MyTextField(param1:String, param2:Rectangle, param3:int, param4:int, param5:int)
      {
         super();
         this.name = param1;
         this.m_art = new ideMyTextField();
         this.m_txt = this.m_art.getChildAt(0) as TextField;
         this.m_txt.x = 0;
         this.m_txt.y = 0;
         this.m_txt.text = "Visitor";
         var _loc6_:TextFormat = new TextFormat(this.m_txt.defaultTextFormat.font,param3,param4);
         _loc6_.align = TextFormatAlign.CENTER;
         if(param5 < 0)
         {
            _loc6_.align = TextFormatAlign.LEFT;
         }
         if(param5 > 0)
         {
            _loc6_.align = TextFormatAlign.RIGHT;
         }
         this.m_txt.defaultTextFormat = _loc6_;
         this.m_txt.width = param2.width;
         this.m_txt.height = param2.height;
         this.m_txt.multiline = true;
         this.m_txt.wordWrap = true;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.addChild(this.m_art);
         this.x = param2.x;
         this.y = param2.y;
      }
      
      public function set text(param1:String) : void
      {
         this.m_txt.text = param1;
      }
      
      public function get text() : String
      {
         return this.m_txt.text;
      }
      
      public function set textColor(param1:int) : void
      {
         this.m_txt.textColor = param1;
      }
      
      public function get textColor() : int
      {
         return this.m_txt.textColor;
      }
   }
}
