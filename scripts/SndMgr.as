package
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class SndMgr
   {
      
      private static var m_sounds:Array = null;
      
      private static var m_loopedSounds:Dictionary = new Dictionary();
      
      private static var m_loopedIDs:Dictionary = new Dictionary();
      
      private static var m_fadeInIDs:Array = new Array();
      
      private static var m_fadeOutIDs:Array = new Array();
       
      
      public function SndMgr()
      {
         super();
      }
      
      public static function PlayMusic(param1:String, param2:Boolean = false, param3:Number = 1.0) : void
      {
         Play(param1,param2,Save.get_music_level() * param3);
      }
      
      public static function PlaySound(param1:String, param2:Boolean = false, param3:Number = 1.0) : void
      {
         Play(param1,param2,Save.get_sound_level() * param3);
      }
      
      private static function Play(param1:String, param2:Boolean = false, param3:Number = 1.0) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(m_sounds == null)
         {
            m_sounds = new Array();
         }
         var _loc4_:Sound = null;
         switch(param1)
         {
            case "main_music":
               _loc4_ = new snd_main_music() as Sound;
               break;
            case "win_music":
               _loc4_ = new snd_win_music() as Sound;
               break;
            case "hammer":
               _loc4_ = new snd_hammer() as Sound;
               break;
            case "pick":
               _loc4_ = new snd_pick() as Sound;
               break;
            case "axe":
               _loc4_ = new snd_axe() as Sound;
               break;
            case "resource":
               _loc4_ = new snd_resource() as Sound;
               break;
            case "water_shsh":
               _loc4_ = new snd_water_shsh() as Sound;
               break;
            case "upgrade":
               _loc4_ = new snd_upgrade() as Sound;
               break;
            case "worker_in":
               _loc4_ = new snd_worker_in() as Sound;
               break;
            case "worker_out":
               _loc4_ = new snd_worker_out() as Sound;
               break;
            case "btn_over":
               _loc4_ = new snd_btn_over() as Sound;
               break;
            case "btn_click":
               _loc4_ = new snd_btn_click() as Sound;
               break;
            case "tasks_complete":
               _loc4_ = new snd_tasks_complete() as Sound;
               break;
            case "upgrade_start":
               _loc4_ = new snd_upgrade_start() as Sound;
               break;
            case "worker_joy":
               _loc4_ = new snd_worker_joy() as Sound;
               break;
            case "artefact":
               _loc4_ = new snd_artefact() as Sound;
               break;
            case "start_level":
               _loc4_ = new snd_start_level() as Sound;
               break;
            case "explorer_show":
               _loc4_ = new snd_explorer_show() as Sound;
               break;
            case "explorer_hide":
               _loc4_ = new snd_explorer_hide() as Sound;
               break;
            case "stamp":
               _loc4_ = new snd_stamp() as Sound;
               break;
            case "wasps":
               _loc4_ = new snd_wasps() as Sound;
         }
         if(_loc4_ != null)
         {
            if(m_sounds[param1] == null)
            {
               m_sounds[param1] = new Array();
               m_sounds[param1]["snd"] = _loc4_;
               m_sounds[param1]["ch"] = null;
               m_sounds[param1]["pos"] = 0;
               m_sounds[param1]["loop"] = !!param2?1000000:0;
            }
            _loc5_ = m_sounds[param1]["pos"];
            _loc6_ = m_sounds[param1]["loop"];
            if(m_sounds[param1]["ch"] != null)
            {
               (m_sounds[param1]["ch"] as SoundChannel).stop();
            }
            m_sounds[param1]["ch"] = _loc4_.play(_loc5_,0,new SoundTransform(param3));
            if(_loc6_ > 0)
            {
               (m_sounds[param1]["ch"] as SoundChannel).addEventListener(Event.SOUND_COMPLETE,RestartSound);
               m_loopedSounds[m_sounds[param1]["ch"] as SoundChannel] = _loc4_;
               m_loopedIDs[m_sounds[param1]["ch"] as SoundChannel] = param1;
            }
         }
      }
      
      public static function FadeIn(param1:String, param2:Boolean = false) : void
      {
         Play(param1,param2);
         var _loc3_:SoundChannel = m_sounds[param1]["ch"] as SoundChannel;
         if(_loc3_)
         {
            _loc3_.soundTransform = new SoundTransform(0);
            m_fadeInIDs.push(param1);
         }
      }
      
      public static function FadeOut(param1:String) : void
      {
         var _loc2_:SoundChannel = m_sounds[param1]["ch"] as SoundChannel;
         if(_loc2_)
         {
            _loc2_.soundTransform = new SoundTransform(1);
            m_fadeOutIDs.push(param1);
         }
      }
      
      public static function UpdateFades(param1:Number) : void
      {
         var _loc3_:Number = 0;
         var _loc4_:String = "";
         var _loc5_:SoundChannel = null;
         _loc3_ = 0;
         while(_loc3_ < m_fadeInIDs.length)
         {
            _loc4_ = m_fadeInIDs[_loc3_] as String;
            _loc5_ = m_sounds[_loc4_]["ch"] as SoundChannel;
            if(_loc5_)
            {
               if(_loc5_.soundTransform.volume + 0.05 > 1)
               {
                  _loc5_.soundTransform = new SoundTransform(1);
                  m_fadeInIDs.splice(_loc3_,1);
                  _loc3_--;
               }
               else
               {
                  _loc5_.soundTransform = new SoundTransform(_loc5_.soundTransform.volume + 0.05);
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < m_fadeOutIDs.length)
         {
            _loc4_ = m_fadeOutIDs[_loc3_] as String;
            _loc5_ = m_sounds[_loc4_]["ch"] as SoundChannel;
            if(_loc5_)
            {
               if(_loc5_.soundTransform.volume - 0.05 < 0)
               {
                  Stop(_loc4_);
                  m_fadeOutIDs.splice(_loc3_,1);
                  _loc3_--;
               }
               else
               {
                  _loc5_.soundTransform = new SoundTransform(_loc5_.soundTransform.volume - 0.05);
               }
            }
            _loc3_++;
         }
      }
      
      private static function RestartSound(param1:Event) : void
      {
         var _loc2_:SoundChannel = param1.currentTarget as SoundChannel;
         var _loc3_:String = m_loopedIDs[_loc2_] as String;
         var _loc4_:Sound = m_loopedSounds[_loc2_] as Sound;
         delete m_loopedIDs[_loc2_];
         delete m_loopedSounds[_loc2_];
         _loc2_.stop();
         _loc2_ = _loc4_.play(0,1000000,new SoundTransform(_loc2_.soundTransform.volume));
         m_loopedSounds[_loc2_] = _loc4_;
         m_sounds[_loc3_]["ch"] = _loc2_;
      }
      
      public static function Stop(param1:String) : void
      {
         var _loc2_:SoundChannel = null;
         if(m_sounds[param1] != null && m_sounds[param1]["ch"] != null)
         {
            _loc2_ = m_sounds[param1]["ch"] as SoundChannel;
            m_sounds[param1]["pos"] = _loc2_.position;
            m_loopedSounds[_loc2_] = null;
            m_loopedIDs[_loc2_] = null;
            _loc2_.stop();
            m_sounds[param1] = null;
         }
      }
      
      public static function set_volume(param1:String, param2:Number) : void
      {
         var _loc3_:SoundChannel = null;
         if(m_sounds[param1] != null && m_sounds[param1]["ch"] != null)
         {
            _loc3_ = m_sounds[param1]["ch"] as SoundChannel;
            _loc3_.soundTransform = new SoundTransform(param2);
         }
      }
   }
}
