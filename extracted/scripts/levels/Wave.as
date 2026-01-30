package levels
{
   import entities.ZombieEntity;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   
   public class Wave extends Entity
   {
      
      public var count:int = 0;
      
      public var modifier:Number = 0;
      
      protected var spawn_count:int = 0;
      
      private var timer:Number = 0;
      
      private var between_spawns:Number = 1;
      
      private var _spawnType:Class = null;
      
      public var called_early:Number = 1;
      
      protected var level:int = 0;
      
      public function Wave(level:int, count:int, spawnType:Class, modifier:Number = 1, between_spawns:Number = 1)
      {
         super();
         this.level = level;
         this.count = count;
         this._spawnType = spawnType;
         this.modifier = modifier;
         this.between_spawns = between_spawns;
         this.init();
      }
      
      protected function init() : void
      {
      }
      
      public function get portrait_index() : int
      {
         return this._spawnType.PORTRAIT_INDEX;
      }
      
      public function get wave_name() : String
      {
         return this._spawnType.NAME;
      }
      
      override public function added() : void
      {
         SoundManager.playSound(Assets.SFX_NEW_WAVE);
         super.added();
      }
      
      override public function removed() : void
      {
         super.removed();
      }
      
      override public function update() : void
      {
         if(this.spawn_count < this.count)
         {
            this.timer += FP.elapsed * Globals.speed;
            if(this.timer >= this.between_spawns)
            {
               this.timer = 0;
               ++this.spawn_count;
               this.spawnZombie();
            }
         }
         else
         {
            FP.world.remove(this);
         }
         super.update();
      }
      
      public function spawnComplete() : Boolean
      {
         return this.spawn_count >= this.count;
      }
      
      public function getSpawnType(count:Number) : ZombieEntity
      {
         var mult:Number = Const.getDifficultyMultiplierForRank(Globals.rank);
         return new this._spawnType(this.level,this.modifier * mult);
      }
      
      public function spawnZombie() : void
      {
         var z:ZombieEntity = this.getSpawnType(this.spawn_count);
         z.called_early = this.called_early;
         FP.world.add(z);
         Globals.zombies.add(z);
      }
   }
}

