package logic.dynamic_objects
{
   import flash.display.Sprite;
   import logic.resources.ResType;
   
   public class RoadBoar_2 extends RepairableObject
   {
       
      
      private var m_anim:BmpClip = null;
      
      public function RoadBoar_2(param1:Sprite, param2:int, param3:int, param4:String)
      {
         super(param1,param4,false,0.05);
         this.x = param2;
         this.y = param3;
         this.m_anim = new BmpClip(new art_road_boar(),0.8,8);
         this.m_anim.scaleX = -1;
         this.m_anim.x = this.m_anim.x + this.m_anim.width;
         this.m_anim.x = this.m_anim.x - this.m_anim.width / 2;
         this.m_anim.y = this.m_anim.y - this.m_anim.height / 2;
         m_broken.addChild(this.m_anim);
         m_name = XMLTranslation.s("ROAD_BOAR");
         m_uses_res = ResType.GRAIN;
         m_uses = 3;
      }
      
      override public function quant(param1:Number) : void
      {
         super.quant(param1);
         this.m_anim.update(param1);
      }
   }
}
