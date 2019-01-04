package
{
   import flash.net.SharedObject;
   import menu.WorldMap;
   
   public class Save
   {
      
      private static var m_this:Save = null;
      
      private static var m_data:SharedObject = null;
       
      
      public function Save()
      {
         super();
         if(m_this != null)
         {
         }
         m_this = this;
      }
      
      public static function init() : void
      {
         new Save();
         m_data = SharedObject.getLocal("it2.realore.com");
         if(m_data.data.users == undefined || m_data.data.users == null)
         {
            m_data.data.users = new Array();
            m_data.data.current = "";
            m_data.data.scores = new Array();
            m_data.data.scores.push([XMLTranslation.s("MENU_SCORES_NAME_1"),"100000"]);
            m_data.data.scores.push([XMLTranslation.s("MENU_SCORES_NAME_2"),"10000"]);
            m_data.data.scores.push([XMLTranslation.s("MENU_SCORES_NAME_3"),"1000"]);
            m_data.data.scores.push([XMLTranslation.s("MENU_SCORES_NAME_4"),"1000"]);
            m_data.data.scores.push([XMLTranslation.s("MENU_SCORES_NAME_5"),"100"]);
            m_data.data.scores.push([XMLTranslation.s("MENU_SCORES_NAME_6"),"10"]);
            m_data.data.music_level = 0.75;
            m_data.data.sound_level = 1;
            m_data.flush();
         }
      }
      
      public static function num_users() : int
      {
         return m_data.data.users.length;
      }
      
      public static function create_user(param1:String) : void
      {
         var _loc2_:Object = null;
         if(!get_user(param1))
         {
            _loc2_ = new Object();
            _loc2_.name = param1;
            m_data.data.users.push(_loc2_);
            _loc2_.world_map_level_status = [1,0,0,0,0,0];
            _loc2_.world_map_time = [0,0,0,0,0,0];
            _loc2_.world_map_scores = [0,0,0,0,0,0];
            _loc2_.world_map_artifacts_callected = [0,0,0,0,0,0];
            _loc2_.world_map_artifacts_number = [1,1,1,1,1,1];
            m_data.flush();
         }
      }
      
      public static function delete_user(param1:String) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < m_data.data.users.length)
         {
            _loc3_ = m_data.data.users[_loc2_];
            if(_loc3_ && _loc3_.name == param1)
            {
               delete Save[m_data.data.users.splice(_loc2_,1)];
            }
            _loc2_++;
         }
      }
      
      public static function get_user(param1:String) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in m_data.data.users)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function get_current_user() : Object
      {
         return get_user(current_user_name());
      }
      
      public static function users_list() : Array
      {
         return m_data.data.users;
      }
      
      public static function current_user_name() : String
      {
         return m_data.data.current;
      }
      
      public static function select_user(param1:String) : void
      {
         if(get_user(param1))
         {
            m_data.data.current = param1;
            m_data.flush();
         }
      }
      
      public static function num_scores() : int
      {
         return m_data.data.scores.length;
      }
      
      public static function scores_name(param1:int) : String
      {
         return m_data.data.scores[param1][0];
      }
      
      public static function scores_points(param1:int) : int
      {
         return m_data.data.scores[param1][1];
      }
      
      public static function save_music_level(param1:Number) : void
      {
         m_data.data.music_level = param1;
         m_data.flush();
      }
      
      public static function save_sound_level(param1:Number) : void
      {
         m_data.data.sound_level = param1;
         m_data.flush();
      }
      
      public static function get_music_level() : Number
      {
         return m_data.data.music_level;
      }
      
      public static function get_sound_level() : Number
      {
         return m_data.data.sound_level;
      }
      
      public static function unlock_level(param1:int) : void
      {
         if(get_current_user().world_map_level_status[param1] == 0)
         {
            get_current_user().world_map_level_status[param1] = 1;
            WorldMap.set_level_green(param1);
            m_data.flush();
         }
      }
      
      public static function win_level(param1:int) : void
      {
         get_current_user().world_map_level_status[param1] = 1;
         m_data.flush();
      }
      
      public static function extra_win_level(param1:int) : void
      {
         get_current_user().world_map_level_status[param1] = 2;
         WorldMap.set_level_gold(param1);
         m_data.flush();
      }
      
      public static function unlocked_level(param1:int) : Boolean
      {
         return get_current_user().world_map_level_status[param1] > 0;
      }
      
      public static function won_level(param1:int) : Boolean
      {
         return get_current_user().world_map_level_status[param1] == 1;
      }
      
      public static function extra_won_level(param1:int) : Boolean
      {
         return get_current_user().world_map_level_status[param1] == 2;
      }
      
      public static function level_get_time(param1:int) : int
      {
         return get_current_user().world_map_time[param1];
      }
      
      public static function level_set_time(param1:int, param2:int) : void
      {
         get_current_user().world_map_time[param1] = param2;
      }
      
      public static function level_get_scores(param1:int) : int
      {
         return get_current_user().world_map_scores[param1];
      }
      
      public static function level_set_scores(param1:int, param2:int) : void
      {
         get_current_user().world_map_scores[param1] = param2;
      }
      
      public static function level_get_artifacts_collected(param1:int) : int
      {
         return get_current_user().world_map_artifacts_callected[param1];
      }
      
      public static function level_set_artifacts_collected(param1:int, param2:int) : void
      {
         get_current_user().world_map_artifacts_callected[param1] = param2;
      }
      
      public static function level_get_artifacts_number(param1:int) : int
      {
         return get_current_user().world_map_artifacts_number[param1];
      }
      
      public static function level_set_artifacts_number(param1:int, param2:int) : void
      {
         get_current_user().world_map_artifacts_number[param1] = param2;
      }
      
      public static function new_total_score(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < m_data.data.scores.length)
         {
            if(param1 >= m_data.data.scores[_loc2_][1])
            {
               m_data.data.scores[_loc2_][0] = current_user_name();
               m_data.data.scores[_loc2_][1] = param1;
               return;
            }
            _loc2_++;
         }
      }
   }
}
