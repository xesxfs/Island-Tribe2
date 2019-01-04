package logic
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import logic.buildings.BaseBuilding;
   import logic.buildings.BeeGarden;
   import logic.buildings.Camp;
   import logic.buildings.GrainFarm;
   import logic.buildings.Quarry;
   import logic.buildings.SawMill;
   import logic.buildings.Well;
   import logic.dynamic_objects.AzPyramid_1;
   import logic.dynamic_objects.AzPyramid_2;
   import logic.dynamic_objects.AzPyramid_3;
   import logic.dynamic_objects.AzPyramid_4;
   import logic.dynamic_objects.BeeGarden_Broken;
   import logic.dynamic_objects.GrainFarm_Broken;
   import logic.dynamic_objects.GrainFarm_Burning;
   import logic.dynamic_objects.Quarry_Broken;
   import logic.dynamic_objects.RepairableObject;
   import logic.dynamic_objects.RoadBoar_1;
   import logic.dynamic_objects.RoadBoar_2;
   import logic.dynamic_objects.RoadHole;
   import logic.dynamic_objects.RoadHoleRock;
   import logic.dynamic_objects.RoadHoleS;
   import logic.dynamic_objects.RoadLava;
   import logic.dynamic_objects.RoadLavaRock;
   import logic.dynamic_objects.RoadPorcupine;
   import logic.dynamic_objects.RoadWasps;
   import logic.dynamic_objects.SawMill_Broken;
   import logic.dynamic_objects.StoneBridgeD_Broken;
   import logic.dynamic_objects.StoneBridgeH_Broken;
   import logic.dynamic_objects.StoneBridgeV_Broken;
   import logic.dynamic_objects.TotemStone_Broken;
   import logic.dynamic_objects.TotemWood_Broken;
   import logic.dynamic_objects.Well_Broken;
   import logic.dynamic_objects.WoodBridgeD_Broken;
   import logic.dynamic_objects.WoodBridgeH_Broken;
   import logic.dynamic_objects.WoodBridgeV_Broken;
   import logic.pf.PFGraph;
   import logic.pf.PFNode;
   import logic.resources.DestroyableObject;
   import logic.resources.ProdResourceFactory;
   import logic.resources.ResDiamondP;
   import logic.resources.ResDiamondSmallB;
   import logic.resources.ResDiamondSmallP;
   import logic.resources.ResDiamondSmallY;
   import logic.resources.ResDiamondY;
   import logic.resources.ResGrain;
   import logic.resources.ResHoney;
   import logic.resources.ResMilk;
   import logic.resources.ResStone;
   import logic.resources.ResType;
   import logic.resources.ResWater;
   import logic.resources.ResWood;
   import logic.resources.ResWoodLogs_1;
   import logic.resources.ResWoodLogs_2;
   import logic.resources.RoadRocks_1;
   import logic.resources.RoadRocks_2;
   import menu.GameScreen;
   import menu.GameScreen_InfoWnd;
   import menu.LevelFinishing;
   
   public class GameLevel extends Sprite
   {
      
      private static var m_this:GameLevel = null;
      
      private static var m_num:int = -1;
      
      private static var m_back:Bitmap = null;
      
      private static var m_graph:PFGraph = null;
      
      private static var m_objects:Dictionary = null;
      
      private static var m_objects_layer:Sprite = null;
      
      private static var m_workers:Array = null;
      
      private static var m_workers_layer:Sprite = null;
      
      private static var m_pbars_layer:Sprite = null;
      
      private static var m_infownd:GameScreen_InfoWnd = null;
      
      private static var m_infownd_layer:Sprite = null;
      
      private static var m_resources:Array = null;
      
      private static var m_paused:Boolean = false;
      
      private static var m_time_cur:Number = 0;
      
      private static var m_time_max:Number = 0;
      
      private static var m_tasks_queue:Array = null;
      
      private static var m_fog:WarFog = null;
      
      private static var m_explorer:ExplorerGuy = null;
      
      private static var m_explorer_layer:Sprite = null;
      
      private static var m_artefact:Artefact = null;
       
      
      public function GameLevel()
      {
         super();
         if(m_this != null)
         {
         }
         m_this = this;
         this.addEventListener(Event.ADDED_TO_STAGE,on_added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,on_removed);
         this.addEventListener(MouseEvent.CLICK,on_click);
      }
      
      public static function get inst() : GameLevel
      {
         return m_this;
      }
      
      public static function init() : GameLevel
      {
         new GameLevel();
         m_this.graphics.clear();
         m_this.graphics.beginFill(17408,1);
         m_this.graphics.drawRect(0,0,640,480);
         m_this.graphics.endFill();
         m_back = new Bitmap();
         m_this.addChild(m_back);
         m_graph = new PFGraph();
         m_graph.redraw_canvas();
         m_objects = new Dictionary();
         m_objects_layer = new Sprite();
         m_this.addChild(m_objects_layer);
         m_workers = new Array();
         m_workers_layer = new Sprite();
         m_workers_layer.mouseChildren = false;
         m_workers_layer.mouseEnabled = false;
         m_this.addChild(m_workers_layer);
         m_fog = new WarFog();
         m_this.addChild(m_fog);
         m_pbars_layer = new Sprite();
         m_this.addChild(m_pbars_layer);
         m_infownd = new GameScreen_InfoWnd();
         m_infownd_layer = new Sprite();
         m_infownd_layer.addChild(m_infownd);
         m_this.addChild(m_infownd_layer);
         m_this.addChild(m_infownd);
         m_infownd_layer.mouseEnabled = false;
         m_infownd_layer.mouseChildren = false;
         m_explorer_layer = new Sprite();
         m_explorer = new ExplorerGuy(m_explorer_layer);
         m_this.addChild(m_explorer_layer);
         m_resources = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < ResType.LVLRES_LAST)
         {
            m_resources[_loc1_] = -1;
            _loc1_++;
         }
         if(m_graph.m_canvas)
         {
            m_this.addChild(m_graph.m_canvas);
         }
         return m_this;
      }
      
      public static function load_step_1(param1:int) : void
      {
         m_num = param1;
         switch(param1)
         {
            case 1:
               m_back.bitmapData = new art_map_1();
               break;
            case 2:
               m_back.bitmapData = new art_map_2();
               break;
            case 3:
               m_back.bitmapData = new art_map_3();
               break;
            case 4:
               m_back.bitmapData = new art_map_4();
               break;
            case 5:
               m_back.bitmapData = new art_map_5();
               break;
            case 6:
               m_back.bitmapData = new art_map_6();
         }
         m_graph.clear();
         while(m_objects_layer.numChildren)
         {
            m_objects_layer.removeChildAt(0);
         }
         m_objects = new Dictionary();
         while(m_pbars_layer && m_pbars_layer.numChildren)
         {
            m_pbars_layer.removeChildAt(0);
         }
      }
      
      public static function load_step_2() : void
      {
         var _loc1_:LevelObject = null;
         var _loc2_:* = null;
         var _loc3_:LevelObject = null;
         m_fog.reset();
         for each(_loc1_ in m_objects)
         {
            _loc1_.hide();
         }
         m_objects = new Dictionary();
         if(m_num == 1)
         {
            m_artefact = new Artefact(m_objects_layer,new art_artefact_1(),147,75);
            m_objects["camp"] = new Camp(m_objects_layer,285,280,"&camp",1,new Rectangle(0,0,200,200));
            m_objects["sawmill_broken"] = new SawMill_Broken(m_objects_layer,270,90,"&sawmill",new Rectangle(0,0,450,370));
            m_objects["sawmill"] = new SawMill(m_objects_layer,270,90,"&sawmill",1,1,true);
            m_objects["wood_1"] = new ResWood(m_objects_layer,310,140,4,"&wood_1");
            m_objects["wood_2"] = new ResWood(m_objects_layer,496,113,1,"&wood_2");
            m_objects["road_hole"] = new RoadHole(m_objects_layer,460,88,"&road_hole",false,new Rectangle(0,0,120,120));
            m_objects["wood_3"] = new ResWood(m_objects_layer,520,135,1,"&wood_3",new Rectangle(0,0,170,210));
            m_objects["bridge_broken"] = new WoodBridgeV_Broken(m_objects_layer,545,195,-12,"&bridge",new Rectangle(0,0,550,1000));
            m_objects["diamond_1"] = new ResDiamondSmallP(m_objects_layer,360,290,300,"&diamond_1");
            m_objects["diamond_2"] = new ResDiamondSmallB(m_objects_layer,575,230,300,"&diamond_2");
            m_objects["totem_1"] = new TotemWood_Broken(m_objects_layer,95,115,"&totem_1");
            m_objects["totem_2"] = new TotemWood_Broken(m_objects_layer,465,415,"&totem_2");
            m_graph.add_node(106,122,"&totem_1");
            m_graph.add_node(145,133);
            m_graph.add_node(180,148);
            m_graph.add_node(209,164);
            m_graph.add_node(244,169);
            m_graph.add_node(278,164);
            m_graph.add_node(304,150,"&wood_1",false);
            m_graph.add_node(325,118);
            m_graph.add_node(347,100);
            m_graph.add_node(373,87);
            m_graph.add_node(403,80);
            m_graph.add_node(429,81);
            m_graph.add_node(460,89,"&road_hole",false);
            m_graph.add_node(481,101);
            m_graph.add_node(499,116,"&wood_2",false);
            m_graph.add_node(520,139,"&wood_3",false);
            m_graph.add_node(537,171);
            m_graph.add_node(543,194,"&bridge",false);
            m_graph.add_node(546,218);
            m_graph.add_node(549,232);
            m_graph.add_node(571,232,"&diamond_2");
            m_graph.add_node(549,252);
            m_graph.add_node(553,281);
            m_graph.add_node(541,308);
            m_graph.add_node(532,338);
            m_graph.add_node(530,369);
            m_graph.add_node(520,397);
            m_graph.add_node(502,410);
            m_graph.add_node(476,414,"&totem_2");
            m_graph.add_node(294,123,"&sawmill");
            m_graph.add_node(314,171);
            m_graph.add_node(331,186);
            m_graph.add_node(344,209);
            m_graph.add_node(346,234);
            m_graph.add_node(346,257);
            m_graph.add_node(339,288);
            m_graph.add_node(357,292,"&diamond_1");
            m_graph.add_node(333,308);
            m_graph.add_node(311,321,"&camp");
            m_graph.add_link(0,1);
            m_graph.add_link(1,2);
            m_graph.add_link(2,3);
            m_graph.add_link(3,4);
            m_graph.add_link(4,5);
            m_graph.add_link(5,6);
            m_graph.add_link(6,7);
            m_graph.add_link(6,29);
            m_graph.add_link(6,30);
            m_graph.add_link(7,8);
            m_graph.add_link(8,9);
            m_graph.add_link(9,10);
            m_graph.add_link(10,11);
            m_graph.add_link(11,12);
            m_graph.add_link(12,13);
            m_graph.add_link(13,14);
            m_graph.add_link(14,15);
            m_graph.add_link(15,16);
            m_graph.add_link(16,17);
            m_graph.add_link(17,18);
            m_graph.add_link(18,19);
            m_graph.add_link(19,20);
            m_graph.add_link(19,21);
            m_graph.add_link(21,22);
            m_graph.add_link(22,23);
            m_graph.add_link(23,24);
            m_graph.add_link(24,25);
            m_graph.add_link(25,26);
            m_graph.add_link(26,27);
            m_graph.add_link(27,28);
            m_graph.add_link(30,31);
            m_graph.add_link(31,32);
            m_graph.add_link(32,33);
            m_graph.add_link(33,34);
            m_graph.add_link(34,35);
            m_graph.add_link(35,36);
            m_graph.add_link(35,37);
            m_graph.add_link(37,38);
            unfog_region(254,229,341,341);
            unfog_region(104,314,420,420);
         }
         else if(m_num == 2)
         {
            m_artefact = new Artefact(m_objects_layer,new art_artefact_2(),169,381);
            m_objects["camp"] = new Camp(m_objects_layer,270,192,"&camp",1,new Rectangle(0,0,270,270));
            m_objects["bridge_1"] = new WoodBridgeV_Broken(m_objects_layer,427,183,0,"&bridge_1",new Rectangle(0,0,150,150));
            m_objects["bridge_2"] = new WoodBridgeD_Broken(m_objects_layer,410,305,0,"&bridge_2",new Rectangle(0,0,150,150));
            m_objects["bridge_3"] = new WoodBridgeH_Broken(m_objects_layer,205,345,0,"&bridge_3",new Rectangle(0,0,150,150));
            m_objects["bridge_4"] = new StoneBridgeD_Broken(m_objects_layer,123,197,0,"&bridge_4",new Rectangle(0,0,212,150));
            m_objects["logs_1"] = new ResWoodLogs_2(m_objects_layer,153,220,2,"&logs_1");
            m_objects["stone_1"] = new ResStone(m_objects_layer,187,223,1,"&stone_1");
            m_objects["diamond_1"] = new ResDiamondSmallP(m_objects_layer,209,247,300,"&diamond_1");
            m_objects["logs_2"] = new ResWoodLogs_1(m_objects_layer,361,262,1,"&logs_2");
            m_objects["logs_3"] = new ResWoodLogs_1(m_objects_layer,267,315,1,"&logs_3",new Rectangle(-20,20,210,190));
            m_objects["wood_1"] = new ResWood(m_objects_layer,323,272,1,"&wood_1");
            m_objects["lava_1"] = new RoadLava(m_objects_layer,291,293,"&lava_1");
            m_objects["honey_1"] = new ResHoney(m_objects_layer,384,247,1,"&honey_1");
            m_objects["water_1"] = new ResWater(m_objects_layer,411,225,1,"&water_1");
            m_objects["wood_2"] = new ResWood(m_objects_layer,420,149,1,"&wood_2",new Rectangle(-20,-30,180,210));
            m_objects["lava_2"] = new RoadLava(m_objects_layer,167,344,"&lava_2");
            m_objects["honey_2"] = new ResHoney(m_objects_layer,138,342,1,"&honey_2");
            m_objects["totem_1"] = new TotemWood_Broken(m_objects_layer,346,436,"&totem_1",new Rectangle(0,0,1000,374));
            m_objects["totem_2"] = new TotemWood_Broken(m_objects_layer,138,139,"&totem_2",new Rectangle(0,0,750,400));
            m_objects["logs_4"] = new ResWoodLogs_2(m_objects_layer,436,345,2,"&logs_4");
            m_objects["stone_2"] = new ResStone(m_objects_layer,434,375,1,"&stone_2");
            m_objects["lava_3"] = new RoadLava(m_objects_layer,422,404,"&lava_3",new Rectangle(0,0,240,180));
            m_objects["hole"] = new RoadHole(m_objects_layer,422,404,"&lava_3",true,new Rectangle(0,0,200,200));
            m_objects["lava_4"] = new RoadLava(m_objects_layer,106,170,"&lava_4");
            m_objects["sawmill"] = new SawMill(m_objects_layer,100,290,"&sawmill",2,1);
            m_objects["well"] = new Well(m_objects_layer,380,95,"&well",1,1,true);
            m_objects["well_broken"] = new Well_Broken(m_objects_layer,380,95,"&well",new Rectangle(0,0,624,624));
            m_objects["wasps"] = new RoadWasps(m_objects_layer,382,280,"&wasps");
            m_graph.add_node(283,229,"&camp");
            m_graph.add_node(101,320,"&sawmill");
            m_graph.add_node(384,126,"&well");
            m_graph.add_node(315,226);
            m_graph.add_node(328,233);
            m_graph.add_node(343,245);
            m_graph.add_node(357,262,"&logs_2",false);
            m_graph.add_node(378,251,"&honey_1",false);
            m_graph.add_node(397,239);
            m_graph.add_node(411,226,"&water_1",false);
            m_graph.add_node(422,208);
            m_graph.add_node(425,200,"&bridge_1",false);
            m_graph.add_node(421,150,"&wood_2",false);
            m_graph.add_node(409,131);
            m_graph.add_node(338,268);
            m_graph.add_node(322,273,"&wood_1",false);
            m_graph.add_node(304,282);
            m_graph.add_node(290,292,"&lava_1",false);
            m_graph.add_node(265,315,"&logs_3",false);
            m_graph.add_node(243,332);
            m_graph.add_node(221,342);
            m_graph.add_node(217,342,"&bridge_3",false);
            m_graph.add_node(184,344);
            m_graph.add_node(162,344,"&lava_2",false);
            m_graph.add_node(135,342,"&honey_2",false);
            m_graph.add_node(111,333);
            m_graph.add_node(372,276,"&wasps",false);
            m_graph.add_node(393,290);
            m_graph.add_node(398,295,"&bridge_2",false);
            m_graph.add_node(423,323);
            m_graph.add_node(431,331);
            m_graph.add_node(433,346,"&logs_4",false);
            m_graph.add_node(436,361);
            m_graph.add_node(435,378,"&stone_2",false);
            m_graph.add_node(427,394);
            m_graph.add_node(419,402,"&lava_3",false);
            m_graph.add_node(404,422);
            m_graph.add_node(379,428);
            m_graph.add_node(361,431,"&totem_1",false);
            m_graph.add_node(252,225);
            m_graph.add_node(222,221);
            m_graph.add_node(189,224,"&stone_1",false);
            m_graph.add_node(152,220,"&logs_1",false);
            m_graph.add_node(133,203,"&bridge_4",false);
            m_graph.add_node(122,187);
            m_graph.add_node(105,182);
            m_graph.add_node(104,169,"&lava_4",false);
            m_graph.add_node(122,147,"&totem_2",false);
            m_graph.add_node(207,245,"&diamond_1",false);
            m_graph.add_node(233,241);
            m_graph.add_node(258,242);
            m_graph.add_node(285,248);
            m_graph.add_node(308,257);
            m_graph.add_node(324,249);
            m_graph.add_link(0,3);
            m_graph.add_link(0,39);
            m_graph.add_link(0,51);
            m_graph.add_link(1,25);
            m_graph.add_link(2,13);
            m_graph.add_link(3,4);
            m_graph.add_link(4,5);
            m_graph.add_link(4,53);
            m_graph.add_link(5,6);
            m_graph.add_link(6,7);
            m_graph.add_link(6,14);
            m_graph.add_link(6,26);
            m_graph.add_link(7,8);
            m_graph.add_link(8,9);
            m_graph.add_link(9,10);
            m_graph.add_link(10,11);
            m_graph.add_link(11,12);
            m_graph.add_link(12,13);
            m_graph.add_link(14,15);
            m_graph.add_link(15,16);
            m_graph.add_link(16,17);
            m_graph.add_link(17,18);
            m_graph.add_link(18,19);
            m_graph.add_link(19,20);
            m_graph.add_link(20,21);
            m_graph.add_link(21,22);
            m_graph.add_link(22,23);
            m_graph.add_link(23,24);
            m_graph.add_link(24,25);
            m_graph.add_link(26,27);
            m_graph.add_link(27,28);
            m_graph.add_link(28,29);
            m_graph.add_link(29,30);
            m_graph.add_link(30,31);
            m_graph.add_link(31,32);
            m_graph.add_link(32,33);
            m_graph.add_link(33,34);
            m_graph.add_link(34,35);
            m_graph.add_link(35,36);
            m_graph.add_link(36,37);
            m_graph.add_link(37,38);
            m_graph.add_link(39,40);
            m_graph.add_link(39,50);
            m_graph.add_link(40,41);
            m_graph.add_link(40,49);
            m_graph.add_link(41,42);
            m_graph.add_link(41,48);
            m_graph.add_link(42,43);
            m_graph.add_link(43,44);
            m_graph.add_link(44,45);
            m_graph.add_link(45,46);
            m_graph.add_link(46,47);
            m_graph.add_link(48,49);
            m_graph.add_link(49,50);
            m_graph.add_link(50,51);
            m_graph.add_link(51,52);
            m_graph.add_link(52,53);
            m_graph.add_link(53,5);
         }
         else if(m_num == 3)
         {
            m_artefact = new Artefact(m_objects_layer,new art_artefact_3(),584,278);
            m_objects["bridge_1"] = new WoodBridgeH_Broken(m_objects_layer,292,308,-20,"&bridge_1",new Rectangle(0,0,200,200));
            m_objects["bridge_2"] = new WoodBridgeV_Broken(m_objects_layer,397,150,0,"&bridge_2",new Rectangle(0,0,200,200));
            m_objects["bridge_3"] = new WoodBridgeV_Broken(m_objects_layer,542,176,20,"&bridge_3",new Rectangle(0,0,200,200));
            m_objects["bridge_4"] = new StoneBridgeD_Broken(m_objects_layer,552,336,10,"&bridge_4",new Rectangle(0,0,290,290));
            m_objects["bridge_5"] = new WoodBridgeH_Broken(m_objects_layer,331,71,0,"&bridge_5",new Rectangle(0,0,200,200));
            m_objects["camp"] = new Camp(m_objects_layer,180,355,"&camp",2,new Rectangle(0,0,270,270));
            m_objects["sawmill_broken"] = new SawMill_Broken(m_objects_layer,306,205,"&sawmill",new Rectangle(0,0,250,250));
            m_objects["sawmill"] = new SawMill(m_objects_layer,306,205,"&sawmill",2,1,true);
            m_objects["well_broken"] = new Well_Broken(m_objects_layer,585,218,"&well",new Rectangle(0,0,250,250));
            m_objects["well"] = new Well(m_objects_layer,585,218,"&well",2,1,true);
            m_objects["grainfarm"] = new GrainFarm(m_objects_layer,494,68,"&grainfarm",1,true);
            m_objects["grainfarm_broken"] = new GrainFarm_Broken(m_objects_layer,494,68,"&grainfarm",true,new Rectangle(0,0,250,250));
            m_objects["grainfarm_burning"] = new GrainFarm_Burning(m_objects_layer,494,68,"&grainfarm",new Rectangle(0,0,250,250));
            m_objects["water_1"] = new ResWater(m_objects_layer,194,438,1,"&water_1");
            m_objects["water_2"] = new ResWater(m_objects_layer,402,199,1,"&water_2");
            m_objects["water_3"] = new ResWater(m_objects_layer,264,313,1,"&water_3");
            m_objects["wood_1"] = new ResWood(m_objects_layer,274,340,1,"&wood_1");
            m_objects["wood_2"] = new ResWood(m_objects_layer,318,262,1,"&wood_2",new Rectangle(0,0,180,220));
            m_objects["wood_3"] = new ResWood(m_objects_layer,443,220,1,"&wood_3");
            m_objects["wood_4"] = new ResWood(m_objects_layer,463,240,1,"&wood_4");
            m_objects["wood_5"] = new ResWood(m_objects_layer,274,368,1,"&wood_5");
            m_objects["stone_2"] = new ResStone(m_objects_layer,149,446,1,"&stone_2");
            m_objects["stone_3"] = new ResStone(m_objects_layer,107,314,1,"&stone_3");
            m_objects["stone_4"] = new ResStone(m_objects_layer,70,367,1,"&stone_4");
            m_objects["stone_5"] = new ResStone(m_objects_layer,84,404,1,"&stone_5");
            m_objects["stone_6"] = new ResStone(m_objects_layer,421,246,1,"&stone_6");
            m_objects["stone_7"] = new ResStone(m_objects_layer,426,60,1,"&stone_7",new Rectangle(40,0,200,190));
            m_objects["logs_1"] = new ResWoodLogs_1(m_objects_layer,220,308,1,"&logs_1");
            m_objects["logs_2"] = new ResWoodLogs_2(m_objects_layer,333,288,1,"&logs_2");
            m_objects["diamond_1"] = new ResDiamondSmallP(m_objects_layer,281,252,300,"&diamond_1");
            m_objects["diamond_2"] = new ResDiamondSmallB(m_objects_layer,382,317,300,"&diamond_2");
            m_objects["diamond_3"] = new ResDiamondSmallB(m_objects_layer,552,261,300,"&diamond_3");
            m_objects["diamond_4"] = new ResDiamondSmallP(m_objects_layer,362,93,300,"&diamond_4");
            m_objects["boar_1"] = new RoadBoar_1(m_objects_layer,106,432,"&boar_1");
            m_objects["boar_2"] = new RoadBoar_2(m_objects_layer,77,333,"&boar_2");
            m_objects["boar_3"] = new RoadBoar_1(m_objects_layer,528,299,"&boar_3");
            m_objects["boar_4"] = new RoadBoar_1(m_objects_layer,548,105,"&boar_4");
            m_objects["lava_1"] = new RoadLava(m_objects_layer,357,328,"&lava_1");
            m_objects["lava_2"] = new RoadLava(m_objects_layer,411,225,"&lava_2");
            m_objects["lava_3"] = new RoadLava(m_objects_layer,520,268,"&lava_3");
            m_objects["lava_4"] = new RoadLava(m_objects_layer,392,75,"&lava_4");
            m_objects["lava_hole_1"] = new RoadHole(m_objects_layer,357,328,"&lava_1",true);
            m_objects["hole_1"] = new RoadHole(m_objects_layer,374,271,"&hole_1");
            m_objects["hole_2"] = new RoadHole(m_objects_layer,392,106,"&hole_2");
            m_objects["honey_1"] = new ResHoney(m_objects_layer,265,400,1,"&honey_1");
            m_objects["honey_2"] = new ResHoney(m_objects_layer,525,212,1,"&honey_2");
            m_objects["honey_3"] = new ResHoney(m_objects_layer,364,67,1,"&honey_3");
            m_objects["honey_4"] = new ResHoney(m_objects_layer,554,138,1,"&honey_4");
            m_objects["totem_1"] = new TotemWood_Broken(m_objects_layer,400,365,"&totem_1",new Rectangle(0,0,250,380));
            m_objects["totem_2"] = new TotemWood_Broken(m_objects_layer,275,74,"&totem_2",new Rectangle(0,0,880,625));
            m_objects["totem_3"] = new TotemStone_Broken(m_objects_layer,590,395,"&totem_3",new Rectangle(0,0,780,780));
            m_objects["wasps_1"] = new RoadWasps(m_objects_layer,230,423,"&wasps_1");
            m_objects["wasps_2"] = new RoadWasps(m_objects_layer,146,310,"&wasps_2");
            m_objects["rocks_1"] = new RoadRocks_1(m_objects_layer,519,239,1,"&rocks_1",new Rectangle(30,0,180,180));
            m_graph.add_node(224,338,"&camp");
            m_graph.add_node(264,313,"&water_3",false);
            m_graph.add_node(275,341,"&wood_1",false);
            m_graph.add_node(275,370,"&wood_5",false);
            m_graph.add_node(266,402,"&honey_1",false);
            m_graph.add_node(230,423,"&wasps_1",false);
            m_graph.add_node(194,438,"&water_1",false);
            m_graph.add_node(149,446,"&stone_2",false);
            m_graph.add_node(106,433,"&boar_1",false);
            m_graph.add_node(84,406,"&stone_5",false);
            m_graph.add_node(71,369,"&stone_4",false);
            m_graph.add_node(76,333,"&boar_2",false);
            m_graph.add_node(107,314,"&stone_3",false);
            m_graph.add_node(146,310,"&wasps_2",false);
            m_graph.add_node(185,315);
            m_graph.add_node(219,315,"&logs_1",false);
            m_graph.add_node(246,308);
            m_graph.add_node(271,308,"&bridge_1",false);
            m_graph.add_node(331,287,"&logs_2",false);
            m_graph.add_node(318,263,"&wood_2",false);
            m_graph.add_node(298,244);
            m_graph.add_node(297,232,"&sawmill");
            m_graph.add_node(280,252,"&diamond_1",false);
            m_graph.add_node(356,327,"&lava_1",false);
            m_graph.add_node(382,322,"&diamond_2",false);
            m_graph.add_node(381,356,"&totem_1",false);
            m_graph.add_node(374,271,"&hole_1",false);
            m_graph.add_node(407,262);
            m_graph.add_node(421,245,"&stone_6",false);
            m_graph.add_node(461,241,"&wood_4",false);
            m_graph.add_node(517,238,"&rocks_1",false);
            m_graph.add_node(409,224,"&lava_2",false);
            m_graph.add_node(401,201,"&water_2",false);
            m_graph.add_node(395,168,"&bridge_2",false);
            m_graph.add_node(393,106,"&hole_2",false);
            m_graph.add_node(391,74,"&lava_4",false);
            m_graph.add_node(424,60,"&stone_7",false);
            m_graph.add_node(363,69,"&honey_3",false);
            m_graph.add_node(351,69,"&bridge_5",false);
            m_graph.add_node(297,69,"&totem_2",false);
            m_graph.add_node(524,215,"&honey_2",false);
            m_graph.add_node(532,193,"&bridge_3",false);
            m_graph.add_node(553,142,"&honey_4",false);
            m_graph.add_node(549,108,"&boar_4",false);
            m_graph.add_node(519,270,"&lava_3",false);
            m_graph.add_node(530,303,"&boar_3",false);
            m_graph.add_node(553,265,"&diamond_3",false);
            m_graph.add_node(547,240);
            m_graph.add_node(570,248,"&well");
            m_graph.add_node(535,317,"&bridge_4",false);
            m_graph.add_node(549,323);
            m_graph.add_node(560,334);
            m_graph.add_node(567,356);
            m_graph.add_node(574,380,"&totem_3",false);
            m_graph.add_node(362,94,"&diamond_4",false);
            m_graph.add_node(439,80);
            m_graph.add_node(462,96,"&grainfarm");
            m_graph.add_node(490,107);
            m_graph.add_node(522,108);
            m_graph.add_node(442,223,"&wood_3",false);
            m_graph.add_link(0,1);
            m_graph.add_link(1,2);
            m_graph.add_link(1,17);
            m_graph.add_link(2,3);
            m_graph.add_link(3,4);
            m_graph.add_link(4,5);
            m_graph.add_link(5,6);
            m_graph.add_link(6,7);
            m_graph.add_link(7,8);
            m_graph.add_link(8,9);
            m_graph.add_link(9,10);
            m_graph.add_link(10,11);
            m_graph.add_link(11,12);
            m_graph.add_link(12,13);
            m_graph.add_link(13,14);
            m_graph.add_link(14,15);
            m_graph.add_link(15,16);
            m_graph.add_link(16,1);
            m_graph.add_link(17,18);
            m_graph.add_link(18,26);
            m_graph.add_link(26,27);
            m_graph.add_link(27,28);
            m_graph.add_link(28,29);
            m_graph.add_link(29,30);
            m_graph.add_link(30,40);
            m_graph.add_link(40,41);
            m_graph.add_link(41,42);
            m_graph.add_link(42,43);
            m_graph.add_link(43,58);
            m_graph.add_link(58,57);
            m_graph.add_link(57,56);
            m_graph.add_link(56,55);
            m_graph.add_link(55,36);
            m_graph.add_link(30,47);
            m_graph.add_link(47,48);
            m_graph.add_link(18,19);
            m_graph.add_link(19,20);
            m_graph.add_link(20,21);
            m_graph.add_link(20,22);
            m_graph.add_link(28,31);
            m_graph.add_link(31,32);
            m_graph.add_link(32,33);
            m_graph.add_link(33,34);
            m_graph.add_link(34,35);
            m_graph.add_link(35,36);
            m_graph.add_link(35,37);
            m_graph.add_link(37,38);
            m_graph.add_link(38,39);
            m_graph.add_link(35,54);
            m_graph.add_link(18,23);
            m_graph.add_link(23,24);
            m_graph.add_link(23,25);
            m_graph.add_link(30,44);
            m_graph.add_link(34,54);
            m_graph.add_link(44,45);
            m_graph.add_link(46,48);
            m_graph.add_link(45,49);
            m_graph.add_link(46,47);
            m_graph.add_link(49,50);
            m_graph.add_link(50,51);
            m_graph.add_link(51,52);
            m_graph.add_link(52,53);
            m_graph.add_link(28,59);
            (m_objects["wood_3"] as LevelObject).set_reshow_interval(10);
         }
         else if(m_num == 4)
         {
            m_artefact = new Artefact(m_objects_layer,new art_artefact_4(),545,454);
            m_objects["camp"] = new Camp(m_objects_layer,325,270,"&camp",2,new Rectangle(0,0,200,200));
            m_objects["pyramid_1"] = new AzPyramid_1(m_objects_layer,83,250,"&pyramid");
            m_objects["pyramid_2"] = new AzPyramid_2(m_objects_layer,83,250,"&pyramid",true);
            m_objects["pyramid_3"] = new AzPyramid_3(m_objects_layer,83,250,"&pyramid",true);
            m_objects["pyramid_4"] = new AzPyramid_4(m_objects_layer,83,250,"&pyramid",true);
            m_objects["sawmill_broken"] = new SawMill_Broken(m_objects_layer,534,347,"&sawmill",new Rectangle(62,93,440,330));
            m_objects["sawmill"] = new SawMill(m_objects_layer,534,347,"&sawmill",3,2,true);
            m_objects["totem_1"] = new TotemWood_Broken(m_objects_layer,566,236,"&totem_1",new Rectangle(0,0,670,450));
            m_objects["totem_2"] = new TotemWood_Broken(m_objects_layer,78,370,"&totem_2",new Rectangle(0,0,285,560));
            m_objects["totem_3"] = new TotemStone_Broken(m_objects_layer,77,143,"&totem_3",new Rectangle(0,0,670,340));
            m_objects["totem_4"] = new TotemStone_Broken(m_objects_layer,285,75,"&totem_4",new Rectangle(0,0,990,395));
            m_objects["bridge_1"] = new StoneBridgeD_Broken(m_objects_layer,497,245,-80,"&bridge_1",new Rectangle(0,0,450,175));
            m_objects["bridge_2"] = new StoneBridgeH_Broken(m_objects_layer,245,178,35,"&bridge_2",new Rectangle(0,0,210,140));
            m_objects["bridge_3"] = new WoodBridgeH_Broken(m_objects_layer,348,78,0,"&bridge_3",new Rectangle(0,0,175,175));
            m_objects["bridge_4"] = new WoodBridgeD_Broken(m_objects_layer,169,351,0,"&bridge_4",new Rectangle(0,0,175,175));
            m_objects["logs_1"] = new ResWoodLogs_1(m_objects_layer,465,270,1,"&logs_1");
            m_objects["logs_2"] = new ResWoodLogs_1(m_objects_layer,379,219,1,"&logs_2");
            m_objects["water_1"] = new ResWater(m_objects_layer,315,208,1,"&water_1");
            m_objects["water_2"] = new ResWater(m_objects_layer,410,230,1,"&water_2");
            m_objects["water_3"] = new ResWater(m_objects_layer,474,313,1,"&water_3");
            m_objects["water_4"] = new ResWater(m_objects_layer,174,189,1,"&water_4");
            m_objects["wood_1"] = new ResWood(m_objects_layer,436,246,1,"&wood_1");
            m_objects["wood_2"] = new ResWood(m_objects_layer,436,371,1,"&wood_2");
            m_objects["honey_1"] = new ResHoney(m_objects_layer,392,367,1,"&honey_1");
            m_objects["honey_2"] = new ResHoney(m_objects_layer,457,102,1,"&honey_2");
            m_objects["honey_3"] = new ResHoney(m_objects_layer,174,226,1,"&honey_3");
            m_objects["honey_5"] = new ResHoney(m_objects_layer,145,325,1,"&honey_5");
            m_objects["honey_6"] = new ResHoney(m_objects_layer,396,80,1,"&honey_6");
            m_objects["lavarock_1"] = new RoadLavaRock(m_objects_layer,352,369,"&lavarock_1");
            m_objects["lavarock_1_rock"] = new RoadHoleRock(m_objects_layer,352,369,"&lavarock_1",true);
            m_objects["lavarock_2"] = new RoadLavaRock(m_objects_layer,127,353,"&lavarock_2");
            m_objects["lavarock_2_rock"] = new RoadHoleRock(m_objects_layer,127,353,"&lavarock_2",true);
            m_objects["lavarock_2_hole"] = new RoadHole(m_objects_layer,127,353,"&lavarock_2",true);
            m_objects["wasps_1"] = new RoadWasps(m_objects_layer,282,198,"&wasps_1");
            m_objects["wasps_2"] = new RoadWasps(m_objects_layer,204,376,"&wasps_2");
            m_objects["wasps_3"] = new RoadWasps(m_objects_layer,141,148,"&wasps_3");
            m_objects["wasps_4"] = new RoadWasps(m_objects_layer,312,74,"&wasps_4");
            m_objects["diamond_1"] = new ResDiamondSmallB(m_objects_layer,442,288,300,"&diamond_1");
            m_objects["diamond_2"] = new ResDiamondSmallP(m_objects_layer,502,384,300,"&diamond_2");
            m_objects["milk_1"] = new ResMilk(m_objects_layer,467,348,1,"&milk_1",new Rectangle(30,0,200,180));
            m_objects["milk_2"] = new ResMilk(m_objects_layer,189,127,1,"&milk_2");
            m_objects["milk_3"] = new ResMilk(m_objects_layer,172,283,1,"&milk_3");
            m_objects["rocks_1"] = new RoadRocks_1(m_objects_layer,313,368,1,"&rocks_1");
            m_objects["lava_1"] = new RoadLava(m_objects_layer,273,366,"&lava_1");
            m_objects["lava_2"] = new RoadLava(m_objects_layer,490,120,"&lava_2");
            m_objects["lava_3"] = new RoadLava(m_objects_layer,181,155,"&lava_3");
            m_objects["lava_3_hole"] = new RoadHole(m_objects_layer,181,155,"&lava_3",true);
            m_objects["stone_1"] = new ResStone(m_objects_layer,235,358,1,"&stone_1");
            m_objects["stone_2"] = new ResStone(m_objects_layer,62,175,1,"&stone_2");
            m_objects["stone_3"] = new ResStone(m_objects_layer,90,174,1,"&stone_3");
            m_objects["hole_1"] = new RoadHole(m_objects_layer,428,91,"&hole_1");
            m_objects["hole_2"] = new RoadHole(m_objects_layer,174,253,"&hole_2");
            m_objects["porcupine_1"] = new RoadPorcupine(m_objects_layer,145,296,"&porcupine_1",false,new Rectangle(0,0,450,230));
            m_objects["well_broken"] = new Well_Broken(m_objects_layer,345,410,"&well",new Rectangle(0,0,170,170));
            m_objects["well"] = new Well(m_objects_layer,345,410,"&well",2,2,true);
            m_objects["quarry_broken"] = new Quarry_Broken(m_objects_layer,400,135,"&quarry",false,new Rectangle(0,0,230,230));
            m_objects["quarry"] = new Quarry(m_objects_layer,400,135,"&quarry",2,1,true);
            m_objects["honey_4"] = new ResHoney(m_objects_layer,429,158,1,"&honey_4");
            (m_objects["honey_4"] as LevelObject).set_reshow_interval(50);
            m_graph.add_node(353,247,"&camp");
            m_graph.add_node(361,219);
            m_graph.add_node(379,224,"&logs_2",false);
            m_graph.add_node(408,232,"&water_2",false);
            m_graph.add_node(435,246,"&wood_1",false);
            m_graph.add_node(464,273,"&logs_1",false);
            m_graph.add_node(477,261,"&bridge_1",false);
            m_graph.add_node(484,242);
            m_graph.add_node(496,233);
            m_graph.add_node(515,230);
            m_graph.add_node(536,216);
            m_graph.add_node(548,224,"&totem_1",false);
            m_graph.add_node(550,199);
            m_graph.add_node(537,174);
            m_graph.add_node(522,154);
            m_graph.add_node(506,135);
            m_graph.add_node(487,118,"&lava_2",false);
            m_graph.add_node(457,101,"&honey_2",false);
            m_graph.add_node(429,91,"&hole_1",false);
            m_graph.add_node(395,78,"&honey_6",false);
            m_graph.add_node(371,74,"&bridge_3",false);
            m_graph.add_node(312,73,"&wasps_4",false);
            m_graph.add_node(298,75,"&totem_4",false);
            m_graph.add_node(443,288,"&diamond_1",false);
            m_graph.add_node(470,291);
            m_graph.add_node(475,315,"&water_3",false);
            m_graph.add_node(466,347,"&milk_1",false);
            m_graph.add_node(486,361);
            m_graph.add_node(511,361,"&sawmill",false);
            m_graph.add_node(502,382,"&diamond_2",false);
            m_graph.add_node(453,361);
            m_graph.add_node(437,372,"&wood_2",false);
            m_graph.add_node(390,367,"&honey_1",false);
            m_graph.add_node(352,366,"&lavarock_1",false);
            m_graph.add_node(312,367,"&rocks_1",false);
            m_graph.add_node(272,366,"&lava_1",false);
            m_graph.add_node(234,359,"&stone_1",false);
            m_graph.add_node(205,373,"&wasps_2",false);
            m_graph.add_node(184,371);
            m_graph.add_node(145,330,"&honey_5",false);
            m_graph.add_node(127,351,"&lavarock_2",false);
            m_graph.add_node(98,361,"&totem_2",false);
            m_graph.add_node(163,308);
            m_graph.add_node(172,283,"&milk_3",false);
            m_graph.add_node(174,254,"&hole_2",false);
            m_graph.add_node(173,228,"&honey_3",false);
            m_graph.add_node(174,194,"&water_4",false);
            m_graph.add_node(178,153,"&lava_3",false);
            m_graph.add_node(188,129,"&milk_2",false);
            m_graph.add_node(142,296,"&porcupine_1",false);
            m_graph.add_node(124,288,"&pyramid",false);
            m_graph.add_node(141,147,"&wasps_3",false);
            m_graph.add_node(96,147,"&totem_3",false);
            m_graph.add_node(114,167);
            m_graph.add_node(89,175,"&stone_3",false);
            m_graph.add_node(60,176,"&stone_2",false);
            m_graph.add_node(245,176,"&bridge_2",false);
            m_graph.add_node(281,197,"&wasps_1",false);
            m_graph.add_node(315,209,"&water_1",false);
            m_graph.add_node(431,124);
            m_graph.add_node(436,139);
            m_graph.add_node(427,161,"&honey_4",false);
            m_graph.add_node(401,165);
            m_graph.add_node(391,154,"&quarry",false);
            m_graph.add_node(348,386);
            m_graph.add_node(324,391);
            m_graph.add_node(308,401);
            m_graph.add_node(307,421);
            m_graph.add_node(322,437);
            m_graph.add_node(345,435);
            m_graph.add_node(347,426,"&well",false);
            m_graph.add_node(166,353,"&bridge_4",false);
            m_graph.add_link(0,1);
            m_graph.add_link(1,2);
            m_graph.add_link(2,3);
            m_graph.add_link(3,4);
            m_graph.add_link(4,5);
            m_graph.add_link(5,6);
            m_graph.add_link(5,23);
            m_graph.add_link(5,24);
            m_graph.add_link(6,7);
            m_graph.add_link(7,8);
            m_graph.add_link(8,9);
            m_graph.add_link(9,10);
            m_graph.add_link(10,11);
            m_graph.add_link(10,12);
            m_graph.add_link(12,13);
            m_graph.add_link(13,14);
            m_graph.add_link(14,15);
            m_graph.add_link(15,16);
            m_graph.add_link(16,17);
            m_graph.add_link(17,18);
            m_graph.add_link(18,19);
            m_graph.add_link(19,20);
            m_graph.add_link(20,21);
            m_graph.add_link(21,22);
            m_graph.add_link(24,25);
            m_graph.add_link(25,26);
            m_graph.add_link(26,27);
            m_graph.add_link(26,30);
            m_graph.add_link(27,28);
            m_graph.add_link(27,29);
            m_graph.add_link(30,31);
            m_graph.add_link(31,32);
            m_graph.add_link(32,33);
            m_graph.add_link(33,34);
            m_graph.add_link(33,64);
            m_graph.add_link(34,35);
            m_graph.add_link(35,36);
            m_graph.add_link(36,37);
            m_graph.add_link(37,38);
            m_graph.add_link(38,71);
            m_graph.add_link(39,71);
            m_graph.add_link(39,40);
            m_graph.add_link(39,42);
            m_graph.add_link(40,41);
            m_graph.add_link(42,43);
            m_graph.add_link(42,49);
            m_graph.add_link(43,44);
            m_graph.add_link(44,45);
            m_graph.add_link(45,46);
            m_graph.add_link(46,47);
            m_graph.add_link(47,48);
            m_graph.add_link(47,51);
            m_graph.add_link(47,56);
            m_graph.add_link(49,50);
            m_graph.add_link(51,52);
            m_graph.add_link(51,53);
            m_graph.add_link(53,54);
            m_graph.add_link(54,55);
            m_graph.add_link(56,57);
            m_graph.add_link(57,58);
            m_graph.add_link(58,1);
            m_graph.add_link(59,17);
            m_graph.add_link(59,60);
            m_graph.add_link(60,61);
            m_graph.add_link(61,62);
            m_graph.add_link(62,63);
            m_graph.add_link(64,65);
            m_graph.add_link(65,66);
            m_graph.add_link(66,67);
            m_graph.add_link(67,68);
            m_graph.add_link(68,69);
            m_graph.add_link(69,70);
         }
         else if(m_num == 5)
         {
            m_artefact = new Artefact(m_objects_layer,new art_artefact_5(),120,192);
            m_objects["camp"] = new Camp(m_objects_layer,520,85,"&camp",2,new Rectangle(0,0,270,270));
            m_objects["bridge_1"] = new WoodBridgeV_Broken(m_objects_layer,353,100,-10,"&bridge_1",new Rectangle(0,0,220,160));
            m_objects["bridge_2"] = new WoodBridgeV_Broken(m_objects_layer,372,309,10,"&bridge_2",new Rectangle(0,0,220,220));
            m_objects["bridge_3"] = new StoneBridgeV_Broken(m_objects_layer,579,280,0,"&bridge_3",new Rectangle(0,0,330,135));
            m_objects["bridge_4"] = new StoneBridgeD_Broken(m_objects_layer,158,225,-90,"&bridge_4",new Rectangle(0,0,220,170));
            m_objects["bridge_5"] = new StoneBridgeH_Broken(m_objects_layer,230,413,0,"&bridge_5",new Rectangle(0,0,170,205));
            m_objects["well"] = new Well(m_objects_layer,471,225,"&well",2,1);
            m_objects["quarry"] = new Quarry(m_objects_layer,269,285,"&quarry",2,1);
            m_objects["beegarden_broken"] = new BeeGarden_Broken(m_objects_layer,85,65,"&beegarden",new Rectangle(0,0,330,330));
            m_objects["beegarden"] = new BeeGarden(m_objects_layer,85,65,"&beegarden",1,true);
            m_objects["logs_1"] = new ResWoodLogs_1(m_objects_layer,497,153,1,"&logs_1");
            m_objects["logs_2"] = new ResWoodLogs_2(m_objects_layer,372,215,2,"&logs_2");
            m_objects["logs_3"] = new ResWoodLogs_2(m_objects_layer,185,75,2,"&logs_3");
            m_objects["logs_4"] = new ResWoodLogs_1(m_objects_layer,294,58,1,"&logs_4");
            m_objects["logs_5"] = new ResWoodLogs_2(m_objects_layer,171,178,2,"&logs_5");
            m_objects["logs_6"] = new ResWoodLogs_2(m_objects_layer,357,364,2,"&logs_6");
            m_objects["logs_7"] = new ResWoodLogs_2(m_objects_layer,562,324,2,"&logs_7");
            m_objects["logs_8"] = new ResWoodLogs_2(m_objects_layer,291,405,2,"&logs_8");
            m_objects["logs_9"] = new ResWoodLogs_2(m_objects_layer,142,319,2,"&logs_9");
            m_objects["water_1"] = new ResWater(m_objects_layer,533,166,1,"&water_1");
            m_objects["water_2"] = new ResWater(m_objects_layer,390,411,1,"&water_2");
            m_objects["honey_1"] = new ResHoney(m_objects_layer,565,201,1,"&honey_1");
            m_objects["honey_2"] = new ResHoney(m_objects_layer,325,70,1,"&honey_2");
            m_objects["honey_3"] = new ResHoney(m_objects_layer,507,371,1,"&honey_3");
            m_objects["rocks_1"] = new RoadRocks_1(m_objects_layer,577,240,1,"&rocks_1");
            m_objects["wood_1"] = new ResWood(m_objects_layer,542,249,1,"&wood_1");
            m_objects["wood_2"] = new ResWood(m_objects_layer,466,164,1,"&wood_2");
            m_objects["wood_3"] = new ResWood(m_objects_layer,318,296,1,"&wood_3");
            m_objects["wood_4"] = new ResWood(m_objects_layer,246,212,1,"&wood_4");
            m_objects["wood_5"] = new ResWood(m_objects_layer,333,175,1,"&wood_5");
            m_objects["wood_6"] = new ResWood(m_objects_layer,240,117,1,"&wood_6");
            m_objects["wood_7"] = new ResWood(m_objects_layer,257,95,1,"&wood_7");
            m_objects["wood_8"] = new ResWood(m_objects_layer,131,260,1,"&wood_8");
            m_objects["wood_9"] = new ResWood(m_objects_layer,531,395,1,"&wood_9");
            m_objects["wood_10"] = new ResWood(m_objects_layer,471,387,1,"&wood_10");
            m_objects["wood_11"] = new ResWood(m_objects_layer,187,409,1,"&wood_11");
            m_objects["holerock_1"] = new RoadHoleRock(m_objects_layer,434,406,"&holerock_1");
            m_objects["wasps_1"] = new RoadWasps(m_objects_layer,500,184,"&wasps_1");
            m_objects["wasps_2"] = new RoadWasps(m_objects_layer,375,258,"&wasps_2");
            m_objects["wasps_3"] = new RoadWasps(m_objects_layer,162,145,"&wasps_3");
            m_objects["wasps_5"] = new RoadWasps(m_objects_layer,232,145,"&wasps_5");
            m_objects["wasps_6"] = new RoadWasps(m_objects_layer,146,359,"&wasps_6");
            m_objects["diamond_1"] = new ResDiamondSmallB(m_objects_layer,529,271,300,"&diamond_1");
            m_objects["diamond_2"] = new ResDiamondSmallP(m_objects_layer,300,261,300,"&diamond_2");
            m_objects["diamond_3"] = new ResDiamondSmallY(m_objects_layer,357,167,300,"&diamond_3");
            m_objects["diamond_4"] = new ResDiamondSmallB(m_objects_layer,126,235,300,"&diamond_4");
            m_objects["diamond_5"] = new ResDiamondSmallY(m_objects_layer,183,385,300,"&diamond_5");
            m_objects["diamond_6"] = new ResDiamondP(m_objects_layer,228,85,1000,"&diamond_6");
            m_objects["diamond_7"] = new ResDiamondY(m_objects_layer,100,280,1000,"&diamond_7");
            m_objects["diamond_8"] = new ResDiamondP(m_objects_layer,498,402,1000,"&diamond_8");
            m_objects["lava_1"] = new RoadLava(m_objects_layer,438,189,"&lava_1");
            m_objects["lava_2"] = new RoadLava(m_objects_layer,319,205,"&lava_2");
            m_objects["lava_2_hole"] = new RoadHoleS(m_objects_layer,319,205,"&lava_2",true);
            m_objects["lava_3"] = new RoadLava(m_objects_layer,332,251,"&lava_3",new Rectangle(0,0,390,200));
            m_objects["lava_4"] = new RoadLava(m_objects_layer,159,108,"&lava_4",new Rectangle(0,0,300,300));
            m_objects["lava_4_hole"] = new RoadHoleS(m_objects_layer,159,108,"&lava_4",true);
            m_objects["lava_5"] = new RoadLava(m_objects_layer,252,58,"&lava_5");
            m_objects["lava_5_hole"] = new RoadHoleS(m_objects_layer,252,58,"&lava_5",true);
            m_objects["lava_6"] = new RoadLava(m_objects_layer,344,394,"&lava_6");
            m_objects["lava_6_hole"] = new RoadHoleS(m_objects_layer,344,394,"&lava_6",true);
            m_objects["hole_1"] = new RoadHoleS(m_objects_layer,214,214,"&hole_1");
            m_objects["hole_2"] = new RoadHoleS(m_objects_layer,348,142,"&hole_2");
            m_objects["hole_3"] = new RoadHoleS(m_objects_layer,541,352,"&hole_3");
            m_objects["hole_4"] = new RoadHoleS(m_objects_layer,157,391,"&hole_4");
            m_objects["stone_1"] = new ResStone(m_objects_layer,407,202,1,"&stone_1");
            m_objects["stone_2"] = new ResStone(m_objects_layer,277,213,1,"&stone_2");
            m_objects["totem_1"] = new TotemWood_Broken(m_objects_layer,270,164,"&totem_1",new Rectangle(0,0,2200,235));
            m_objects["totem_2"] = new TotemStone_Broken(m_objects_layer,90,231,"&totem_2",new Rectangle(0,0,550,440));
            m_objects["totem_3"] = new TotemWood_Broken(m_objects_layer,573,400,"&totem_3",new Rectangle(0,0,550,500));
            m_graph.add_node(501,125,"&camp");
            m_graph.add_node(497,152,"&logs_1",false);
            m_graph.add_node(531,166,"&water_1",false);
            m_graph.add_node(565,203,"&honey_1",false);
            m_graph.add_node(578,241,"&rocks_1",false);
            m_graph.add_node(540,249,"&wood_1",false);
            m_graph.add_node(482,245,"&well",false);
            m_graph.add_node(528,273,"&diamond_1",false);
            m_graph.add_node(578,269,"&bridge_3",false);
            m_graph.add_node(577,304);
            m_graph.add_node(561,328,"&logs_7",false);
            m_graph.add_node(539,355,"&hole_3",false);
            m_graph.add_node(505,373,"&honey_3",false);
            m_graph.add_node(531,398,"&wood_9",false);
            m_graph.add_node(563,401,"&totem_3",false);
            m_graph.add_node(470,389,"&wood_10",false);
            m_graph.add_node(497,404,"&diamond_8",false);
            m_graph.add_node(435,404,"&holerock_1",false);
            m_graph.add_node(390,412,"&water_2",false);
            m_graph.add_node(343,394,"&lava_6",false);
            m_graph.add_node(290,405,"&logs_8",false);
            m_graph.add_node(252,414);
            m_graph.add_node(231,406,"&bridge_5",false);
            m_graph.add_node(207,414);
            m_graph.add_node(186,409,"&wood_11",false);
            m_graph.add_node(155,392,"&hole_4",false);
            m_graph.add_node(185,384,"&diamond_5",false);
            m_graph.add_node(147,352,"&wasps_6",false);
            m_graph.add_node(141,321,"&logs_9",false);
            m_graph.add_node(131,289);
            m_graph.add_node(132,256,"&wood_8",false);
            m_graph.add_node(141,240);
            m_graph.add_node(152,218,"&bridge_4",false);
            m_graph.add_node(183,202);
            m_graph.add_node(99,283,"&diamond_7",false);
            m_graph.add_node(123,233,"&diamond_4",false);
            m_graph.add_node(76,240,"&totem_2",false);
            m_graph.add_node(355,362,"&logs_6",false);
            m_graph.add_node(370,310,"&bridge_2",false);
            m_graph.add_node(374,262,"&wasps_2",false);
            m_graph.add_node(375,215,"&logs_2",false);
            m_graph.add_node(407,203,"&stone_1",false);
            m_graph.add_node(438,187,"&lava_1",false);
            m_graph.add_node(464,165,"&wood_2",false);
            m_graph.add_node(348,229);
            m_graph.add_node(331,253,"&lava_3",false);
            m_graph.add_node(309,276);
            m_graph.add_node(317,298,"&wood_3",false);
            m_graph.add_node(298,260,"&diamond_2",false);
            m_graph.add_node(298,302);
            m_graph.add_node(272,311,"&quarry",false);
            m_graph.add_node(346,208);
            m_graph.add_node(317,203,"&lava_2",false);
            m_graph.add_node(331,176,"&wood_5",false);
            m_graph.add_node(350,141,"&hole_2",false);
            m_graph.add_node(278,212,"&stone_2",false);
            m_graph.add_node(245,213,"&wood_4",false);
            m_graph.add_node(212,215,"&hole_1",false);
            m_graph.add_node(169,177,"&logs_5",false);
            m_graph.add_node(163,144,"&wasps_3",false);
            m_graph.add_node(158,107,"&lava_4",false);
            m_graph.add_node(190,71,"&logs_3",false);
            m_graph.add_node(253,58,"&lava_5",false);
            m_graph.add_node(294,59,"&logs_4",false);
            m_graph.add_node(329,74,"&honey_2",false);
            m_graph.add_node(345,82);
            m_graph.add_node(353,120);
            m_graph.add_node(262,79);
            m_graph.add_node(256,100,"&wood_7",false);
            m_graph.add_node(236,120,"&wood_6",false);
            m_graph.add_node(231,145,"&wasps_5",false);
            m_graph.add_node(273,168,"&totem_1",false);
            m_graph.add_node(226,84,"&diamond_6",false);
            m_graph.add_node(89,102,"&beegarden",false);
            m_graph.add_node(350,98,"&bridge_1",false);
            m_graph.add_node(501,187,"&wasps_1",false);
            m_graph.add_node(515,209);
            m_graph.add_node(516,221);
            m_graph.add_node(512,232);
            m_graph.add_node(495,238);
            m_graph.add_node(358,160,"&diamond_3",false);
            m_graph.add_link(0,1);
            m_graph.add_link(1,2);
            m_graph.add_link(1,43);
            m_graph.add_link(1,75);
            m_graph.add_link(2,3);
            m_graph.add_link(3,4);
            m_graph.add_link(4,5);
            m_graph.add_link(4,8);
            m_graph.add_link(5,6);
            m_graph.add_link(5,7);
            m_graph.add_link(5,76);
            m_graph.add_link(6,79);
            m_graph.add_link(8,9);
            m_graph.add_link(9,10);
            m_graph.add_link(10,11);
            m_graph.add_link(11,12);
            m_graph.add_link(12,13);
            m_graph.add_link(12,15);
            m_graph.add_link(12,16);
            m_graph.add_link(13,14);
            m_graph.add_link(13,16);
            m_graph.add_link(15,16);
            m_graph.add_link(15,17);
            m_graph.add_link(17,18);
            m_graph.add_link(18,19);
            m_graph.add_link(19,20);
            m_graph.add_link(19,37);
            m_graph.add_link(20,21);
            m_graph.add_link(21,22);
            m_graph.add_link(22,23);
            m_graph.add_link(23,24);
            m_graph.add_link(24,25);
            m_graph.add_link(24,26);
            m_graph.add_link(25,27);
            m_graph.add_link(25,26);
            m_graph.add_link(27,28);
            m_graph.add_link(28,29);
            m_graph.add_link(29,30);
            m_graph.add_link(29,34);
            m_graph.add_link(30,31);
            m_graph.add_link(30,36);
            m_graph.add_link(30,34);
            m_graph.add_link(31,32);
            m_graph.add_link(31,35);
            m_graph.add_link(32,33);
            m_graph.add_link(33,57);
            m_graph.add_link(33,58);
            m_graph.add_link(37,38);
            m_graph.add_link(38,39);
            m_graph.add_link(39,40);
            m_graph.add_link(40,41);
            m_graph.add_link(40,44);
            m_graph.add_link(40,51);
            m_graph.add_link(41,42);
            m_graph.add_link(42,43);
            m_graph.add_link(44,45);
            m_graph.add_link(45,46);
            m_graph.add_link(46,47);
            m_graph.add_link(46,48);
            m_graph.add_link(47,49);
            m_graph.add_link(49,50);
            m_graph.add_link(51,52);
            m_graph.add_link(52,53);
            m_graph.add_link(52,55);
            m_graph.add_link(53,54);
            m_graph.add_link(53,80);
            m_graph.add_link(54,66);
            m_graph.add_link(54,80);
            m_graph.add_link(55,56);
            m_graph.add_link(56,57);
            m_graph.add_link(58,59);
            m_graph.add_link(59,60);
            m_graph.add_link(60,61);
            m_graph.add_link(60,73);
            m_graph.add_link(61,62);
            m_graph.add_link(62,63);
            m_graph.add_link(62,67);
            m_graph.add_link(63,64);
            m_graph.add_link(64,65);
            m_graph.add_link(65,74);
            m_graph.add_link(66,74);
            m_graph.add_link(67,68);
            m_graph.add_link(67,72);
            m_graph.add_link(68,69);
            m_graph.add_link(68,72);
            m_graph.add_link(69,70);
            m_graph.add_link(70,71);
            m_graph.add_link(75,76);
            m_graph.add_link(76,77);
            m_graph.add_link(77,78);
            m_graph.add_link(78,79);
         }
         else if(m_num == 6)
         {
            m_artefact = new Artefact(m_objects_layer,new art_artefact_6(),609,343);
            m_objects["camp"] = new Camp(m_objects_layer,265,245,"&camp",2,new Rectangle(0,0,270,270));
            m_objects["sawmill"] = new SawMill(m_objects_layer,92,343,"&sawmill",3,1);
            m_objects["well"] = new Well(m_objects_layer,397,401,"&well",3,1);
            m_objects["quarry_broken"] = new Quarry_Broken(m_objects_layer,533,356,"&quarry");
            m_objects["quarry"] = new Quarry(m_objects_layer,533,356,"&quarry",3,1,true);
            m_objects["beegarden_broken"] = new BeeGarden_Broken(m_objects_layer,511,85,"&beegarden",new Rectangle(0,0,330,330));
            m_objects["beegarden"] = new BeeGarden(m_objects_layer,511,85,"&beegarden",2,true);
            m_objects["bridge_1"] = new StoneBridgeD_Broken(m_objects_layer,223,134,0,"&bridge_1",new Rectangle(0,0,220,220));
            m_objects["bridge_2"] = new StoneBridgeD_Broken(m_objects_layer,405,115,-75,"&bridge_2",new Rectangle(0,0,220,220));
            m_objects["bridge_3"] = new WoodBridgeH_Broken(m_objects_layer,230,377,0,"&bridge_3",new Rectangle(0,0,220,220));
            m_objects["bridge_4"] = new WoodBridgeD_Broken(m_objects_layer,463,333,-10,"&bridge_4",new Rectangle(0,0,220,220));
            m_objects["rocks_1"] = new RoadRocks_1(m_objects_layer,152,240,1,"&rocks_1");
            m_objects["rocks_2"] = new RoadRocks_2(m_objects_layer,308,148,1,"&rocks_2");
            m_objects["wood_1"] = new ResWood(m_objects_layer,191,261,1,"&wood_1");
            m_objects["wood_2"] = new ResWood(m_objects_layer,359,341,1,"&wood_2",new Rectangle(0,0,880,220));
            m_objects["wood_3"] = new ResWood(m_objects_layer,449,103,1,"&wood_3",new Rectangle(10,0,220,190));
            m_objects["diamonds_1"] = new ResDiamondSmallB(m_objects_layer,184,237,300,"&diamonds_1");
            m_objects["diamonds_2"] = new ResDiamondSmallY(m_objects_layer,66,380,300,"&diamonds_2");
            m_objects["diamonds_3"] = new ResDiamondSmallP(m_objects_layer,420,331,300,"&diamonds_3");
            m_objects["diamonds_4"] = new ResDiamondSmallB(m_objects_layer,390,153,300,"&diamonds_4");
            m_objects["diamonds_5"] = new ResDiamondP(m_objects_layer,227,83,300,"&diamonds_5");
            m_objects["diamonds_6"] = new ResDiamondSmallB(m_objects_layer,179,54,300,"&diamonds_6");
            m_objects["diamonds_7"] = new ResDiamondSmallY(m_objects_layer,519,237,300,"&diamonds_7");
            m_objects["grain_1"] = new ResGrain(m_objects_layer,214,189,1,"&grain_1");
            m_objects["grain_2"] = new ResGrain(m_objects_layer,269,370,1,"&grain_2");
            m_objects["grain_3"] = new ResGrain(m_objects_layer,493,360,1,"&grain_3");
            m_objects["logs_1"] = new ResWoodLogs_1(m_objects_layer,183,212,1,"&logs_1");
            m_objects["logs_2"] = new ResWoodLogs_1(m_objects_layer,149,374,1,"&logs_2");
            m_objects["logs_3"] = new ResWoodLogs_2(m_objects_layer,307,359,1,"&logs_3");
            m_objects["logs_4"] = new ResWoodLogs_1(m_objects_layer,459,212,1,"&logs_4");
            m_objects["boar_1"] = new RoadBoar_1(m_objects_layer,253,167,"&boar_1");
            m_objects["water_1"] = new ResWater(m_objects_layer,130,283,1,"&water_1");
            m_objects["water_2"] = new ResWater(m_objects_layer,133,330,1,"&water_2",new Rectangle(0,0,220,220));
            m_objects["stone_1"] = new ResStone(m_objects_layer,190,377,1,"&stone_1");
            m_objects["stone_2"] = new ResStone(m_objects_layer,420,305,1,"&stone_2");
            m_objects["stone_3"] = new ResStone(m_objects_layer,391,179,1,"&stone_3");
            m_objects["stone_4"] = new ResStone(m_objects_layer,425,241,1,"&stone_4");
            m_objects["stone_5"] = new ResStone(m_objects_layer,529,212,1,"&stone_5");
            m_objects["lava_1"] = new RoadLava(m_objects_layer,393,326,"&lava_1");
            m_objects["lava_1_hole"] = new RoadHole(m_objects_layer,393,326,"&lava_1",true);
            m_objects["lava_2"] = new RoadLava(m_objects_layer,363,154,"&lava_2");
            m_objects["lava_2_hole"] = new RoadHole(m_objects_layer,363,154,"&lava_2",true);
            m_objects["lava_3"] = new RoadLava(m_objects_layer,175,88,"&lava_3");
            m_objects["lava_3_hole"] = new RoadHole(m_objects_layer,175,88,"&lava_3",true);
            m_objects["lava_4"] = new RoadLava(m_objects_layer,413,211,"&lava_4");
            m_objects["lava_4_hole"] = new RoadHole(m_objects_layer,413,211,"&lava_4",true);
            m_objects["hole_1"] = new RoadHole(m_objects_layer,501,171,"&hole_1");
            m_objects["hole_2"] = new RoadHole(m_objects_layer,509,262,"&hole_2");
            m_objects["wasps_1"] = new RoadWasps(m_objects_layer,142,108,"&wasps_1");
            m_objects["wasps_2"] = new RoadWasps(m_objects_layer,205,63,"&wasps_2");
            m_objects["wasps_3"] = new RoadWasps(m_objects_layer,430,276,"&wasps_3");
            m_objects["wasps_4"] = new RoadWasps(m_objects_layer,496,211,"&wasps_4");
            m_objects["wasps_5"] = new RoadWasps(m_objects_layer,547,273,"&wasps_5");
            m_objects["totem_1"] = new TotemStone_Broken(m_objects_layer,246,55,"&totem_1",new Rectangle(0,0,1100,330));
            m_objects["totem_2"] = new TotemStone_Broken(m_objects_layer,110,114,"&totem_2",new Rectangle(0,0,440,440));
            m_objects["totem_3"] = new TotemWood_Broken(m_objects_layer,438,175,"&totem_3",new Rectangle(0,0,330,990));
            m_objects["totem_4"] = new TotemWood_Broken(m_objects_layer,589,271,"&totem_4",new Rectangle(0,0,440,550));
            m_graph.add_node(228,266,"&camp");
            m_graph.add_node(190,263,"&wood_1",false);
            m_graph.add_node(150,240,"&rocks_1",false);
            m_graph.add_node(181,213,"&logs_1",false);
            m_graph.add_node(213,190,"&grain_1",false);
            m_graph.add_node(252,166,"&boar_1",false);
            m_graph.add_node(308,149,"&rocks_2",false);
            m_graph.add_node(362,153,"&lava_2",false);
            m_graph.add_node(392,182,"&stone_3",false);
            m_graph.add_node(412,211,"&lava_4",false);
            m_graph.add_node(426,243,"&stone_4",false);
            m_graph.add_node(429,276,"&wasps_3",false);
            m_graph.add_node(419,306,"&stone_2",false);
            m_graph.add_node(392,327,"&lava_1",false);
            m_graph.add_node(357,344,"&wood_2",false);
            m_graph.add_node(304,360,"&logs_3",false);
            m_graph.add_node(267,371,"&grain_2",false);
            m_graph.add_node(231,375,"&bridge_3",false);
            m_graph.add_node(190,376,"&stone_1",false);
            m_graph.add_node(149,375,"&logs_2",false);
            m_graph.add_node(131,332,"&water_2",false);
            m_graph.add_node(129,284,"&water_1",false);
            m_graph.add_node(456,212,"&logs_4",false);
            m_graph.add_node(401,111,"&bridge_2",false);
            m_graph.add_node(222,131,"&bridge_1",false);
            m_graph.add_node(172,89,"&lava_3",false);
            m_graph.add_node(204,66,"&wasps_2",false);
            m_graph.add_node(253,55,"&totem_1",false);
            m_graph.add_node(142,109,"&wasps_1",false);
            m_graph.add_node(105,117,"&totem_2",false);
            m_graph.add_node(177,55,"&diamonds_6",false);
            m_graph.add_node(446,172,"&totem_3",false);
            m_graph.add_node(497,211,"&wasps_4",false);
            m_graph.add_node(532,213,"&stone_5",false);
            m_graph.add_node(451,102,"&wood_3",false);
            m_graph.add_node(499,171,"&hole_1",false);
            m_graph.add_node(498,238);
            m_graph.add_node(517,238,"&diamonds_7",false);
            m_graph.add_node(510,264,"&hole_2",false);
            m_graph.add_node(527,274);
            m_graph.add_node(552,274,"&wasps_5",false);
            m_graph.add_node(600,273,"&totem_4",false);
            m_graph.add_node(458,334,"&bridge_4",false);
            m_graph.add_node(488,363,"&grain_3",false);
            m_graph.add_node(419,333,"&diamonds_3",false);
            m_graph.add_node(182,235,"&diamonds_1",false);
            m_graph.add_node(225,83,"&diamonds_5",false);
            m_graph.add_node(387,151,"&diamonds_4",false);
            m_graph.add_node(495,140);
            m_graph.add_node(475,119);
            m_graph.add_node(505,113,"&beegarden",false);
            m_graph.add_node(98,368,"&sawmill",false);
            m_graph.add_node(372,379);
            m_graph.add_node(361,394);
            m_graph.add_node(353,409);
            m_graph.add_node(359,426);
            m_graph.add_node(377,430);
            m_graph.add_node(394,424,"&well",false);
            m_graph.add_node(499,378);
            m_graph.add_node(530,384,"&quarry",false);
            m_graph.add_node(65,379,"&diamonds_2",false);
            m_graph.add_node(139,354);
            m_graph.add_link(0,1);
            m_graph.add_link(1,2);
            m_graph.add_link(2,3);
            m_graph.add_link(2,21);
            m_graph.add_link(3,4);
            m_graph.add_link(3,45);
            m_graph.add_link(4,5);
            m_graph.add_link(5,6);
            m_graph.add_link(5,24);
            m_graph.add_link(6,7);
            m_graph.add_link(7,8);
            m_graph.add_link(7,23);
            m_graph.add_link(7,47);
            m_graph.add_link(8,9);
            m_graph.add_link(8,31);
            m_graph.add_link(9,10);
            m_graph.add_link(9,22);
            m_graph.add_link(9,31);
            m_graph.add_link(10,11);
            m_graph.add_link(11,12);
            m_graph.add_link(12,13);
            m_graph.add_link(12,42);
            m_graph.add_link(12,44);
            m_graph.add_link(13,14);
            m_graph.add_link(14,15);
            m_graph.add_link(14,52);
            m_graph.add_link(15,16);
            m_graph.add_link(16,17);
            m_graph.add_link(17,18);
            m_graph.add_link(18,19);
            m_graph.add_link(19,61);
            m_graph.add_link(20,21);
            m_graph.add_link(20,61);
            m_graph.add_link(22,31);
            m_graph.add_link(22,32);
            m_graph.add_link(23,34);
            m_graph.add_link(24,25);
            m_graph.add_link(25,26);
            m_graph.add_link(25,28);
            m_graph.add_link(25,30);
            m_graph.add_link(26,27);
            m_graph.add_link(26,30);
            m_graph.add_link(26,46);
            m_graph.add_link(28,29);
            m_graph.add_link(32,33);
            m_graph.add_link(32,35);
            m_graph.add_link(32,36);
            m_graph.add_link(34,49);
            m_graph.add_link(34,50);
            m_graph.add_link(35,48);
            m_graph.add_link(36,37);
            m_graph.add_link(36,38);
            m_graph.add_link(38,39);
            m_graph.add_link(39,40);
            m_graph.add_link(40,41);
            m_graph.add_link(42,43);
            m_graph.add_link(43,58);
            m_graph.add_link(48,49);
            m_graph.add_link(48,50);
            m_graph.add_link(51,60);
            m_graph.add_link(51,61);
            m_graph.add_link(52,53);
            m_graph.add_link(53,54);
            m_graph.add_link(54,55);
            m_graph.add_link(55,56);
            m_graph.add_link(56,57);
            m_graph.add_link(58,59);
            m_graph.add_link(60,61);
         }
         for(_loc2_ in m_objects)
         {
            _loc3_ = m_objects[_loc2_];
            _loc3_.set_uid(_loc2_);
            _loc3_.deactivate();
         }
         unfog_around_object("camp");
         m_graph.redraw_canvas();
      }
      
      public static function loading_complete() : void
      {
         var _loc6_:Worker = null;
         var _loc7_:int = 0;
         var _loc1_:String = "";
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = "";
         m_time_cur = 0;
         switch(m_num)
         {
            case 1:
               m_time_max = 180;
               _loc2_ = XMLTranslation.s("LEVEL_1_NUM");
               _loc3_ = XMLTranslation.s("LEVEL_1_TASK_1_1");
               _loc4_ = XMLTranslation.s("LEVEL_1_TASK_2");
               _loc1_ = XMLTranslation.s("LEVEL_1_NAME");
               m_explorer.init(new art_artefact_1());
               break;
            case 2:
               m_time_max = 360;
               _loc2_ = XMLTranslation.s("LEVEL_2_NUM");
               _loc3_ = XMLTranslation.s("LEVEL_2_TASK_1_1");
               _loc4_ = XMLTranslation.s("LEVEL_2_TASK_2");
               _loc1_ = XMLTranslation.s("LEVEL_2_NAME");
               m_explorer.init(new art_artefact_2());
               break;
            case 3:
               m_time_max = 450;
               _loc2_ = XMLTranslation.s("LEVEL_3_NUM");
               _loc3_ = XMLTranslation.s("LEVEL_3_TASK_1_1");
               _loc4_ = XMLTranslation.s("LEVEL_3_TASK_2");
               _loc1_ = XMLTranslation.s("LEVEL_3_NAME");
               m_explorer.init(new art_artefact_3());
               break;
            case 4:
               m_time_max = 560;
               _loc2_ = XMLTranslation.s("LEVEL_4_NUM");
               _loc3_ = XMLTranslation.s("LEVEL_4_TASK_1_1");
               _loc4_ = XMLTranslation.s("LEVEL_4_TASK_2_1");
               _loc1_ = XMLTranslation.s("LEVEL_4_NAME");
               m_explorer.init(new art_artefact_4());
               break;
            case 5:
               m_time_max = 450;
               _loc2_ = XMLTranslation.s("LEVEL_5_NUM");
               _loc3_ = XMLTranslation.s("LEVEL_5_TASK_1_1");
               _loc4_ = XMLTranslation.s("LEVEL_5_TASK_2");
               _loc1_ = XMLTranslation.s("LEVEL_5_NAME");
               m_explorer.init(new art_artefact_5());
               break;
            case 6:
               m_time_max = 470;
               _loc2_ = XMLTranslation.s("LEVEL_6_NUM");
               _loc3_ = XMLTranslation.s("LEVEL_6_TASK_1_1");
               _loc4_ = XMLTranslation.s("LEVEL_6_TASK_2");
               _loc1_ = XMLTranslation.s("LEVEL_6_NAME");
               m_explorer.init(new art_artefact_6());
         }
         var _loc5_:int = 0;
         while(_loc5_ < m_resources.length)
         {
            m_resources[_loc5_] = -1;
            _loc5_++;
         }
         m_resources[ResType.WORKER] = 1;
         m_resources[ResType.WOOD] = 0;
         m_resources[ResType.STONE] = 0;
         m_resources[ResType.DIAMONDS] = 0;
         GameScreen.update_name(_loc2_);
         GameScreen.update_task_1_status(false);
         GameScreen.update_task_2_status(false);
         GameScreen.update_task_1_text(_loc3_);
         GameScreen.update_task_2_text(_loc4_);
         GameScreen.update_resources(m_resources);
         update_objects_overs();
         for each(_loc6_ in m_workers)
         {
            _loc6_.hide();
         }
         m_workers = new Array();
         _loc7_ = 0;
         while(_loc7_ < m_resources[ResType.WORKER])
         {
            m_workers.push(new Worker(m_workers_layer));
            _loc7_++;
         }
         m_tasks_queue = new Array();
         m_paused = false;
      }
      
      public static function unfog_region(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:Number = NaN;
         m_fog.show_zone(param1,param2,param3,param4);
         update_objects_activity();
         if(m_artefact != null && !m_fog.hit_test(m_artefact.x,m_artefact.y) && m_artefact.is_active())
         {
            _loc5_ = 30;
            m_artefact.show(_loc5_);
            m_explorer.show(_loc5_);
         }
      }
      
      private static function update_objects_activity() : void
      {
         var _loc1_:* = null;
         var _loc2_:LevelObject = null;
         for(_loc1_ in m_objects)
         {
            _loc2_ = m_objects[_loc1_];
            if(!m_fog.hit_test(_loc2_.x,_loc2_.y))
            {
               if(!(_loc2_ as RepairableObject && (_loc2_ as RepairableObject).repaired()))
               {
                  _loc2_.activate();
               }
            }
         }
      }
      
      public static function unfog_around_object(param1:String) : void
      {
         var _loc2_:LevelObject = m_objects[param1];
         if(_loc2_)
         {
            unfog_region(_loc2_.x + _loc2_.get_unfog_ellipse().x,_loc2_.y + _loc2_.get_unfog_ellipse().y,_loc2_.get_unfog_ellipse().width,_loc2_.get_unfog_ellipse().height);
         }
      }
      
      private static function on_added(param1:Event) : void
      {
         m_this.addEventListener(Event.ENTER_FRAME,on_enter_frame);
      }
      
      private static function on_removed(param1:Event) : void
      {
         m_this.removeEventListener(Event.ENTER_FRAME,on_enter_frame);
      }
      
      public static function update_infownd(param1:LevelObject) : void
      {
         if(m_fog.hit_test(param1.x,param1.y))
         {
            return;
         }
         m_infownd.set_info(param1.uses_num(),param1.gives_num(),param1.uses_res(),param1.gives_res(),param1.get_name(),param1.get_progress());
      }
      
      private static function update_objects_overs() : void
      {
         var _loc1_:LevelObject = null;
         for each(_loc1_ in m_objects)
         {
            update_object_accessability(_loc1_);
         }
      }
      
      public static function update_object_accessability(param1:LevelObject) : void
      {
         var _loc2_:Boolean = true;
         if(param1.uses_num() && param1.uses_res() != ResType.NONE)
         {
            if(param1.uses_num() > m_resources[param1.uses_res()])
            {
               _loc2_ = false;
            }
         }
         var _loc3_:int = m_graph.strid2uid("&camp");
         var _loc4_:int = m_graph.strid2uid(param1.get_nodeid());
         var _loc5_:Array = m_graph.get_path(_loc3_,_loc4_);
         var _loc6_:Boolean = m_fog.hit_test(param1.x,param1.y);
         if(_loc2_ && _loc5_ && !_loc6_)
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = false;
         }
         param1.set_accessable(_loc2_);
         param1.update_selectors();
      }
      
      public static function show_infownd(param1:LevelObject) : void
      {
         if(param1 as BaseBuilding && (param1 as BaseBuilding).is_demand())
         {
            return;
         }
         if(m_fog.hit_test(param1.x,param1.y))
         {
            return;
         }
         if(!m_infownd_layer.contains(m_infownd))
         {
            m_infownd.x = param1.x;
            m_infownd.y = param1.y - 50 + param1.infownd_yoffset();
            m_infownd_layer.addChild(m_infownd);
            m_infownd.set_info(param1.uses_num(),param1.gives_num(),param1.uses_res(),param1.gives_res(),param1.get_name(),param1.get_progress());
         }
      }
      
      public static function use_resource(param1:int, param2:int) : void
      {
         m_resources[param1] = m_resources[param1] - param2;
         GameScreen.update_resources(m_resources);
         update_objects_overs();
      }
      
      public static function get_resource_num(param1:int) : int
      {
         return m_resources[param1];
      }
      
      public static function create_resource(param1:String, param2:int, param3:int, param4:BaseBuilding) : void
      {
         var random_uid:String = null;
         var object:LevelObject = null;
         var node_strid:String = param1;
         var prod_res:int = param2;
         var res_num:int = param3;
         var buiding:BaseBuilding = param4;
         var generateRandomString:Function = function(param1:Number):String
         {
            var _loc3_:Array = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split("");
            var _loc4_:String = "";
            var _loc5_:Number = 0;
            while(_loc5_ < param1)
            {
               _loc4_ = _loc4_ + _loc3_[Math.floor(Math.random() * _loc3_.length)];
               _loc5_++;
            }
            return _loc4_;
         };
         var node:PFNode = m_graph.get_node(m_graph.strid2uid(node_strid));
         if(node)
         {
            node.set_passable(false);
            random_uid = generateRandomString(32);
            object = ProdResourceFactory.create(prod_res,m_objects_layer,node.pos().x,node.pos().y,res_num,node.strid(),buiding);
            m_objects[random_uid] = object;
            object.set_uid(random_uid);
            update_objects_overs();
         }
         m_graph.redraw_canvas();
      }
      
      public static function show_object(param1:String) : void
      {
         m_objects[param1].show();
      }
      
      public static function object_visible(param1:String) : Boolean
      {
         return (m_objects[param1] as LevelObject).is_visible();
      }
      
      public static function object_repaired(param1:String) : Boolean
      {
         var _loc2_:RepairableObject = m_objects[param1] as RepairableObject;
         if(_loc2_)
         {
            return _loc2_.repaired();
         }
         return false;
      }
      
      public static function hide_infownd() : void
      {
         if(m_infownd_layer.contains(m_infownd))
         {
            m_infownd_layer.removeChild(m_infownd);
         }
      }
      
      public static function on_artefact_click() : void
      {
         SndMgr.PlaySound("artefact");
         m_explorer.fly_from(m_artefact.x,m_artefact.y);
         m_artefact = null;
      }
      
      public static function on_object_click(param1:LevelObject) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:Worker = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:PFNode = null;
         if(param1.get_uid() == "&camp")
         {
            return;
         }
         if(param1.accessable())
         {
            _loc2_ = false;
            if(m_tasks_queue.length == 0)
            {
               _loc3_ = 0;
               while(_loc3_ < m_workers.length)
               {
                  _loc4_ = m_workers[_loc3_];
                  if(_loc4_.ready_for_task())
                  {
                     if(!(param1.uses_num() > 0 && _loc4_.is_visible()))
                     {
                        _loc5_ = m_graph.strid2uid("&camp");
                        if(_loc4_.is_visible())
                        {
                           _loc5_ = m_graph.get_nearest_node(_loc4_.get_next_path_pos().x,_loc4_.get_next_path_pos().y);
                        }
                        _loc6_ = m_graph.strid2uid(param1.get_nodeid());
                        _loc7_ = m_graph.get_path(_loc5_,_loc6_);
                        if(_loc7_)
                        {
                           _loc8_ = new Array();
                           for each(_loc9_ in _loc7_)
                           {
                              _loc10_ = m_graph.get_node(_loc9_);
                              _loc8_.push(new Point(_loc10_.pos().x,_loc10_.pos().y));
                           }
                        }
                        if(!_loc4_.is_visible())
                        {
                           _loc4_.x = m_graph.get_node(_loc5_).pos().x;
                           _loc4_.y = m_graph.get_node(_loc5_).pos().y;
                        }
                        else
                        {
                           _loc8_.shift();
                        }
                        _loc4_.run(_loc8_,param1,param1.uses_num() > 0);
                        _loc2_ = true;
                        break;
                     }
                  }
                  _loc3_++;
               }
            }
            if(!_loc2_)
            {
               m_tasks_queue.push(param1);
            }
            if(param1.uses_num() > 0 && param1.uses_res() != ResType.NONE)
            {
               m_resources[param1.uses_res()] = m_resources[param1.uses_res()] - param1.uses_num();
               GameScreen.update_resources(m_resources);
               update_objects_overs();
            }
         }
      }
      
      public static function on_worker_leave(param1:Worker) : void
      {
         var _loc3_:LevelObject = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:PFNode = null;
         var _loc2_:LevelObject = m_objects[param1.get_target().get_uid()];
         _loc2_.on_worker_leave(param1);
         if(param1.ready_for_task() && m_tasks_queue.length > 0)
         {
            _loc3_ = m_tasks_queue.shift();
            if(_loc3_.uses_num() == 0)
            {
               _loc4_ = m_graph.get_nearest_node(param1.x,param1.y);
               _loc5_ = m_graph.strid2uid(_loc3_.get_nodeid());
               _loc6_ = m_graph.get_path(_loc4_,_loc5_);
               if(_loc6_)
               {
                  _loc7_ = new Array();
                  for each(_loc8_ in _loc6_)
                  {
                     _loc9_ = m_graph.get_node(_loc8_);
                     _loc7_.push(new Point(_loc9_.pos().x,_loc9_.pos().y));
                  }
                  param1.run(_loc7_,_loc3_,_loc3_.uses_num() > 0);
               }
               return;
            }
            m_tasks_queue.unshift(_loc3_);
         }
      }
      
      public static function on_worker_arrive(param1:Worker) : void
      {
         var _loc4_:LevelObject = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:PFNode = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:int = 0;
         var _loc17_:PFNode = null;
         var _loc2_:LevelObject = m_objects[param1.get_target().get_uid()];
         if(_loc2_.uses_num() && _loc2_.uses_res() == ResType.WATER)
         {
            SndMgr.PlaySound("water_shsh");
         }
         var _loc3_:* = _loc2_.uses_num() > 0;
         _loc2_.on_worker_visit(param1);
         if(_loc2_.get_owner())
         {
            _loc2_.get_owner().on_resource_pickedup();
         }
         if(!_loc3_ && !_loc2_.uses_num() && _loc2_.gives_num() && _loc2_.get_uid() != "camp")
         {
            if(m_resources[_loc2_.gives_res()] < 0)
            {
               m_resources[_loc2_.gives_res()] = 0;
            }
            m_resources[_loc2_.gives_res()] = m_resources[_loc2_.gives_res()] + _loc2_.gives_num();
            GameScreen.update_resources(m_resources);
            update_objects_overs();
            if(_loc2_ as DestroyableObject == null)
            {
               SndMgr.PlaySound("resource");
            }
         }
         if(param1.get_target().get_uid() == "camp")
         {
            param1.hide();
            SndMgr.PlaySound("worker_in");
            if(m_tasks_queue.length > 0)
            {
               _loc4_ = m_tasks_queue.shift();
               _loc5_ = m_graph.strid2uid("&camp");
               _loc6_ = m_graph.strid2uid(_loc4_.get_nodeid());
               _loc7_ = m_graph.get_path(_loc5_,_loc6_);
               if(_loc7_)
               {
                  _loc8_ = new Array();
                  for each(_loc9_ in _loc7_)
                  {
                     _loc10_ = m_graph.get_node(_loc9_);
                     _loc8_.push(new Point(_loc10_.pos().x,_loc10_.pos().y));
                  }
                  param1.run(_loc8_,_loc4_,_loc4_.uses_num() > 0);
               }
               return;
            }
         }
         else
         {
            _loc11_ = param1.get_target().get_nodeid();
            _loc12_ = m_graph.strid2uid(_loc11_);
            _loc13_ = m_graph.strid2uid("&camp");
            _loc14_ = m_graph.get_path(_loc12_,_loc13_);
            if(_loc14_)
            {
               _loc15_ = new Array();
               for each(_loc16_ in _loc14_)
               {
                  _loc17_ = m_graph.get_node(_loc16_);
                  _loc15_.push(new Point(_loc17_.pos().x,_loc17_.pos().y));
               }
            }
            param1.run(_loc15_,m_objects["camp"],param1.is_carrying());
         }
         on_worker_leave(param1);
      }
      
      public static function add_worker() : void
      {
         var _loc2_:LevelObject = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:PFNode = null;
         var _loc1_:Worker = new Worker(m_workers_layer);
         m_resources[ResType.WORKER]++;
         m_workers.push(_loc1_);
         GameScreen.update_resources(m_resources);
         update_objects_overs();
         if(m_tasks_queue.length > 0)
         {
            _loc2_ = m_tasks_queue.shift();
            _loc3_ = m_graph.strid2uid("&camp");
            _loc4_ = m_graph.strid2uid(_loc2_.get_nodeid());
            _loc5_ = m_graph.get_path(_loc3_,_loc4_);
            if(_loc5_)
            {
               _loc6_ = new Array();
               for each(_loc7_ in _loc5_)
               {
                  _loc8_ = m_graph.get_node(_loc7_);
                  _loc6_.push(new Point(_loc8_.pos().x,_loc8_.pos().y));
               }
               _loc1_.x = m_graph.get_node(_loc3_).pos().x;
               _loc1_.y = m_graph.get_node(_loc3_).pos().y;
               _loc1_.run(_loc6_,_loc2_,_loc2_.uses_num() > 0);
            }
         }
      }
      
      public static function set_node_passable(param1:String) : void
      {
         m_graph.get_node(m_graph.strid2uid(param1)).set_passable(true);
         m_graph.redraw_canvas();
         update_objects_overs();
      }
      
      public static function set_node_unpassable(param1:String) : void
      {
         m_graph.get_node(m_graph.strid2uid(param1)).set_passable(false);
         m_graph.redraw_canvas();
         update_objects_overs();
      }
      
      public static function current_level_num() : int
      {
         return m_num;
      }
      
      private static function on_click(param1:MouseEvent) : void
      {
      }
      
      public static function pause() : void
      {
         m_paused = true;
      }
      
      public static function unpause() : void
      {
         m_paused = false;
      }
      
      public static function on_enter_frame(param1:Event) : void
      {
         var _loc3_:LevelObject = null;
         var _loc4_:Worker = null;
         if(m_paused)
         {
            return;
         }
         var _loc2_:Number = 1 / m_this.stage.frameRate;
         m_time_cur = m_time_cur + _loc2_;
         GameScreen.update_timebar(m_time_cur / m_time_max);
         for each(_loc3_ in m_objects)
         {
            if(_loc3_.is_visible() || _loc3_.is_reshowable())
            {
               _loc3_.quant(_loc2_);
            }
         }
         m_explorer.quant(_loc2_);
         if(m_artefact)
         {
            m_artefact.quant(_loc2_);
         }
         for each(_loc4_ in m_workers)
         {
            if(_loc4_.is_visible())
            {
               _loc4_.quant(_loc2_);
            }
         }
      }
      
      public static function on_win() : void
      {
         var _loc11_:Bitmap = null;
         SndMgr.PlaySound("tasks_complete");
         SndMgr.Stop("main_music");
         pause();
         var _loc1_:Boolean = m_time_cur > m_time_max * 0.67 && m_time_cur < m_time_max;
         var _loc2_:* = m_time_cur < m_time_max * 0.67;
         var _loc3_:int = 0;
         if(_loc2_)
         {
            _loc3_ = 5000;
         }
         if(_loc1_)
         {
            _loc3_ = 1000;
         }
         var _loc4_:int = 0;
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < m_resources.length)
         {
            if(!(_loc6_ == ResType.WORKER || _loc6_ == ResType.DIAMONDS))
            {
               if(m_resources[_loc6_] >= 0)
               {
                  _loc4_ = _loc4_ + m_resources[_loc6_] * 100;
                  _loc11_ = ResType.new_icon(_loc6_);
                  _loc5_.push(_loc11_);
               }
            }
            _loc6_++;
         }
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < 6)
         {
            if(_loc8_ != m_num)
            {
               _loc7_ = _loc7_ + Save.level_get_scores(_loc8_);
            }
            _loc8_++;
         }
         var _loc9_:int = 900 + Math.random() * 100;
         _loc7_ = _loc7_ + (_loc9_ + _loc4_ + _loc3_);
         Save.new_total_score(_loc7_);
         var _loc10_:int = 0;
         if(m_artefact == null)
         {
            _loc10_ = 1;
         }
         LevelFinishing.show(m_num,_loc9_,_loc4_,_loc5_,m_resources[ResType.DIAMONDS],_loc3_,_loc7_,_loc10_,m_time_cur,_loc1_,_loc2_);
      }
      
      public static function get_pbar_layer() : Sprite
      {
         return m_pbars_layer;
      }
   }
}
