package entities.zombies
{
   import entities.ZombieEntity;
   
   public class ProjectXBoss extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_project_x;
      
      public static const PORTRAIT_INDEX:int = 24;
      
      public function ProjectXBoss(level:Number = 1, modifier:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 36 * 0.8;
         this.health = 300 * modifier;
         this.total_health = 300 * modifier;
         this.armor = 6 * modifier;
         if(this.armor > 35)
         {
            this.armor = 35;
         }
         this.score = 20 * modifier;
         if(this.score < 1)
         {
            this.score = 1;
         }
         this.bounty = 10 + Math.floor(this.level / 10) * 10;
         this.flying = false;
         this.invisible = false;
         this.image.originX = this.image.width / 2;
         this.image.originY = this.image.height / 2;
         this.gl.add(image);
         this.graphic = gl;
         image.add(Const.WALK,[48,49,50,51],5);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[48 + 60,49 + 60,50 + 60,51 + 60],5);
         this.hittable = true;
         image.add(Const.HIT1,[52,53,48,48,48],8);
         image.add(Const.HIT2,[53,52,48,48,48],8);
         image.add(Const.FROZEN_HIT1,[52 + 60,53 + 60,48 + 60,48 + 60,48 + 60],8);
         image.add(Const.FROZEN_HIT2,[53 + 60,52 + 60,48 + 60,48 + 60,48 + 60],8);
      }
   }
}

