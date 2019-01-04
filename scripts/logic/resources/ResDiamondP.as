package logic.resources
{
   import flash.display.Sprite;
   
   public class ResDiamondP extends PickupableObject
   {
       
      
      private var m_anim:BmpClip = null;
      
      public function ResDiamondP(param1:Sprite, param2:int, param3:int, param4:int, param5:String)
      {
         super(param1,param5);
         this.x = param2;
         this.y = param3;
         m_gives_res = ResType.DIAMONDS;
         m_gives = param4;
         this.m_anim = new BmpClip(new art_diamond_p(),1.2,12);
         this.m_anim.x = -this.m_anim.width / 2;
         this.m_anim.y = -this.m_anim.height / 2;
         this.m_anim.gotoAndPlay(Math.ceil(Math.random() * this.m_anim.totalFrames));
         m_art.addChild(this.m_anim);
         this.addChild(m_art);
         m_name = XMLTranslation.s("DIAMOND");
      }
      
      override public function quant(param1:Number) : void
      {
         this.m_anim.update(param1);
         super.quant(param1);
      }
   }
}
