package entities.zombies
{
   import entities.ZombieEntity;
   
   public class StrongZombie extends ZombieEntity
   {
      
      public static var NAME:String = Localizer.Instance.zombie_strong;
      
      public static const PORTRAIT_INDEX:int = 3;
      
      public function StrongZombie(level:Number = 1, modifier:Number = 1, called_early:Number = 1)
      {
         super();
         this.level = level;
         this.name = NAME;
         this.portrait_index = PORTRAIT_INDEX;
         this.speed = 36 * 0.8;
         this.health = 35 * modifier;
         this.total_health = 35 * modifier;
         this.armor = 2 * Math.sqrt(modifier);
         if(this.armor > 20)
         {
            this.armor = 20;
         }
         this.score = 2 * modifier;
         if(this.score < 1)
         {
            this.score = 1;
         }
         this.bounty = Math.floor(Math.pow(this.level,0.46)) + Math.ceil(level / 15);
         if(this.level > 40)
         {
            this.bounty += Math.pow(this.level - 40,0.5);
         }
         this.flying = false;
         this.invisible = false;
         this.image.originX = this.image.width / 2;
         this.image.originY = this.image.height / 2;
         this.gl.add(image);
         this.graphic = gl;
         image.add(Const.WALK,[6,7,8,7,6,7,8,7,9,9,9],3);
         image.play(Const.WALK,true);
         image.add(Const.FROZEN_WALK,[6 + 60,7 + 60,8 + 60,7 + 60,6 + 60,7 + 60,8 + 60,7 + 60,9 + 60,9 + 60,9 + 60],3);
         this.hittable = true;
         image.add(Const.HIT1,[10,11,6,6,6],8);
         image.add(Const.HIT2,[11,10,6,6,6],8);
         image.add(Const.FROZEN_HIT1,[10 + 60,11 + 60,6 + 60,6 + 60,6 + 60],8);
         image.add(Const.FROZEN_HIT2,[11 + 60,10 + 60,6 + 60,6 + 60,6 + 60],8);
      }
   }
}

