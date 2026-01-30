package entities.zombies
{
   import entities.ZombieEntity;
   
   public class HammerTimeBoss extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_hammer_time;
      
      public static const PORTRAIT_INDEX:int = 21;
      
      public function HammerTimeBoss(level:Number = 1, modifier:Number = 1, called_early:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 48 * 0.8;
         this.health = 400 * modifier;
         this.total_health = 400 * modifier;
         this.armor = 4 * Math.sqrt(modifier);
         if(this.armor > 28)
         {
            this.armor = 28;
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
         image.add(Const.WALK,[42,43,44,45],5);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[42 + 60,43 + 60,44 + 60,45 + 60],5);
         this.hittable = true;
         image.add(Const.HIT1,[46,47,42,42,42],8);
         image.add(Const.HIT2,[47,46,42,42,42],8);
         image.add(Const.FROZEN_HIT1,[46 + 60,47 + 60,42 + 60,42 + 60,42 + 60],8);
         image.add(Const.FROZEN_HIT2,[47 + 60,46 + 60,42 + 60,42 + 60,42 + 60],8);
      }
   }
}

