package logic.pf
{
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class PFGraph
   {
       
      
      public var m_canvas:Sprite = null;
      
      public var m_nodes:Array = null;
      
      public var m_links:Dictionary = null;
      
      public var m_strs:Dictionary = null;
      
      public function PFGraph()
      {
         super();
         this.m_nodes = new Array();
         this.m_links = new Dictionary();
         this.m_strs = new Dictionary();
         if(this.m_canvas)
         {
            this.m_canvas.mouseEnabled = false;
            this.m_canvas.mouseChildren = false;
         }
         this.redraw_canvas();
      }
      
      public function add_node(param1:int, param2:int, param3:String = "", param4:Boolean = true) : int
      {
         var _loc7_:int = 0;
         var _loc5_:PFNode = new PFNode(param1,param2,param3,param4);
         var _loc6_:int = this.m_nodes.push(_loc5_) - 1;
         if(param3.length > 0)
         {
            _loc7_ = this.strid2uid(param3);
            if(_loc7_ < 0)
            {
               this.m_strs[param3] = _loc6_;
            }
         }
         return _loc6_;
      }
      
      public function add_link(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.m_links[param1] == undefined)
         {
            this.m_links[param1] = new Array();
         }
         if(this.m_links[param2] == undefined)
         {
            this.m_links[param2] = new Array();
         }
         for each(_loc3_ in this.m_links[param1])
         {
            if(_loc3_ == param2)
            {
               return;
            }
         }
         for each(_loc4_ in this.m_links[param2])
         {
            if(_loc4_ == param1)
            {
               return;
            }
         }
         this.m_links[param1].push(param2);
         this.m_links[param2].push(param1);
      }
      
      public function get_path(param1:int, param2:int) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:PFNode = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:PFNode = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_nodes.length)
         {
            (this.m_nodes[_loc3_] as PFNode).pf_dist = -1;
            (this.m_nodes[_loc3_] as PFNode).pf_from = -1;
            _loc3_++;
         }
         (this.m_nodes[param1] as PFNode).pf_dist = 0;
         var _loc4_:Array = new Array();
         _loc4_.push(param1);
         while(_loc4_.length)
         {
            _loc5_ = _loc4_.shift();
            _loc6_ = this.m_nodes[_loc5_];
            if(_loc5_ == param2)
            {
               _loc8_ = new Array();
               _loc9_ = _loc5_;
               while(_loc9_ != param1)
               {
                  _loc8_.push(_loc9_);
                  _loc9_ = (this.m_nodes[_loc9_] as PFNode).pf_from;
               }
               _loc8_.push(param1);
               _loc8_.reverse();
               return _loc8_;
            }
            for each(_loc7_ in this.m_links[_loc5_])
            {
               _loc10_ = this.m_nodes[_loc7_] as PFNode;
               if(!(!_loc10_.passable() && _loc7_ != param2))
               {
                  if(_loc10_.pf_from == -1 || _loc10_.pf_dist > _loc6_.pf_dist + 1)
                  {
                     _loc10_.pf_from = _loc5_;
                     _loc10_.pf_dist = _loc6_.pf_dist + 1;
                     _loc4_.push(_loc7_);
                  }
               }
            }
         }
         return null;
      }
      
      public function get_nearest_node(param1:int, param2:int) : int
      {
         var _loc6_:Number = NaN;
         var _loc3_:Number = 0;
         var _loc4_:int = -1;
         var _loc5_:int = 0;
         while(_loc5_ < this.m_nodes.length)
         {
            _loc6_ = Math.sqrt(Math.pow(this.get_node(_loc5_).pos().x - param1,2) + Math.pow(this.get_node(_loc5_).pos().y - param2,2));
            if(_loc6_ < _loc3_ || _loc4_ < 0)
            {
               _loc4_ = _loc5_;
               _loc3_ = _loc6_;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function strid2uid(param1:String) : int
      {
         if(this.m_strs[param1] != undefined)
         {
            return this.m_strs[param1];
         }
         return -1;
      }
      
      public function get_node(param1:int) : PFNode
      {
         if(param1 >= 0 && param1 < this.m_nodes.length)
         {
            return this.m_nodes[param1];
         }
         return null;
      }
      
      public function redraw_canvas() : void
      {
         var _loc3_:int = 0;
         var _loc4_:PFNode = null;
         var _loc5_:TextField = null;
         if(this.m_canvas == null)
         {
            return;
         }
         this.m_canvas.alpha = 0.5;
         this.m_canvas.useHandCursor = true;
         this.m_canvas.buttonMode = true;
         this.m_canvas.graphics.clear();
         this.m_canvas.graphics.beginFill(0,0.75);
         this.m_canvas.graphics.drawRect(0,0,640,480);
         this.m_canvas.graphics.endFill();
         while(this.m_canvas.numChildren)
         {
            this.m_canvas.removeChild(this.m_canvas.getChildAt(0));
         }
         this.m_canvas.graphics.lineStyle(1,16777215,0.5);
         var _loc1_:int = 0;
         while(_loc1_ < this.m_nodes.length)
         {
            if(this.m_links[_loc1_] != undefined)
            {
               for each(_loc3_ in this.m_links[_loc1_])
               {
                  this.m_canvas.graphics.moveTo(this.get_node(_loc1_).pos().x,this.get_node(_loc1_).pos().y);
                  this.m_canvas.graphics.lineTo(this.get_node(_loc3_).pos().x,this.get_node(_loc3_).pos().y);
               }
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.m_nodes.length)
         {
            _loc4_ = this.get_node(_loc2_);
            this.m_canvas.graphics.lineStyle(1,16777215,0.5);
            if(_loc4_.passable())
            {
               this.m_canvas.graphics.beginFill(65280,1);
            }
            else
            {
               this.m_canvas.graphics.beginFill(16711680,1);
            }
            if(_loc4_.strid().length)
            {
               this.m_canvas.graphics.drawCircle(_loc4_.pos().x,_loc4_.pos().y,5);
            }
            else
            {
               this.m_canvas.graphics.drawCircle(_loc4_.pos().x,_loc4_.pos().y,2.5);
            }
            this.m_canvas.graphics.endFill();
            _loc5_ = new TextField();
            _loc5_.defaultTextFormat = new TextFormat(null,10);
            _loc5_.textColor = 16777215;
            _loc5_.mouseEnabled = false;
            if(_loc4_.strid().length > 0)
            {
               _loc5_.text = _loc2_.toString() + ": " + _loc4_.strid();
            }
            else
            {
               _loc5_.text = _loc2_.toString();
            }
            _loc5_.x = _loc4_.pos().x - _loc5_.textWidth / 2;
            _loc5_.y = _loc4_.pos().y - _loc5_.textHeight - 7;
            this.m_canvas.addChild(_loc5_);
            _loc2_++;
         }
      }
      
      private function on_click(param1:MouseEvent) : void
      {
         var _loc2_:int = this.get_nearest_node(this.m_canvas.mouseX,this.m_canvas.mouseY);
         var _loc3_:int = this.add_node(this.m_canvas.mouseX,this.m_canvas.mouseY);
         if(_loc2_ >= 0)
         {
            this.add_link(_loc2_,_loc3_);
         }
         this.redraw_canvas();
         this.export();
      }
      
      public function clear() : void
      {
         this.m_nodes = new Array();
         this.m_links = new Dictionary();
         this.m_strs = new Dictionary();
         this.redraw_canvas();
      }
      
      public function export() : void
      {
         var _loc4_:PFNode = null;
         var _loc5_:int = 0;
         var _loc1_:* = "\t\t\t\t// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---  \n";
         var _loc2_:int = 0;
         while(_loc2_ < this.m_nodes.length)
         {
            _loc4_ = this.get_node(_loc2_);
            if(_loc4_.strid().length > 0)
            {
               _loc1_ = _loc1_ + ("\t\t\t\tm_graph.add_node( " + _loc4_.pos().x + ", " + _loc4_.pos().y + ", \"" + _loc4_.strid() + "\" ); // " + _loc2_ + " \n");
            }
            else
            {
               _loc1_ = _loc1_ + ("\t\t\t\tm_graph.add_node( " + _loc4_.pos().x + ", " + _loc4_.pos().y + " ); // " + _loc2_ + " \n");
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.m_nodes.length)
         {
            if(this.m_links[_loc3_] != undefined)
            {
               for each(_loc5_ in this.m_links[_loc3_])
               {
                  if(_loc5_ >= _loc3_)
                  {
                     _loc1_ = _loc1_ + ("\t\t\t\tm_graph.add_link( " + _loc3_ + ", " + _loc5_ + " );\n");
                  }
               }
            }
            _loc3_++;
         }
         _loc1_ = _loc1_ + "\t\t\t\t// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---  \n";
         Clipboard.generalClipboard.clear();
         Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,_loc1_);
      }
   }
}
