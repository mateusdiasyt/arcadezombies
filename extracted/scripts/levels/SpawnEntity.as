package levels
{
   import entities.zombies.*;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import utils.ZombieList;
   
   public class SpawnEntity extends Entity
   {
      
      private var between_levels:Number = 0;
      
      public var level:Levels = null;
      
      private var pushed_spawn_level:int = -1;
      
      private var spawned_level:int = -1;
      
      private var _done_spawning:Boolean = false;
      
      private var _win_timer:Number = 0;
      
      public var current_level:Wave = null;
      
      public function SpawnEntity()
      {
         super();
         Globals.zombies = new ZombieList();
         if(Globals.rank <= Const.BRONZE)
            this.level = new EasySpawns();
         else if(Globals.rank <= Const.SILVER)
            this.level = new NormalSpawns();
         else if(Globals.rank <= Const.GOLD)
            this.level = new HardSpawns();
         else
            this.level = new InsaneSpawns();
         Globals.score.level = 0;
         Globals.score.max_level = this.level.waves.length;
      }
      
      override public function update() : void
      {
         if(!this._done_spawning)
         {
            this.between_levels += FP.elapsed * Globals.speed;
            if(this.spawned_level + 1 < this.level.max_level)
            {
               if(this.pushed_spawn_level > this.spawned_level)
               {
                  ++Globals.score.level;
                  ++this.spawned_level;
                  FP.world.add(this.current_level = this.level.waves[0]);
                  this.level.waves.splice(0,1);
               }
               if(this.between_levels >= this.level.between_levels)
               {
                  ++this.pushed_spawn_level;
                  this.between_levels = 0;
               }
            }
            else if(Globals.zombies.length == 0 && Globals.score.level == this.level.max_level && this.current_level.spawnComplete())
            {
               this._win_timer += FP.elapsed;
               if(this._win_timer > 0.5 && Globals.score.lives > 0)
               {
                  this.win();
               }
            }
         }
         super.update();
      }
      
      public function doneSpawning() : Boolean
      {
         if(this.spawned_level >= 0)
         {
            return this.current_level.spawnComplete();
         }
         return true;
      }
      
      public function win() : void
      {
         this._done_spawning = true;
         Globals.win();
      }
      
      public function get timeRemaining() : String
      {
         return "" + Math.round(this.level.between_levels - this.between_levels);
      }
      
      public function get percentRemaining() : Number
      {
         var t:Number = (this.level.between_levels - this.between_levels) / this.level.between_levels;
         if(t < 0)
         {
            t = 0;
         }
         return t;
      }
      
      public function spawnTo(level:int) : void
      {
         this.pushed_spawn_level = level;
         this.between_levels = 0;
      }
   }
}

