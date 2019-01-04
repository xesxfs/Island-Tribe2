package logic
{
   import menu.GameScreen;
   
   public class LevelTriggers
   {
       
      
      public function LevelTriggers()
      {
         super();
      }
      
      public static function on_object_repaired(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         GameLevel.unfog_around_object(param1);
         if(GameLevel.current_level_num() == 1)
         {
            if(param1 == "sawmill_broken")
            {
               GameLevel.show_object("sawmill");
            }
            if(param1 == "totem_1" || param1 == "totem_2")
            {
               if(GameLevel.object_repaired("totem_1") && GameLevel.object_repaired("totem_2"))
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_1_TASK_1_3"));
                  GameScreen.update_task_1_status(true);
                  GameLevel.on_win();
               }
               else
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_1_TASK_1_2"));
               }
            }
         }
         else if(GameLevel.current_level_num() == 2)
         {
            if(param1 == "totem_1" || param1 == "totem_2")
            {
               if(GameLevel.object_repaired("totem_1") && GameLevel.object_repaired("totem_2"))
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_1_TASK_1_3"));
                  GameScreen.update_task_1_status(true);
               }
               else
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_1_TASK_1_2"));
               }
            }
            if(param1 == "well_broken")
            {
               GameLevel.show_object("well");
            }
            if(param1 == "lava_3")
            {
               GameLevel.set_node_unpassable("&lava_3");
               GameLevel.show_object("hole");
            }
            if(GameLevel.object_repaired("totem_1") && GameLevel.object_repaired("totem_2") && !GameLevel.object_visible("wasps"))
            {
               GameLevel.on_win();
            }
         }
         else if(GameLevel.current_level_num() == 3)
         {
            if(param1 == "totem_1" || param1 == "totem_2" || param1 == "totem_3")
            {
               _loc2_ = 0;
               if(GameLevel.object_repaired("totem_1"))
               {
                  _loc2_++;
               }
               if(GameLevel.object_repaired("totem_2"))
               {
                  _loc2_++;
               }
               if(GameLevel.object_repaired("totem_3"))
               {
                  _loc2_++;
               }
               if(_loc2_ == 1)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_3_TASK_1_2"));
               }
               if(_loc2_ == 2)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_3_TASK_1_3"));
               }
               if(_loc2_ == 3)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_3_TASK_1_4"));
                  GameScreen.update_task_1_status(true);
               }
            }
            if(param1 == "lava_1")
            {
               GameLevel.show_object("lava_hole_1");
               GameLevel.set_node_unpassable("&lava_1");
            }
            if(param1 == "sawmill_broken")
            {
               GameLevel.show_object("sawmill");
            }
            if(param1 == "well_broken")
            {
               GameLevel.show_object("well");
            }
            if(param1 == "grainfarm_burning")
            {
               GameLevel.show_object("grainfarm_broken");
            }
            if(param1 == "grainfarm_broken")
            {
               GameLevel.show_object("grainfarm");
               GameScreen.update_task_2_status(true);
            }
            if(GameLevel.object_repaired("totem_1") && GameLevel.object_repaired("totem_2") && GameLevel.object_repaired("totem_3") && GameLevel.object_repaired("grainfarm_broken"))
            {
               GameLevel.on_win();
            }
         }
         else if(GameLevel.current_level_num() == 4)
         {
            if(param1 == "totem_1" || param1 == "totem_2" || param1 == "totem_3" || param1 == "totem_4")
            {
               _loc3_ = 0;
               if(GameLevel.object_repaired("totem_1"))
               {
                  _loc3_++;
               }
               if(GameLevel.object_repaired("totem_2"))
               {
                  _loc3_++;
               }
               if(GameLevel.object_repaired("totem_3"))
               {
                  _loc3_++;
               }
               if(GameLevel.object_repaired("totem_4"))
               {
                  _loc3_++;
               }
               if(_loc3_ == 1)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_4_TASK_1_2"));
               }
               if(_loc3_ == 2)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_4_TASK_1_3"));
               }
               if(_loc3_ == 3)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_4_TASK_1_4"));
               }
               if(_loc3_ == 4)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_4_TASK_1_5"));
                  GameScreen.update_task_1_status(true);
               }
            }
            if(param1 == "lava_3")
            {
               GameLevel.set_node_unpassable("&lava_3");
               GameLevel.show_object("lava_3_hole");
            }
            if(param1 == "lavarock_1")
            {
               GameLevel.set_node_unpassable("&lavarock_1");
               GameLevel.show_object("lavarock_1_rock");
            }
            if(param1 == "lavarock_2")
            {
               GameLevel.set_node_unpassable("&lavarock_2");
               GameLevel.show_object("lavarock_2_rock");
            }
            if(param1 == "lavarock_2_rock")
            {
               GameLevel.set_node_unpassable("&lavarock_2");
               GameLevel.show_object("lavarock_2_hole");
            }
            if(param1 == "pyramid_1")
            {
               GameLevel.show_object("pyramid_2");
               GameScreen.update_task_2_text(XMLTranslation.s("LEVEL_4_TASK_2_2"));
            }
            if(param1 == "pyramid_2")
            {
               GameLevel.show_object("pyramid_3");
               GameScreen.update_task_2_text(XMLTranslation.s("LEVEL_4_TASK_2_3"));
            }
            if(param1 == "pyramid_3")
            {
               GameLevel.show_object("pyramid_4");
               GameScreen.update_task_2_text(XMLTranslation.s("LEVEL_4_TASK_2_4"));
               GameScreen.update_task_2_status(true);
            }
            if(param1 == "sawmill_broken")
            {
               GameLevel.show_object("sawmill");
            }
            if(param1 == "well_broken")
            {
               GameLevel.show_object("well");
            }
            if(param1 == "quarry_broken")
            {
               GameLevel.show_object("quarry");
            }
            if(GameLevel.object_repaired("totem_1") && GameLevel.object_repaired("totem_2") && GameLevel.object_repaired("totem_3") && GameLevel.object_repaired("totem_4") && GameLevel.object_repaired("pyramid_3"))
            {
               GameLevel.on_win();
            }
         }
         else if(GameLevel.current_level_num() == 5)
         {
            if(param1 == "beegarden_broken")
            {
               GameLevel.show_object("beegarden");
            }
            if(param1 == "lava_2")
            {
               GameLevel.show_object("lava_2_hole");
               GameLevel.set_node_unpassable("&lava_2");
            }
            if(param1 == "lava_4")
            {
               GameLevel.set_node_unpassable("&lava_4");
               GameLevel.show_object("lava_4_hole");
            }
            if(param1 == "lava_5")
            {
               GameLevel.set_node_unpassable("&lava_5");
               GameLevel.show_object("lava_5_hole");
            }
            if(param1 == "totem_1" || param1 == "totem_2" || param1 == "totem_3")
            {
               _loc2_ = 0;
               if(GameLevel.object_repaired("totem_1"))
               {
                  _loc2_++;
               }
               if(GameLevel.object_repaired("totem_2"))
               {
                  _loc2_++;
               }
               if(GameLevel.object_repaired("totem_3"))
               {
                  _loc2_++;
               }
               if(_loc2_ == 1)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_5_TASK_1_2"));
               }
               if(_loc2_ == 2)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_5_TASK_1_3"));
               }
               if(_loc2_ == 3)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_5_TASK_1_4"));
                  GameScreen.update_task_1_status(true);
                  GameLevel.on_win();
               }
            }
         }
         else if(GameLevel.current_level_num() == 6)
         {
            if(param1 == "beegarden_broken")
            {
               GameLevel.show_object("beegarden");
            }
            if(param1 == "quarry_broken")
            {
               GameLevel.show_object("quarry");
            }
            if(param1 == "lava_1")
            {
               GameLevel.show_object("lava_1_hole");
               GameLevel.set_node_unpassable("&lava_1");
            }
            if(param1 == "lava_2")
            {
               GameLevel.show_object("lava_2_hole");
               GameLevel.set_node_unpassable("&lava_2");
            }
            if(param1 == "lava_3")
            {
               GameLevel.show_object("lava_3_hole");
               GameLevel.set_node_unpassable("&lava_3");
            }
            if(param1 == "lava_4")
            {
               GameLevel.show_object("lava_4_hole");
               GameLevel.set_node_unpassable("&lava_4");
            }
            if(param1 == "totem_1" || param1 == "totem_2" || param1 == "totem_3" || param1 == "totem_4")
            {
               _loc2_ = 0;
               if(GameLevel.object_repaired("totem_1"))
               {
                  _loc2_++;
               }
               if(GameLevel.object_repaired("totem_2"))
               {
                  _loc2_++;
               }
               if(GameLevel.object_repaired("totem_3"))
               {
                  _loc2_++;
               }
               if(GameLevel.object_repaired("totem_4"))
               {
                  _loc2_++;
               }
               if(_loc2_ == 1)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_6_TASK_1_2"));
               }
               if(_loc2_ == 2)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_6_TASK_1_3"));
               }
               if(_loc2_ == 3)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_6_TASK_1_4"));
               }
               if(_loc2_ == 4)
               {
                  GameScreen.update_task_1_text(XMLTranslation.s("LEVEL_6_TASK_1_5"));
                  GameScreen.update_task_1_status(true);
                  GameLevel.on_win();
               }
            }
         }
      }
      
      public static function on_object_destroyed(param1:String) : void
      {
         GameLevel.unfog_around_object(param1);
         if(GameLevel.current_level_num() == 2)
         {
            if(param1 == "wasps")
            {
               GameScreen.update_task_2_status(true);
            }
         }
      }
      
      public static function on_object_picked_up(param1:String) : void
      {
         GameLevel.unfog_around_object(param1);
         if(GameLevel.current_level_num() == 1)
         {
         }
      }
      
      public static function on_object_upgraded(param1:String) : void
      {
         if(param1 == "camp")
         {
            GameLevel.add_worker();
         }
         if(GameLevel.current_level_num() == 1)
         {
         }
      }
   }
}
