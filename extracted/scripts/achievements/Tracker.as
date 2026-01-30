package achievements
{
   import flash.net.SharedObject;
   
   public class Tracker
   {
      
      public static const ZOMBIES_KILLED:String = "Zombies Killed";
      
      public static const ZOMBIES_FROZEN:String = "Zombies Frozen";
      
      public static const ZOMBIES_BURNED:String = "Zombies Burned";
      
      public static const ZOMBIES_STUNNED:String = "Zombies Stunned";
      
      public static const HIGHEST_SCORE:String = "Highest Score";
      
      public static const EARLY_WAVE:String = "Early Wave";
      
      public static const EASY_WINS:String = "Easy Win";
      
      public static const NORMAL_WINS:String = "Normal Win";
      
      public static const HARD_WINS:String = "Hard Win";
      
      public static const INSANE_WINS:String = "Insane Win";
      
      public static const HIGHEST_EASY_SCORE:String = "Highest Easy Score";
      
      public static const HIGHEST_NORMAL_SCORE:String = "Highest Normal Score";
      
      public static const HIGHEST_HARD_SCORE:String = "Highest Hard Score";
      
      public static const HIGHEST_INSANE_SCORE:String = "Highest Insane Score";
      
      public static const HIGHEST_EASY_WIN_SCORE:String = "Highest Easy Win Score";
      
      public static const HIGHEST_NORMAL_WIN_SCORE:String = "Highest Normal Win Score";
      
      public static const HIGHEST_HARD_WIN_SCORE:String = "Highest Hard Win Score";
      
      public static const HIGHEST_INSANE_WIN_SCORE:String = "Highest Insane Win Score";
      
      public static const TIME_PLAYED:String = "Time Played";
      
      public static const MONEY_SPENT:String = "Money Spent";
      
      public static const MONEY_EARNED:String = "Money Earned";
      
      public static const TOWERS_PURCHASED:String = "Towers Purchased";
      
      public static const TOWERS_UPGRADED:String = "Towers Upgraded";
      
      public static const TOWERS_SOLD:String = "Towers Sold";
      
      public static const BOMB_LEVEL_5:String = "Bomb Level 5";
      
      public static const FIRE_LEVEL_5:String = "Fire Level 5";
      
      public static const ICE_LEVEL_5:String = "Ice Level 5";
      
      public static const LASER_LEVEL_5:String = "Laser Level 5";
      
      public static const BUZZSAW_LEVEL_5:String = "Buzzsaw Level 5";
      
      public static const RAPID_LEVEL_5:String = "Rapid Level 5";
      
      public static const SAM_LEVEL_5:String = "SAM Level 5";
      
      public static const SENSOR_LEVEL_5:String = "Sensor Level 5";
      
      public static const SENTRY_LEVEL_5:String = "Sentry Level 5";
      
      public static const MUSIC_VOLUME:String = "Music Volume";
      
      public static const SFX_VOLUME:String = "SFX Volume";
      
      public static const MUSIC_MUTED:String = "Music Mute";
      
      public static const SFX_MUTED:String = "SFX Mute";
      
      private var shared:SharedObject = null;
      
      private var registered_achievements:Array = new Array();
      
      public function Tracker()
      {
         super();
         this.shared = SharedObject.getLocal("data");
      }
      
      public function getData(type:String) : *
      {
         return this.shared.data[type];
      }
      
      public function getNumber(type:String) : Number
      {
         if(this.shared.data[type] == undefined)
         {
            return Number.NEGATIVE_INFINITY;
         }
         return this.shared.data[type] as Number;
      }
      
      public function getBoolean(type:String) : Boolean
      {
         if(this.shared.data[type] == undefined)
         {
            return false;
         }
         return this.shared.data[type] as Boolean;
      }
      
      public function setData(type:String, value:*) : void
      {
         this.shared.data[type] = value;
         this.checkAchievements();
      }
      
      public function setHighest(type:String, value:Number) : void
      {
         if(this.shared.data[type] == undefined)
         {
            this.shared.data[type] = value;
            this.checkAchievements();
         }
         else if(value > this.shared.data[type])
         {
            this.shared.data[type] = value;
            this.checkAchievements();
         }
      }
      
      public function incrementData(type:String, amount:Number = 1) : void
      {
         if(this.shared.data[type] == undefined)
         {
            this.shared.data[type] = amount;
         }
         else
         {
            this.shared.data[type] += amount;
         }
         this.checkAchievements();
      }
      
      public function registerAchievement(a:Achievement) : void
      {
         this.registered_achievements.push(a);
      }
      
      public function checkAchievements() : void
      {
         var a:Achievement = null;
         for each(a in this.registered_achievements)
         {
            a.check();
         }
      }
      
      public function getAchievements() : Array
      {
         return this.registered_achievements;
      }
      
      public function flush() : void
      {
         this.shared.flush();
      }
      
      public function reset() : void
      {
         this.shared.clear();
         this.shared.flush();
      }
      
      public function hasAchievement(achievement:Class) : Boolean
      {
         var a:Achievement = null;
         for each(a in this.registered_achievements)
         {
            if(a is achievement)
            {
               return a.achieved;
            }
         }
         return false;
      }
      
      public function setupAchievements() : void
      {
         this.registered_achievements = [];
         this.registerAchievement(new TimePlayed30Achievement());
         this.registerAchievement(new TimePlayed60Achievement());
         this.registerAchievement(new TimePlayed120Achievement());
         this.registerAchievement(new Killer50Achievement());
         this.registerAchievement(new Killer250Achievement());
         this.registerAchievement(new Killer1000Achievement());
         this.registerAchievement(new BurnAchievement());
         this.registerAchievement(new FreezeAchievement());
         this.registerAchievement(new StunAchievement());
         this.registerAchievement(new Towers10Achievement());
         this.registerAchievement(new Towers25Achievement());
         this.registerAchievement(new Towers50Achievement());
         this.registerAchievement(new Score1Achievement());
         this.registerAchievement(new Score2Achievement());
         this.registerAchievement(new Score3Achievement());
         this.registerAchievement(new EarlyWaves20Achievement());
         this.registerAchievement(new EarlyWaves50Achievement());
         this.registerAchievement(new EarlyWaves100Achievement());
         this.registerAchievement(new Spend500Achievement());
         this.registerAchievement(new Spend1000Achievement());
         this.registerAchievement(new Spend2500Achievement());
         this.registerAchievement(new SentryTower5Achievement());
         this.registerAchievement(new BombTower5Achievement());
         this.registerAchievement(new SAMTower5Achievement());
         this.registerAchievement(new SensorTower5Achievement());
         this.registerAchievement(new IceTower5Achievement());
         this.registerAchievement(new FireTower5Achievement());
         this.registerAchievement(new BuzzsawTower5Achievement());
         this.registerAchievement(new RapidTower5Achievement());
         this.registerAchievement(new LaserTower5Achievement());
         this.registerAchievement(new TowerChampAchievement());
         this.registerAchievement(new EasyBronzeAchievement());
         this.registerAchievement(new EasySilverAchievement());
         this.registerAchievement(new EasyGoldAchievement());
         this.registerAchievement(new NormalBronzeAchievement());
         this.registerAchievement(new NormalSilverAchievement());
         this.registerAchievement(new NormalGoldAchievement());
         this.registerAchievement(new HardBronzeAchievement());
         this.registerAchievement(new HardSilverAchievement());
         this.registerAchievement(new HardGoldAchievement());
         this.registerAchievement(new InsaneBronzeAchievement());
         this.registerAchievement(new InsaneSilverAchievement());
         this.registerAchievement(new InsaneGoldAchievement());
         this.registerAchievement(new BronzeChampAchievement());
         this.registerAchievement(new SilverChampAchievement());
         this.registerAchievement(new GoldChampAchievement());
         this.checkAchievements();
      }
      
      public function get achievementsTotal() : int
      {
         return this.registered_achievements.length;
      }
      
      public function get achievementsEarned() : int
      {
         var a:Achievement = null;
         var t:int = 0;
         for each(a in this.registered_achievements)
         {
            if(a.achieved)
            {
               t++;
            }
         }
         return t;
      }
   }
}

