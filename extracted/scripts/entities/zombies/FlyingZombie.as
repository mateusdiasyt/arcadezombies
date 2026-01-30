package entities.zombies
{
   import entities.ZombieEntity;
   
   public class FlyingZombie extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_flying;
      
      public static const PORTRAIT_INDEX:int = 15;
      
      public function FlyingZombie(level:Number = 1, modifier:Number = 1, called_early:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 56 * 0.8;
         this.health = 20 * modifier;
         this.total_health = 20 * modifier;
         this.armor = 0;
         if(modifier >= 6)
         {
            this.armor = 0.17 * modifier;
         }
         if(this.armor > 5)
         {
            this.armor = 5;
         }
         this.score = 1.2 * modifier;
         if(this.score < 1)
         {
            this.score = 1;
         }
         this.bounty = Math.floor(Math.pow(this.level,0.46));
         if(this.level > 40)
         {
            this.bounty += Math.pow(this.level - 40,0.5);
         }
         this.flying = true;
         this.invisible = false;
         this.image.originX = this.image.width / 2;
         this.image.originY = this.image.height / 2;
         this.gl.add(image);
         this.graphic = gl;
         image.add(Const.WALK,[30,31,32,33],7);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[30 + 60,31 + 60,32 + 60,33 + 60],8);
         this.hittable = true;
         image.add(Const.HIT1,[34,35,30,30,30],8);
         image.add(Const.HIT2,[35,34,30,30,30],8);
         image.add(Const.FROZEN_HIT1,[34 + 60,35 + 60,30 + 60,30 + 60,30 + 60],8);
         image.add(Const.FROZEN_HIT2,[35 + 60,34 + 60,30 + 60,30 + 60,30 + 60],8);
      }
   }
}

