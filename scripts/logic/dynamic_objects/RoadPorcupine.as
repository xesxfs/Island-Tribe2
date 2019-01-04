package logic.dynamic_objects
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import logic.resources.DestroyableObject;
   import logic.resources.ResType;
   
   public class RoadPorcupine extends DestroyableObject
   {
       
      
      private var m_anim:BmpClip = null;
      
      public function RoadPorcupine(param1:Sprite, param2:int, param3:int, param4:String, param5:Boolean = false, param6:Rectangle = null)
      {
         super(param1,param4,false,0.05);
         this.x = param2;
         this.y = param3;
         this.m_anim = new BmpClip(new art_porcupine(),1);
         this.m_anim.x = this.m_anim.x - this.m_anim.width / 2;
         this.m_anim.y = this.m_anim.y - this.m_anim.height / 2;
         m_full.addChild(this.m_anim);
         m_name = XMLTranslation.s("ROAD_PORCUPINE");
         m_uses_res = ResType.MILK;
         m_uses = 3;
         if(param5)
         {
            hide();
         }
         m_unfog_ellipse = param6;
      }
      
      override public function quant(param1:Number) : void
      {
         super.quant(param1);
         this.m_anim.update(param1);
      }
   }
}
