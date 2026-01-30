package
{
   import achievements.Tracker;
   import entities.BloodSplatter;
   import entities.Container;
   import entities.EffectEmitter;
   import entities.GameOverWindow;
   import entities.HUDEntity;
   import entities.HealthBarEntity;
   import entities.MapEntity;
   import entities.RangeCircle;
   import entities.Score;
   import entities.TimeLine;
   import entities.TowerEntity;
   import entities.YouWinWindow;
   import entities.menu.HelpMenu;
   import entities.menu.OptionsMenu;
   import entities.menu.TowerMenu;
   import entities.menu.ZombieInfoMenu;
   import flash.net.SharedObject;
   import levels.SpawnEntity;
   import net.flashpunk.FP;
   import utils.ZombieList;
   import worlds.AchievementsWorld;
   import worlds.CreditsWorld;
   import worlds.DifficultyWorld;
   import worlds.GameWorld;
   import worlds.ScoresWorld;
   import worlds.StartWorld;
   
   public class Globals
   {
      
      public static var tracker:Tracker;
      
      public static var optionsMenu:OptionsMenu;
      
      public static var health_bars:HealthBarEntity;
      
      public static var range_circle:RangeCircle;
      
      public static var zombie_info:ZombieInfoMenu;
      
      public static var stats:HelpMenu;
      
      public static var towers:Array = new Array();
      
      public static var difficulty:Number = Const.EASY;
      
      /** PDL do ranking (0-3200). Persistido em SharedObject. */
      public static var pdl:Number = 0;
      
      /** Elo atual derivado do PDL (Const.BRONZE .. Const.MASTER). */
      public static var rank:Number = Const.BRONZE;
      
      private static const PDL_SO_NAME:String = "zombie_td_pdl";
      
      private static var _pdlShared:SharedObject = null;
      
      private static function getPdlShared() : SharedObject
      {
         if(_pdlShared == null)
            _pdlShared = SharedObject.getLocal(PDL_SO_NAME);
         return _pdlShared;
      }
      
      /** Carrega PDL do disco e atualiza rank. Chamar no início do jogo. */
      public static function loadPDL() : void
      {
         var so:SharedObject = getPdlShared();
         if(so.data.pdl != undefined)
            pdl = Number(so.data.pdl);
         else
            pdl = 0;
         if(pdl < 0) pdl = 0;
         if(pdl > 3200) pdl = 3200;
         rank = Const.getRankFromPDL(pdl);
      }
      
      /** Adiciona PDL (positivo ou negativo), persiste e atualiza rank. */
      public static function addPDL(delta:int) : void
      {
         pdl += delta;
         if(pdl < 0) pdl = 0;
         if(pdl > 3200) pdl = 3200;
         rank = Const.getRankFromPDL(pdl);
         getPdlShared().data.pdl = pdl;
         getPdlShared().flush();
      }
      
      /** Atualiza rank a partir do PDL atual. */
      public static function updateRankFromPDL() : void
      {
         rank = Const.getRankFromPDL(pdl);
      }
      
      public static var paused:Boolean = false;
      
      public static var floorTiles:String = "1";
      
      public static var map:MapEntity = null;
      
      public static var selected_tower:TowerEntity = null;
      
      public static var score:Score = null;
      
      public static var zombies:ZombieList = null;
      
      public static var splatter:BloodSplatter = null;
      
      public static var effects:EffectEmitter = null;
      
      public static var spawns:SpawnEntity = null;
      
      public static var timeline:TimeLine = null;
      
      public static var speed:Number = 1;
      
      public static var placing_tower:TowerEntity = null;
      
      public static var end_screen:Container = null;
      
      public static var escape_timer:Number = 0;
      
      public static var show_end_screen:Boolean = false;
      
      public static var easyScores:String = "";
      
      public static var normalScores:String = "";
      
      public static var hardScores:String = "";
      
      public static var hellScores:String = "";
      
      public static var hud:HUDEntity = null;
      
      public static var grand_total:Number = 0;
      
      public static var tower_menu:TowerMenu = null;
      
      public static var start_world:StartWorld = null;
      
      public static var difficulty_world:DifficultyWorld = null;
      
      public static var achievement_world:AchievementsWorld = null;
      
      public static var credits_world:CreditsWorld = null;
      
      public static var scores_world:ScoresWorld = null;
      
      public static var game_world:GameWorld = null;
      
      public static var total_money:int = 0;
      
      public function Globals()
      {
         super();
      }
      
      public static function addTowerMenu(target:TowerEntity) : void
      {
         if(tower_menu == null)
         {
            tower_menu = new TowerMenu(target);
         }
         else
         {
            FP.world.remove(tower_menu);
            tower_menu.target = target;
         }
         FP.world.add(tower_menu);
      }
      
      public static function removeTowerMenu(target:TowerEntity) : void
      {
         if(Boolean(tower_menu) && tower_menu.target == target)
         {
            FP.world.remove(tower_menu);
         }
      }
      
      public static function showStartWorld(force:Boolean = false) : void
      {
         if(start_world == null || force)
         {
            start_world = new StartWorld();
         }
         FP.world = start_world;
      }
      
      public static function showDifficultyWorld() : void
      {
         if(difficulty_world == null)
         {
            difficulty_world = new DifficultyWorld();
         }
         FP.world = difficulty_world;
      }
      
      public static function showAchievementsWorld() : void
      {
         if(achievement_world == null)
         {
            achievement_world = new AchievementsWorld();
         }
         FP.world = achievement_world;
      }
      
      public static function showCreditsWorld() : void
      {
         if(credits_world == null)
         {
            credits_world = new CreditsWorld();
         }
         FP.world = credits_world;
      }
      
      public static function showScoresWorld() : void
      {
         if(scores_world == null)
         {
            scores_world = new ScoresWorld();
         }
         FP.world = scores_world;
      }
      
      public static function showGameWorld() : void
      {
         if(game_world == null)
         {
            game_world = new GameWorld();
         }
         FP.world = game_world;
      }
      
      public static function resetWorlds() : void
      {
         game_world = null;
         credits_world = null;
         difficulty_world = null;
         hud = null;
         zombie_info = null;
      }
      
      public static function addTower(t:TowerEntity) : void
      {
         towers.push(t);
      }
      
      public static function removeTower(t:TowerEntity) : void
      {
         for(var i:int = 0; i < towers.length; i++)
         {
            if(towers[i] == t)
            {
               towers.splice(i,1);
               return;
            }
         }
      }
      
      public static function randRange(min:Number, max:Number) : Number
      {
         return Math.random() * (max - min) + min;
      }
      
      public static function win() : void
      {
         var t:TowerEntity = null;
         for each(t in Globals.towers)
         {
            Globals.score.tower_score += t.cost;
         }
         Globals.grand_total = Globals.score.score + Globals.score.money + Globals.score.tower_score + Globals.score.lives * 100;
         Globals.end_screen = new YouWinWindow();
      }
      
      public static function lose() : void
      {
         Globals.end_screen = new GameOverWindow();
      }
      
      public static function hideRangeCircles() : void
      {
         var t:TowerEntity = null;
         if(Boolean(tower_menu) && Boolean(tower_menu.target))
         {
            removeTowerMenu(tower_menu.target);
         }
         for each(t in towers)
         {
            t.hideRangeCircle();
            t.hideHoverWindow();
         }
      }
   }
}

