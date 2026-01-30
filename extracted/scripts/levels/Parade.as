package levels
{
   import entities.ZombieEntity;
   import entities.zombies.DevilishBoss;
   import entities.zombies.HammerTimeBoss;
   import entities.zombies.ProjectXBoss;
   
   public class Parade extends Wave
   {
      
      public function Parade(level:int, c:Number, m:Number = 1, b:Number = 1)
      {
         super(level,c,null,m,b);
      }
      
      override protected function init() : void
      {
      }
      
      override public function get wave_name() : String
      {
         return "Zombie Parade";
      }
      
      override public function get portrait_index() : int
      {
         return 30;
      }
      
      override public function getSpawnType(count:Number) : ZombieEntity
      {
         switch(count % 3)
         {
            case 0:
               return new DevilishBoss(this.level,this.modifier);
            case 1:
               return new HammerTimeBoss(this.level,this.modifier);
            case 2:
               return new ProjectXBoss(this.level,this.modifier);
            default:
               return new HammerTimeBoss(this.level,this.modifier);
         }
      }
   }
}

