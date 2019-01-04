package menu
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import logic.resources.ResType;
   
   public class GameScreen_ResPanel extends Sprite
   {
       
      
      private var m_term_L:MovieClip = null;
      
      private var m_term_R:MovieClip = null;
      
      private var m_res:Array = null;
      
      public function GameScreen_ResPanel()
      {
         var _loc2_:Bitmap = null;
         var _loc3_:MovieClip = null;
         super();
         this.m_res = new Array();
         this.m_term_L = new ideGameScreen_ResTermL();
         this.addChild(this.m_term_L);
         var _loc1_:int = 0;
         while(_loc1_ < ResType.LVLRES_LAST)
         {
            if(_loc1_ != ResType.DIAMONDS)
            {
               _loc3_ = new ideGameScreen_ResPanel();
               _loc3_.addChild(XMLTextFields.create("GAMESCREEN_RESPANEL"));
               this.addChild(_loc3_);
               this.m_res[_loc1_] = _loc3_;
            }
            else
            {
               this.m_res[_loc1_] = null;
            }
            _loc2_ = ResType.new_icon(_loc1_);
            if(_loc2_)
            {
               _loc2_.scaleX = 0.75;
               _loc2_.scaleY = 0.75;
               _loc2_.x = 12 - _loc2_.width / 2;
               _loc2_.y = 16 - _loc2_.height / 2;
               _loc3_.addChild(_loc2_);
            }
            _loc1_++;
         }
         this.m_term_R = new ideGameScreen_ResTermR();
         this.addChild(this.m_term_R);
      }
      
      public function update(param1:Array) : void
      {
         var _loc5_:MovieClip = null;
         if(param1.length != this.m_res.length)
         {
         }
         this.removeChild(this.m_term_L);
         this.removeChild(this.m_term_R);
         var _loc2_:int = 0;
         while(_loc2_ < this.m_res.length)
         {
            if(this.m_res[_loc2_] != null)
            {
               if(param1[_loc2_] < 0 && this.contains(this.m_res[_loc2_]))
               {
                  this.removeChild(this.m_res[_loc2_]);
               }
               if(param1[_loc2_] >= 0 && !this.contains(this.m_res[_loc2_]))
               {
                  this.addChild(this.m_res[_loc2_]);
               }
               (this.m_res[_loc2_].getChildByName("txt_num") as MyTextField).text = param1[_loc2_];
            }
            _loc2_++;
         }
         this.addChildAt(this.m_term_L,0);
         this.addChild(this.m_term_R);
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.numChildren)
         {
            _loc5_ = this.getChildAt(_loc4_) as MovieClip;
            _loc5_.x = _loc3_;
            _loc3_ = _loc3_ + _loc5_.width;
            _loc4_++;
         }
         this.x = 320 - this.width / 2;
         this.y = 480 - this.height;
      }
   }
}
